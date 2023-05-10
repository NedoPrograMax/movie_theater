import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:movie_theater/generated/locale_keys.g.dart';
import 'package:movie_theater/repositories/api_repository.dart';
import 'package:movie_theater/initialize.dart';

class Username extends HookWidget {
  const Username({super.key});

  @override
  Widget build(BuildContext context) {
    final nameFuture = useMemoized(() => sl<ApiRepository>().fetchUsername());
    final name = useFuture(nameFuture);
    if (name.connectionState == ConnectionState.done) {
      final controller = useTextEditingController(text: name.data);
      return IntrinsicWidth(
        child: TextField(
          style: TextStyle(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.black
                : Colors.white,
          ),
          textAlign: TextAlign.center,
          controller: controller,
          decoration: InputDecoration(hintText: LocaleKeys.username_hint.tr()),
          onSubmitted: (value) => sl<ApiRepository>().updateUsername(value),
        ),
      );
    }
    return Container();
  }
}
