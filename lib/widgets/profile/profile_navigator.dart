import 'package:flutter/material.dart';
import 'package:movie_theater/core/utils.dart';
import 'package:movie_theater/core/routes/movies_routes_generator.dart';
import 'package:movie_theater/core/extensions.dart';
import 'package:movie_theater/core/routes/profile_routes_generator.dart';

class ProfileNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  const ProfileNavigator(
    this.navigatorKey, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (navigatorKey.currentState?.canPop() != true) {
          return Future.value(true);
        } else {
          navigatorKey.currentState?.pop();
        }
        return Future.value(false);
      },
      child: Navigator(
        key: navigatorKey,
        initialRoute: ProfileRoutesGenerator.initial,
        onGenerateRoute: ProfileRoutesGenerator.genereteRoute,
      ),
    );
  }
}
