import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flag/flag.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:movie_theater/widgets/profile/flag_item.dart';

class LanguageControl extends StatelessWidget {
  const LanguageControl({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final curentLocale = context.locale.languageCode;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        FlagItem(
          code: FlagsCode.UA,
          isActive: curentLocale == "uk",
          width: width,
          locale: const Locale("uk"),
        ),
        FlagItem(
          code: FlagsCode.GB,
          isActive: curentLocale == "en",
          width: width,
          locale: const Locale("en"),
        ),
      ],
    );
  }
}
