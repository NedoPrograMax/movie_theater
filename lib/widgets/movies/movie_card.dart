import 'dart:math';

import 'package:flutter/material.dart';

import 'package:movie_theater/core/extensions.dart';
import 'package:movie_theater/initialize.dart';
import 'package:movie_theater/models/movie/movie_model.dart';
import 'package:movie_theater/repositories/network_repository.dart';
import 'package:movie_theater/widgets/movie/movie_screen.dart';
import 'package:movie_theater/widgets/movies/movie_item_shape.dart';
import 'package:movie_theater/core/routes/movies_routes_generator.dart';

class MovieCard extends StatelessWidget {
  final MovieModel movie;
  final AnimationController rotationController;
  const MovieCard(this.rotationController, this.movie, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (p0, constraints) {
        final width = constraints.maxWidth;
        return GestureDetector(
          onTapUp: (details) {
            if (!rotationController.isAnimating) {
              if (details.localPosition.dx < width / 2) {
                rotationController.animateTo(rotationController.value + pi,
                    duration: const Duration(milliseconds: 600));
              } else {
                rotationController.animateTo(rotationController.value - pi,
                    duration: const Duration(milliseconds: 600));
              }
            }
          },
          onLongPress: () {
            if (rotationController.value.isFront()) {
              Navigator.of(context).pushNamed(
                MoviesRoutesGenerator.movie,
                arguments: sl<NetworkRepository>().getMovieFromCache(movie.id),
              );
            }
          },
          child: AnimatedBuilder(
            animation: rotationController,
            builder: (context, child) => Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(rotationController.value),
              alignment: Alignment.center,
              child: MovieItemShape(
                movie: movie,
                isFront: rotationController.value.isFront(),
              ),
            ),
          ),
        );
      },
    );
  }
}
