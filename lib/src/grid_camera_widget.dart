import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

import 'grid_painter.dart';

/// A customizable camera widget with grid overlay functionality.
/// Supports different aspect ratios, grid configurations, and custom styling.
class GridCameraWidget extends StatefulWidget {
  /// Number of horizontal grid lines (rows - 1)
  final int rowCount;

  /// Number of vertical grid lines (columns - 1)
  final int columnCount;

  /// Color of the grid lines. Defaults to theme's primary color if not specified
  final Color? gridColor;

  /// Width of the grid lines
  final double gridWidth;

  /// Aspect ratio of the camera preview (width/height)
  final double aspectRatio;

  /// Custom text for error dialog title
  final String? otherExceptionTitleText;

  /// Custom text for error dialog confirmation button
  final String? otherExceptionOkayText;

  /// Custom text for error dialog message
  final String? otherExceptionBodyText;

  /// Custom widget to show when camera permission is denied
  final Widget? permissionDeniedWidget;

  /// Custom icon for the refresh button
  final Widget? refreshIcon;

  /// Custom icon for the done button
  final Widget? doneIcon;

  /// Custom icon for the capture button
  final Widget? clickPhotoIcon;

  /// Custom widget to show while camera is initializing
  final Widget? cameraLoadingWidget;

  /// Callback when camera access is denied
  final VoidCallback? onCameraAccessDenied;

  /// Callback for handling other exceptions
  final VoidCallback? onOtherException;

  /// Callback that provides the captured image as Uint8List
  final Function(Uint8List) onDonePressed;

  const GridCameraWidget({
    super.key,
    this.rowCount = 3,
    this.columnCount = 3,
    this.gridColor,
    this.gridWidth = 1.0,
    this.aspectRatio = 9 / 16,
    this.onCameraAccessDenied,
    this.onOtherException,
    this.otherExceptionTitleText,
    this.otherExceptionOkayText,
    this.otherExceptionBodyText,
    this.permissionDeniedWidget,
    this.refreshIcon,
    this.doneIcon,
    this.clickPhotoIcon,
    this.cameraLoadingWidget,
    required this.onDonePressed,
  });

  @override
  State<GridCameraWidget> createState() => _GridCameraWidgetState();
}

class _GridCameraWidgetState extends State<GridCameraWidget>
    with WidgetsBindingObserver {
  late final ScreenshotController _screenshotController;
  CameraController? _controller;
  List<CameraDescription> _cameras = [];
  File? _capturedImage;
  bool _isCameraPermissionGranted = true;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _screenshotController = ScreenshotController();
    WidgetsBinding.instance.addObserver(this);
    _initializeCamera();
  }

  @override
  void dispose() {
    _controller?.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    // Handle app lifecycle changes
    if (_controller == null || !_controller!.value.isInitialized) return;

    if (state == AppLifecycleState.inactive) {
      _controller?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _initializeCamera();
    }
  }

  /// Initialize camera with proper error handling
  Future<void> _initializeCamera() async {
    try {
      _isCameraPermissionGranted = await _requestCameraPermission();
      if (!_isCameraPermissionGranted) {
        widget.onCameraAccessDenied?.call();
        return;
      }

      _cameras = await availableCameras();
      if (_cameras.isEmpty) {
        throw CameraException('No cameras found', 'Device has no cameras');
      }

      await _initializeCameraController();
    } catch (e) {
      _handleCameraError(e);
    }
  }

  /// Initialize camera controller with specified settings
  Future<void> _initializeCameraController() async {
    final controller = CameraController(
      _cameras[0],
      ResolutionPreset.veryHigh,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    _controller = controller;

    try {
      await controller.initialize();
      _isInitialized = true;
      if (mounted) setState(() {});
    } catch (e) {
      _handleCameraError(e);
    }
  }

  /// Request camera permission with proper error handling
  Future<bool> _requestCameraPermission() async {
    try {
      final status = await Permission.camera.request();
      return status == PermissionStatus.granted;
    } catch (e) {
      _handleCameraError(e);
      return false;
    }
  }

  /// Handle camera and permission related errors
  void _handleCameraError(dynamic error) {
    log('Camera Error: $error', error: error, stackTrace: StackTrace.current);

    if (error is CameraException) {
      if (error.code == 'CameraAccessDenied') {
        widget.onCameraAccessDenied?.call();
      } else {
        widget.onOtherException?.call();
        if (widget.onOtherException == null) _showErrorDialog(error);
      }
    } else {
      widget.onOtherException?.call();
      if (widget.onOtherException == null) _showErrorDialog(error);
    }
  }

  /// Capture image with proper error handling
  Future<void> _takePicture() async {
    if (_controller == null || !_controller!.value.isInitialized) return;

    try {
      final XFile photo = await _controller!.takePicture();
      setState(() => _capturedImage = File(photo.path));
    } catch (e) {
      _handleCameraError(e);
    }
  }

  /// Build camera preview with grid overlay
  Widget _buildCameraPreview() {
    return AspectRatio(
      aspectRatio: widget.aspectRatio,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Camera preview or captured image
          _capturedImage == null
              ? CameraPreview(_controller!)
              : Image.file(_capturedImage!, fit: BoxFit.cover),

          // Grid overlay
          CustomPaint(
            painter: GridPainter(
              rowCount: widget.rowCount,
              columnCount: widget.columnCount,
              gridColor: widget.gridColor ?? Theme.of(context).primaryColor,
              gridWidth: widget.gridWidth,
            ),
          ),
        ],
      ),
    );
  }

  /// Show error dialog with custom or default messages
  Future<void> _showErrorDialog(dynamic error) async {
    if (!mounted) return;

    await showAdaptiveDialog(
      context: context,
      builder: (context) => AlertDialog.adaptive(
        title: Text(widget.otherExceptionTitleText ?? 'Camera Error'),
        content: Text(widget.otherExceptionBodyText ?? error.toString()),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _initializeCamera();
            },
            child: Text(widget.otherExceptionOkayText ?? 'OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized ||
        _controller == null ||
        !_controller!.value.isInitialized) {
      return Center(
        child: !_isCameraPermissionGranted
            ? widget.permissionDeniedWidget ??
                const Text('Camera permission denied')
            : widget.cameraLoadingWidget ??
                const CircularProgressIndicator.adaptive(),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: Center(child: _buildCameraPreview())),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (_capturedImage != null)
                    IconButton(
                      onPressed: () => setState(() => _capturedImage = null),
                      icon: widget.refreshIcon ??
                          const Icon(Icons.refresh, size: 48),
                    ),
                  IconButton(
                    onPressed: _capturedImage == null
                        ? _takePicture
                        : () async {
                            final image = await _screenshotController
                                .captureFromWidget(_buildCameraPreview());
                            widget.onDonePressed(image);
                            setState(() => _capturedImage = null);
                          },
                    icon: _capturedImage == null
                        ? widget.clickPhotoIcon ??
                            const Icon(Icons.camera_alt_rounded, size: 48)
                        : widget.doneIcon ?? const Icon(Icons.check, size: 48),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
