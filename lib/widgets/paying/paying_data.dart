import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_shake_animated/flutter_shake_animated.dart';
import 'package:movie_theater/widgets/lotties/loading_movie.dart';
import 'package:movie_theater/widgets/paying/pay_button.dart';
import 'package:movie_theater/widgets/paying/paying_card.dart';

class PayingData extends HookWidget {
  const PayingData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isShaking = ValueNotifier(false);
    final rotationController = useAnimationController(
      lowerBound: -pi * 10000,
      upperBound: pi * 10000,
    );
    final dissapearingController = useAnimationController(
      duration: const Duration(milliseconds: 1000),
    );

    return Column(
      children: [
        const SizedBox(height: 30),
        Stack(
          children: [
            SlideTransition(
              position: dissapearingController.drive(
                Tween(
                  begin: Offset.zero,
                  end: const Offset(0, -2),
                ),
              ),
              child: ScaleTransition(
                scale: dissapearingController.drive(
                  Tween(begin: 1, end: 0),
                ),
                child: ValueListenableBuilder(
                  valueListenable: isShaking,
                  builder: (context, value, child) => ShakeWidget(
                    shakeConstant: ShakeRotateConstant1(),
                    autoPlay: isShaking.value,
                    duration: const Duration(seconds: 2),
                    child: child!,
                  ),
                  child: PayingCard(rotationController),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
        PayButton(
          dissapearingController: dissapearingController,
          isShaking: isShaking,
        ),
      ],
    );
  }
}
