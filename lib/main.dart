import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movie_theater/generated/codegen_loader.g.dart';
import 'package:movie_theater/initialize.dart';
import 'package:movie_theater/widgets/my_app.dart';

final List<String> _allAsset = [
  'assets/images/better_chair.png',
  'assets/images/taken_better_chair.png',
  'assets/images/chosen_better_chair.png',
  'assets/images/chair.png',
  'assets/images/chosen_chair.png',
  'assets/images/taken_chair.png',
  'assets/images/vip_chair.png',
  'assets/images/taken_vip_chair.png',
  'assets/images/chosen_vip_chair.png',
];

void main() async {
  final binding = WidgetsFlutterBinding.ensureInitialized();
  await initialize();
  binding.addPostFrameCallback((_) async {
    BuildContext context = binding.renderViewElement as BuildContext;
    if (context != null) {
      for (var asset in _allAsset) {
        precacheImage(AssetImage(asset), context);
      }
    }
  });
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('uk')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      assetLoader: const CodegenLoader(),
      child: const MyApp(),
    ),
  );
}
