import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_theater/repositories/network_repository.dart';
import 'package:movie_theater/core/extensions.dart';
import 'package:movie_theater/initialize.dart';
import 'package:movie_theater/models/session/movie_session.dart';
import 'package:intl/intl.dart';
import 'package:movie_theater/state/movie_cubit/movie_cubit.dart';
import 'package:movie_theater/widgets/booking/booking_screen.dart';
import 'package:movie_theater/core/routes/movies_routes_generator.dart';

class MovieSessionItem extends StatelessWidget {
  final MovieSession session;
  const MovieSessionItem(this.session, {super.key});

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat.Hm();
    final startTime = formatter.format(session.start);
    final endTime = formatter.format(session.start.add(session.duration));

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(4),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            context.read<MovieCubit>().setMovie(
                  sl<NetworkRepository>()
                      .getMovieFromCacheBySessionId(session.id),
                );
            Navigator.of(context).pushNamed(
              MoviesRoutesGenerator.booking,
              arguments: sl<NetworkRepository>().fetchSeats(session.id),
            );
          },
          child: Ink(
            child: Text(
              "$startTime - $endTime",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 19,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
