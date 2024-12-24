import 'package:flutter/material.dart';

class GridPainter extends CustomPainter {
  final int rowCount;
  final int columnCount;
  final Color gridColor;
  final double gridWidth;

  GridPainter({
    required this.rowCount,
    required this.columnCount,
    required this.gridColor,
    required this.gridWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = gridColor
      ..strokeWidth = gridWidth
      ..style = PaintingStyle.stroke;

    // Draw vertical lines
    double cellWidth = size.width / columnCount;
    for (int i = 1; i < columnCount; i++) {
      double x = cellWidth * i;
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        paint,
      );
    }

    // Draw horizontal lines
    double cellHeight = size.height / rowCount;
    for (int i = 1; i < rowCount; i++) {
      double y = cellHeight * i;
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(GridPainter oldDelegate) {
    return oldDelegate.rowCount != rowCount ||
        oldDelegate.columnCount != columnCount ||
        oldDelegate.gridColor != gridColor ||
        oldDelegate.gridWidth != gridWidth;
  }
}
