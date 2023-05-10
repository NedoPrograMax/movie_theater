import 'package:get_it/get_it.dart';
import 'package:movie_theater/repositories/api_repository.dart';
import 'package:movie_theater/data_sources/movie_data_source.dart';
import 'package:movie_theater/repositories/local_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:easy_localization/easy_localization.dart';

final sl = GetIt.asNewInstance();

Future<void> initialize() async {
  sl.registerLazySingleton(
      () => ApiRepository(movieDataSource: MovieDataSource()));
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => LocalRepository(sharedPrefferenes: prefs));

  await EasyLocalization.ensureInitialized();
}
