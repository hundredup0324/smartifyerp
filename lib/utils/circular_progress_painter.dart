import 'package:flutter/material.dart';

class _CircularProgressPainter extends CustomPainter {
  final double firstCategoryValue;
  final double secondCategoryValue;
  final double totalValue;

  _CircularProgressPainter({
    required this.firstCategoryValue,
    required this.secondCategoryValue,
    required this.totalValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double startAngle = -90.0;
    double firstSweepAngle = (firstCategoryValue / totalValue) * 360;
    double secondSweepAngle = (secondCategoryValue / totalValue) * 360;
    double remainingSweepAngle = 360 - firstSweepAngle - secondSweepAngle;

    Paint backgroundPaint = Paint()
      ..color = Colors.grey.withOpacity(0.3)
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke;

    Paint firstCategoryPaint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke;

    Paint secondCategoryPaint = Paint()
      ..color = Colors.green
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke;

    Paint remainingPaint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke;

    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);

    // Draw background circle
    canvas.drawArc(rect, degreeToRadians(-90), degreeToRadians(360), false, backgroundPaint);

    // Draw first category
    canvas.drawArc(rect, degreeToRadians(startAngle), degreeToRadians(firstSweepAngle), false, firstCategoryPaint);

    // Update start angle for the second category
    startAngle += firstSweepAngle;

    // Draw second category
    canvas.drawArc(rect, degreeToRadians(startAngle), degreeToRadians(secondSweepAngle), false, secondCategoryPaint);

    // Update start angle for the remaining category
    startAngle += secondSweepAngle;

    // Draw remaining
    canvas.drawArc(rect, degreeToRadians(startAngle), degreeToRadians(remainingSweepAngle), false, remainingPaint);
  }

  double degreeToRadians(double degree) {
    return degree * 3.141592653589793 / 180;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}