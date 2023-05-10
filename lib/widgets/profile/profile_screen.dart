import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:movie_theater/generated/locale_keys.g.dart';
import 'package:movie_theater/widgets/profile/favorites_grid.dart';
import 'package:movie_theater/widgets/profile/language_control.dart';
import 'package:movie_theater/widgets/profile/theme_button.dart';
import 'package:movie_theater/widgets/profile/username.dart';
import 'package:restart_app/restart_app.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Username(),
                  SizedBox(height: 10),
                  LanguageControl(),
                  ThemeButton(),
                ],
              ),
            ),
          ),
          const Expanded(
              child: FavoritesGrid(
            key: ValueKey("Profile"),
          )),
        ],
      ),
    );
  }
}
