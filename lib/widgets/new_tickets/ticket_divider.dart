import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:movie_theater/widgets/new_tickets/little_circles.dart';

import 'half_a_circle.dart';

class TicketDividerr extends StatelessWidget {
  final double mainCircleSize;
  const TicketDividerr({
    required this.mainCircleSize,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (p0, constraints) {
      final circlesWidth = constraints.maxWidth - mainCircleSize;
      const circlesCount = 28;
      final circleSize = circlesWidth / circlesCount;
      return Transform.translate(
        offset: Offset(0, -circleSize / 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomPaint(
              painter: HalfACircle(
                  startAngle: -pi / 2,
                  radius: mainCircleSize,
                  color: Theme.of(context).scaffoldBackgroundColor),
            ),
            Expanded(
                child: LittleCircles(
              circleCount: circlesCount,
              circleSize: circleSize,
            )),
            CustomPaint(
              painter: HalfACircle(
                  startAngle: pi / 2,
                  radius: mainCircleSize,
                  color: Theme.of(context).scaffoldBackgroundColor),
            ),
          ],
        ),
      );
    });
  }
}
