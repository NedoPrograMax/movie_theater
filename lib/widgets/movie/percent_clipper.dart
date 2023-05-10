import 'package:flutter/material.dart';

class PercentClipper extends CustomClipper<Path> {
  final double percent;
  const PercentClipper(this.percent);

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(size.width * percent, 0);
    path.lineTo(size.width * percent, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
