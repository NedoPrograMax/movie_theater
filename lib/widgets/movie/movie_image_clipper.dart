import 'dart:math';

import 'package:flutter/material.dart';

class MovieImageClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final rect = Rect.fromLTRB(0, 0, size.width, size.height);

    final path = Path()
      ..fillType = PathFillType.evenOdd
      ..addArc(Rect.fromCircle(center: Offset(0, size.height / 2), radius: 100),
          0, pi);

    path.addRect(rect);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => true;
}
