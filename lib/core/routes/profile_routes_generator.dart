import 'package:flutter/material.dart';
import 'package:movie_theater/models/movie/movie.dart';
import 'package:movie_theater/models/session/seat.dart';
import 'package:movie_theater/models/session/seat_model.dart';
import 'package:movie_theater/widgets/booking/booking_screen.dart';
import 'package:movie_theater/widgets/movie/movie_screen.dart';
import 'package:movie_theater/widgets/movie_chooser/movie_chooser.dart';
import 'package:movie_theater/widgets/new_tickets/new_tickets_screen.dart';
import 'package:movie_theater/widgets/paying/paying_screen.dart';
import 'package:movie_theater/widgets/profile/profile_screen.dart';

class ProfileRoutesGenerator {
  static const initial = '/profile';

  static const movie = '/movie';

  static Route<dynamic>? genereteRoute(RouteSettings settings) {
    switch (settings.name) {
      case initial:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const ProfileScreen(),
        );

      case movie:
        return MaterialPageRoute(
          builder: (context) => MovieScreen(
            movie: settings.arguments as Movie,
          ),
        );
    }
  }
}
