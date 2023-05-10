import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:movie_theater/initialize.dart';
import 'package:movie_theater/repositories/local_repository.dart';

class ThemeButton extends HookWidget {
  const ThemeButton({super.key});

  @override
  Widget build(BuildContext context) {
    final initThemeIsLight = useMemoized(() => sl<LocalRepository>().isLight);
    final currentThemeIsLight = useState(initThemeIsLight);

    return IconButton(
      iconSize: 50,
      onPressed: () {
        if (currentThemeIsLight.value == true) {
          AdaptiveTheme.of(context).setDark();
          sl<LocalRepository>().isLight = false;
          currentThemeIsLight.value = false;
        } else {
          AdaptiveTheme.of(context).setLight();
          sl<LocalRepository>().isLight = true;
          currentThemeIsLight.value = true;
        }
      },
      icon: Icon(
        currentThemeIsLight.value == true ? Icons.dark_mode : Icons.light_mode,
      ),
    );
  }
}
