import 'package:flutter/material.dart';

class MultiLevelProgressPainter extends CustomPainter {
  final List<double> progressLevels;
  final List<Color> colors;
  final double strokeWidth;

  MultiLevelProgressPainter({
    required this.progressLevels,
    required this.colors,
    required this.strokeWidth,
  }) : assert(progressLevels.length == colors.length);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    double currentRadius = radius;

    for (int i = 0; i < progressLevels.length; i++) {
      final paint = Paint()
        ..color = colors[i]
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth;

      double startAngle = -3.14 / 2;
      double sweepAngle = 2 * 3.14 * progressLevels[i];

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: currentRadius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );

      currentRadius -= strokeWidth + 4; // Adjust spacing between levels
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}