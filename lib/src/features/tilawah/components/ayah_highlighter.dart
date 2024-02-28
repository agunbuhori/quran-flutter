import 'package:flutter/material.dart';

class AyahHighlighter extends CustomPainter {
  final double minX;
  final double minY;
  final double maxX;
  final double maxY;

  AyahHighlighter({
    required this.minX,
    required this.minY,
    required this.maxX,
    required this.maxY,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.brown.withOpacity(0.2) // Change color as needed
      ..style = PaintingStyle.fill
      ..strokeWidth = 2.0; // Change stroke width as needed

    final double width = maxX - minX + 4;
    final double height = maxY - minY;

    // Draw square
    canvas.drawRect(
      Rect.fromPoints(
        Offset(minX, minY),
        Offset(minX + width, minY + height),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
