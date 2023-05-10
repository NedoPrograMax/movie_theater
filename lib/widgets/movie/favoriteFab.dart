import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:movie_theater/initialize.dart';
import 'package:movie_theater/repositories/local_repository.dart';

class FavoriteFab extends HookWidget {
  final int movieId;
  const FavoriteFab(this.movieId, {super.key});

  @override
  Widget build(BuildContext context) {
    final isFavorite = useState(sl<LocalRepository>().isFavorite(movieId));

    return FloatingActionButton(
      onPressed: () {
        if (isFavorite.value) {
          sl<LocalRepository>().removeFavorite(movieId);
        } else {
          sl<LocalRepository>().addFavorite(movieId);
        }
        isFavorite.value = !isFavorite.value;
      },
      child: Icon(
        isFavorite.value ? Icons.favorite : Icons.favorite_border,
      ),
    );
  }
}
