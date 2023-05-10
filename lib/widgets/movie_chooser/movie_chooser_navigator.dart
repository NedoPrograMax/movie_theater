import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_theater/core/utils.dart';
import 'package:movie_theater/core/routes/movies_routes_generator.dart';
import 'package:movie_theater/core/extensions.dart';
import 'package:movie_theater/state/booking_cubit/booking_cubit.dart';
import 'package:movie_theater/state/comments_cubit/comments_cubit.dart';

class MovieChooserNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  const MovieChooserNavigator(
    this.navigatorKey, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      initialRoute: MoviesRoutesGenerator.initial,
      onGenerateRoute: MoviesRoutesGenerator.genereteRoute,
    );
  }
}
