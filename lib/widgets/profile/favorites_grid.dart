import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:movie_theater/initialize.dart';
import 'package:movie_theater/repositories/api_repository.dart';
import 'package:movie_theater/repositories/local_repository.dart';
import 'package:movie_theater/widgets/movies/movie_front.dart';
import 'package:movie_theater/core/routes/movies_routes_generator.dart';

class FavoritesGrid extends HookWidget {
  const FavoritesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final stream =
        useMemoized(() => sl<LocalRepository>().getFavoritesStream(), [key]);
    final movieIds = useStream(stream);
    if (movieIds.hasData) {
      final moviesFuture = useMemoized(
        () => sl<ApiRepository>().fetchConcreteMovies(movieIds.data!),
        [movieIds.data],
      );
      final movies = useFuture(moviesFuture, preserveState: false);
      if (movies.hasData) {
        return GridView.builder(
          shrinkWrap: true,
          itemCount: movies.data!.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2 / 3,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) => GestureDetector(
            onLongPress: () => Navigator.of(context).pushNamed(
              MoviesRoutesGenerator.movie,
              arguments: movies.data![index],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: MovieFront(
                movies.data![index].image,
              ),
            ),
          ),
        );
      }
    }

    return Container();
  }
}
