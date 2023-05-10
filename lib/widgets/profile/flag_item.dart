import 'package:easy_localization/easy_localization.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:movie_theater/generated/locale_keys.g.dart';
import 'package:restart_app/restart_app.dart';

class FlagItem extends StatelessWidget {
  final bool isActive;
  final FlagsCode code;
  final double width;
  final Locale locale;
  const FlagItem({
    required this.isActive,
    required this.code,
    required this.width,
    required this.locale,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (context.locale.languageCode == locale.languageCode) {
          return;
        }
        final success = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            content: Text(
              LocaleKeys.restart_for_localize.tr(),
            ),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(LocaleKeys.back.tr()),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(LocaleKeys.ok.tr()),
              ),
            ],
          ),
        );
        if (success == true) {
          context.setLocale(
            locale,
          );
          Restart.restartApp();
        }
      },
      child: ColorFiltered(
        colorFilter: ColorFilter.mode(
          isActive ? Colors.transparent : Colors.grey,
          BlendMode.saturation,
        ),
        child: Flag.fromCode(
          code,
          width: width * 0.2,
          height: width * 0.2,
        ),
      ),
    );
  }
}
