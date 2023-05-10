import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:movie_theater/models/movie/movie_model.dart';
import 'package:movie_theater/widgets/movies/sessions_list.dart';

class MovieBack extends StatelessWidget {
  final MovieModel movie;
  const MovieBack({required this.movie, super.key});

  @override
  Widget build(BuildContext context) {
    return Transform(
        transform: Matrix4.identity()..rotateY(pi),
        alignment: Alignment.center,
        child: SessionsList(movie.sessions));
  }
}
