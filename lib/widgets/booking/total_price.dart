import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:movie_theater/generated/locale_keys.g.dart';

class TotalPrice extends StatelessWidget {
  final int value;
  const TotalPrice(this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Text(
        "$value ${LocaleKeys.uah.tr()}",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.black
              : Colors.white,
        ),
      ),
    );
  }
}
