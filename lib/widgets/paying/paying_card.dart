import 'dart:math';

import 'package:flutter/material.dart';

import 'package:movie_theater/core/extensions.dart';

import 'card_shape.dart';

class PayingCard extends StatelessWidget {
  final AnimationController rotationController;
  const PayingCard(this.rotationController, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (p0, constraints) {
        final width = constraints.maxWidth;
        return GestureDetector(
          onTapUp: (details) {
            if (!rotationController.isAnimating) {
              if (details.globalPosition.dx < width / 2) {
                rotationController.animateTo(rotationController.value + pi,
                    duration: const Duration(milliseconds: 600));
              } else {
                rotationController.animateTo(rotationController.value - pi,
                    duration: const Duration(milliseconds: 600));
              }
            }
          },
          child: AnimatedBuilder(
            animation: rotationController,
            builder: (context, child) => Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(rotationController.value),
              alignment: Alignment.center,
              child: CardShape(
                isFront: rotationController.value.isFront(),
              ),
            ),
          ),
        );
      },
    );
  }
}
