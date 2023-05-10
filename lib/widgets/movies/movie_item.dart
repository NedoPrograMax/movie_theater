import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:movie_theater/models/movie/movie_model.dart';
import 'package:movie_theater/widgets/movies/movie_card.dart';

class MovieItem extends HookWidget {
  final MovieModel movie;
  const MovieItem(this.movie, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      lowerBound: -pi * 10000,
      upperBound: pi * 10000,
    );
    return MovieCard(controller, movie);
  }
}
