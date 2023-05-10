import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class LittleCircles extends StatelessWidget {
  final double circleSize;
  final int circleCount;
  const LittleCircles({
    required this.circleSize,
    required this.circleCount,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < circleCount; i++)
          Icon(
            Icons.circle,
            size: circleSize,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
      ],
    );
  }
}
