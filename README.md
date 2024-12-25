# grid_camera

[![pub package](https://img.shields.io/pub/v/grid_camera.svg)](https://pub.dev/packages/grid_camera)
[![likes](https://img.shields.io/pub/likes/grid_camera?logo=dart)](https://pub.dev/packages/grid_camera/score)
[![popularity](https://img.shields.io/pub/popularity/grid_camera?logo=dart)](https://pub.dev/packages/grid_camera/score)

grid_camera is a Flutter package that enhances the camera experience with a customizable grid overlay system. Built on top of the official camera plugin, it provides an easy-to-use widget for applications requiring precise photo composition, document scanning, or grid-based image capture.

A Flutter camera package that provides a customizable grid overlay for precise photo composition. Features include adjustable grid rows/columns, aspect ratio control, built-in permission handling, and captured images with grid overlay. Perfect for applications requiring precise photo composition, document scanning, or grid-based image capture.

### Key Features:

- Customizable camera preview with adjustable grid overlay
- Configurable grid rows, columns, and appearance
- Flexible aspect ratio control
- Built-in permission handling with customizable UI
- Image capture with grid overlay
- Utility extensions for quick widget styling
- Responsive design and error handling
- Easy integration with existing Flutter apps

### Perfect for:

- 📸 Document scanning apps
- 📊 Technical photography
- 📏 Measurement applications
- 🎨 Design and composition tools
- 📱 Any app requiring precise photo capture

## Features

- 📸 Customizable camera preview with grid overlay
- 🎯 Adjustable grid rows and columns
- 📐 Configurable aspect ratio
- 🎨 Customizable grid appearance
- 📱 Built-in permission handling
- 🔄 Image capture with grid overlay
- ⚡ Utility extensions for quick widget styling
- 🎯 Gap widget for consistent spacing
- 📱 **Platform Support**:
  - ✅ Android
  - ✅ iOS

## Getting Started

### Prerequisites

This package relies on the official [camera](https://pub.dev/packages/camera) plugin. You'll need to configure your project according to the platform-specific requirements.

#### Android

Add the following permissions to your `AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.CAMERA" />
```

#### iOS

Add the following keys to your `Info.plist`:

```xml
<key>NSCameraUsageDescription</key>
<string>Your camera usage description here</string>
```

For detailed camera setup instructions, please refer to the official [camera plugin documentation](https://pub.dev/packages/camera).

### Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  grid_camera: ^0.0.5
```

## Usage

### Complete Example

```dart
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:grid_camera/grid_camera.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grid Camera Demo',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Grid Camera Demo")),
      body: GridCameraWidget(
        onDonePressed: (Uint8List gridImage) {
          // TODO: do something with captured gridImage, e.g Save/Download/Share
          log(gridImage.toString());
        },
        rowCount: 10,
        columnCount: 10,
        gridWidth: 0.5,
        aspectRatio: 1 / 1,
      ),
    );
  }
}
```

### Customized Implementation

```dart
GridCameraWidget(
  rowCount: 4,
  columnCount: 4,
  gridColor: Colors.white,
  gridWidth: 2.0,
  aspectRatio: 4/3,
  clickPhotoIcon: Icon(Icons.camera),
  doneIcon: Icon(Icons.check_circle),
  refreshIcon: Icon(Icons.refresh),
  cameraLoadingWidget: CircularProgressIndicator(),
  onDonePressed: (imageBytes) {
    // Handle captured image
  },
  onCameraAccessDenied: () {
    // Handle permission denied
  },
  otherExceptionTitleText: 'Custom Error Title',
  otherExceptionBodyText: 'Custom error message',
  otherExceptionOkayText: 'Retry',
);
```

## Additional Utilities

### Gap Widget

A simple widget for creating consistent spacing:

```dart
// Creates both vertical and horizontal space
const Gap(16);

// In a column
Column(
  children: [
    Text('Hello'),
    Gap(8),  // 8.0 pixels of space
    Text('World'),
  ],
);
```

### Widget Extensions

Convenient extensions for common padding patterns:

```dart
// Horizontal padding
myWidget.padXX(16)

// Vertical padding
myWidget.padYY(16)

// Default horizontal padding (16px)
myWidget.padXXDefault

// Bottom padding
myWidget.padYBottom(16)

// Top padding
myWidget.padYTop(16)

// Left padding
myWidget.padXLeft(16)

// Right padding
myWidget.padXRight(16)

// All-side padding
myWidget.padAll(16)

// Expand widget
myWidget.expand
```

## Configuration Options

### GridCameraWidget Properties

| Property                | Type                | Description                               |
| ----------------------- | ------------------- | ----------------------------------------- |
| rowCount                | int                 | Number of horizontal grid lines + 1       |
| columnCount             | int                 | Number of vertical grid lines + 1         |
| gridColor               | Color?              | Color of grid lines                       |
| gridWidth               | double              | Width of grid lines                       |
| aspectRatio             | double              | Camera preview aspect ratio               |
| onDonePressed           | Function(Uint8List) | Callback when image is captured           |
| onCameraAccessDenied    | VoidCallback?       | Callback when camera permission denied    |
| onOtherException        | VoidCallback?       | Callback for other errors                 |
| permissionDeniedWidget  | Widget?             | Custom widget for permission denied state |
| cameraLoadingWidget     | Widget?             | Custom loading widget                     |
| clickPhotoIcon          | Widget?             | Custom capture button icon                |
| doneIcon                | Widget?             | Custom done button icon                   |
| refreshIcon             | Widget?             | Custom refresh button icon                |
| otherExceptionTitleText | String?             | Custom error dialog title                 |
| otherExceptionBodyText  | String?             | Custom error dialog message               |
| otherExceptionOkayText  | String?             | Custom error dialog button text           |

## Troubleshooting

Common issues and their solutions:

1. **Camera not initializing**: Ensure you've added all required permissions and followed the camera plugin setup.
2. **Black screen**: Check if the camera permission is granted at runtime.
3. **Grid not visible**: Verify that the gridColor contrasts with your camera preview.

For more specific camera-related issues, please refer to the [camera plugin's troubleshooting guide](https://pub.dev/packages/camera#troubleshooting).

## Contributing

Contributions are welcome! If you find a bug or want a feature, please file an issue.

## License

This project is licensed under the MIT License - see the [LICENSE](./LICENSE) file for details.

## Credits

This package builds upon the [camera](https://pub.dev/packages/camera) package, gives grid overlay and easy way to use camera widget.
