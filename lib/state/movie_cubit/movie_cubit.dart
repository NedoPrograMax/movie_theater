import 'package:bloc/bloc.dart';
import 'package:movie_theater/models/movie/movie.dart';
import 'package:movie_theater/state/movie_cubit/movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  MovieCubit()
      : super(
          MovieState(
            currentMovie: Movie.empty(),
            choosedDate: DateTime.now(),
          ),
        );

  void setMovie(Movie movie) => emit(
        MovieState(
          currentMovie: movie,
          choosedDate: state.choosedDate,
        ),
      );
  void setDate(DateTime date) => emit(
        MovieState(
          currentMovie: state.currentMovie,
          choosedDate: date,
        ),
      );
}
