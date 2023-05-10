import 'package:movie_theater/models/movie/movie.dart';
import 'package:movie_theater/models/session/session.dart';

class MovieState {
  final Movie currentMovie;
  final DateTime choosedDate;

  MovieState({
    required this.choosedDate,
    required this.currentMovie,
  });
}
