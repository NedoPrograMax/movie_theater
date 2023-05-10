import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:movie_theater/models/movie/movie_model.dart';
import 'package:movie_theater/widgets/movies/movie_front.dart';
import 'package:movie_theater/widgets/movies/movie_item.dart';

class MoviesGrid extends StatelessWidget {
  final List<MovieModel> movies;
  const MoviesGrid(this.movies, {super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: movies.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) => MovieItem(movies[index]),
    );
  }
}
