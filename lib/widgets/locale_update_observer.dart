import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class LocaleChangeObserver extends WidgetsBindingObserver {
  final VoidCallback onLocaleChanged;

  LocaleChangeObserver({required this.onLocaleChanged});

  @override
  void didChangeLocales(List<Locale>? locales) {
    onLocaleChanged();
  }
}

LocaleChangeObserver useLocaleChangeObserver(VoidCallback onLocaleChanged) {
  final observer =
      useMemoized(() => LocaleChangeObserver(onLocaleChanged: onLocaleChanged));

  useEffect(() {
    WidgetsBinding.instance.addObserver(observer);
    return () => WidgetsBinding.instance.removeObserver(observer);
  }, [observer]);

  return observer;
}
