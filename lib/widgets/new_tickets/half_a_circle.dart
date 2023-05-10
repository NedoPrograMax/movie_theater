import 'dart:math';

import 'package:flutter/material.dart';

class HalfACircle extends CustomPainter {
  final double startAngle;
  final double radius;
  final Color color;
  HalfACircle({
    required this.startAngle,
    required this.color,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;

    canvas.drawArc(
      Rect.fromCircle(center: Offset.zero, radius: radius),
      startAngle,
      pi,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
