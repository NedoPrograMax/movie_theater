import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:movie_theater/core/extensions.dart';
import 'package:movie_theater/generated/locale_keys.g.dart';
import 'package:movie_theater/widgets/room/part_popcron.dart';

class PopcornDuration extends StatelessWidget {
  final int duration;
  const PopcornDuration(this.duration, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "${LocaleKeys.duration.tr()} = ${duration.toHoursMinutes()} =",
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
        for (int i = 0; i < duration ~/ 60; i++) const PartPopcorn(1),
        PartPopcorn(duration.remainder(60) / 60.0),
      ],
    );
  }
}
