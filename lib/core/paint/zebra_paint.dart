import 'dart:math';
import 'package:flutter/material.dart';
import 'package:bondly/core/themes/app_theme.dart';

class ZebraPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..isAntiAlias = false; // Disable anti-aliasing to avoid tiny seams

    const stripeWidth = 200.0; // Adjust stripe width as needed

    final colors = [
      AppTheme.primaryColor,
      AppTheme.gradient3,
      AppTheme.gradient4.withValues(alpha: 0.3),
    ];

    final angle = 60 * pi / 180; // Convert 60 degrees to radians
    final dx = stripeWidth * cos(angle);
    final dy = stripeWidth * sin(angle);

    // Paint stripes across entire canvas
    for (double i = -size.height; i < size.width + size.height; i += stripeWidth) {
      final index = ((i + size.height) ~/ stripeWidth) % colors.length;
      paint.color = colors[index];

      final path = Path()
        ..moveTo(i, 0)
        ..lineTo(i + dx + 1, 0) // +1 to ensure overlap (eliminate gaps)
        ..lineTo(i + dx - dy + 1, size.height)
        ..lineTo(i - dy, size.height)
        ..close();

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
