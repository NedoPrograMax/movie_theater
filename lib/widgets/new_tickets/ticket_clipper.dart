import 'package:flutter/material.dart';

class TicketClipper extends CustomClipper<Path> {
  final double aspectRatio;
  TicketClipper(this.aspectRatio);

  @override
  Path getClip(Size size) {
    final rect = Rect.fromLTRB(0, 0, size.width, size.height);
    final dividerHeight = (size.height * aspectRatio) / (aspectRatio + 1);
    final bigCircleRadius = size.height * 0.085;

    final path = Path()
      ..fillType = PathFillType.evenOdd
      ..addOval(
        Rect.fromCenter(
          center: Offset(
            0,
            dividerHeight,
          ),
          width: bigCircleRadius,
          height: bigCircleRadius,
        ),
      );
    path.addOval(
      Rect.fromCenter(
        center: Offset(
          size.width / 1,
          dividerHeight,
        ),
        width: bigCircleRadius,
        height: bigCircleRadius,
      ),
    );
    const smallCirclesCount = 23;
    final smallCirlceWithPaddingSize =
        (size.width - bigCircleRadius) / smallCirclesCount;
    const paddingPart = 0.3;
    final smallCirlceSize = smallCirlceWithPaddingSize * (1 - paddingPart);

    for (int i = 1; i <= smallCirclesCount; i++) {
      path.addOval(
        Rect.fromCenter(
          center: Offset(
            (bigCircleRadius - smallCirlceWithPaddingSize) / 2 +
                smallCirlceWithPaddingSize * i,
            dividerHeight,
          ),
          width: smallCirlceSize,
          height: smallCirlceSize,
        ),
      );
    }

    path.addRect(rect);

    return path;
  }

  @override
  bool shouldReclip(TicketClipper oldClipper) => false;
}
