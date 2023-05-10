import 'package:flutter/material.dart';
import 'package:movie_theater/models/movie/movie.dart';
import 'package:movie_theater/models/session/seat.dart';
import 'package:movie_theater/models/session/seat_model.dart';
import 'package:movie_theater/widgets/booking/booking_screen.dart';
import 'package:movie_theater/widgets/movie/movie_screen.dart';
import 'package:movie_theater/widgets/movie_chooser/movie_chooser.dart';
import 'package:movie_theater/widgets/new_tickets/new_tickets_screen.dart';
import 'package:movie_theater/widgets/paying/paying_screen.dart';

class MoviesRoutesGenerator {
  static const initial = '/';
  static const booking = '/booking';
  static const paying = '/paying';
  static const newTickets = '/newTickets';
  static const movie = '/movie';

  static Route<dynamic>? genereteRoute(RouteSettings settings) {
    switch (settings.name) {
      case initial:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const MovieChooser(),
        );
      case booking:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => BookingScreen(
              settings.arguments as Future<List<List<SeatModel>>>),
        );
      case paying:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => PayingScreen(),
        );
      case newTickets:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (context, animation, secondaryAnimation) =>
              const NewTicketsScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );
      case movie:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => MovieScreen(
            movie: settings.arguments as Movie,
          ),
        );
    }
  }
}
