import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_theater/generated/locale_keys.g.dart';
import 'package:movie_theater/models/movie/movie.dart';
import 'package:movie_theater/state/movie_cubit/movie_cubit.dart';
import 'package:movie_theater/state/room_cubit/room_cubit.dart';
import 'package:movie_theater/state/room_cubit/room_cubit_state.dart';
import 'package:movie_theater/widgets/booking/booking_screen.dart';
import 'package:movie_theater/core/routes/movies_routes_generator.dart';
import 'package:movie_theater/widgets/room/popcorn_duration.dart';

class MovieInfo extends StatelessWidget {
  const MovieInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomCubit, RoomCubitState>(
      builder: (context, state) => Column(
        children: [
          Text(
            state.movie?.name ?? "",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(state.movie?.plot ?? ""),
          SizedBox(height: 10),
          PopcornDuration(
            state.movie?.duration ?? 0,
          ),
          ElevatedButton(
            onPressed: () {
              context.read<MovieCubit>().setMovie(state.movie ?? Movie.empty());
              final seats = context.read<RoomCubit>().getSeats();
              Navigator.of(context).pushNamed(
                MoviesRoutesGenerator.booking,
                arguments: seats,
              );
            },
            child: Text(LocaleKeys.book.tr()),
          ),
        ],
      ),
    );
  }
}
