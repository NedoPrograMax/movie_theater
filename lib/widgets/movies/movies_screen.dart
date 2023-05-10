import 'package:flutter/material.dart';

import 'package:movie_theater/models/movie/movie_model.dart';
import 'package:movie_theater/widgets/movies/movies_grid.dart';

class MoviesScreen extends StatelessWidget {
  final List<MovieModel> movies;
  const MoviesScreen(this.movies, {super.key});

  @override
  Widget build(BuildContext context) {
    if (movies.isNotEmpty) {
      return MoviesGrid(movies);
    } else {
      return Center(
        child: Text("There is no data"),
      );
    }
  }
}
