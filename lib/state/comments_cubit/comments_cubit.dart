import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_theater/repositories/network_repository.dart';
import 'package:movie_theater/initialize.dart';
import 'package:movie_theater/state/comments_cubit/comments_state.dart';

class CommentsCubit extends Cubit<CommentsState> {
  int lastMovieId = 0;

  CommentsCubit()
      : super(
          CommentsState(
            comments: [],
            rating: 0,
            content: "",
          ),
        );

  set content(String value) => emit(state.copyWith(content: value));

  void setRating(double value) => emit(state.copyWith(rating: value));

  void updateComments([int? movieId]) async {
    if (movieId != null) {
      lastMovieId = movieId;
    }
    final comments = await sl<NetworkRepository>().fetchComments(lastMovieId);
    final my = comments
        .where(
          (element) => element.isMy,
        )
        .toList();
    comments.removeWhere(
      (element) => element.isMy,
    );
    my.addAll(comments);
    emit(
      state.copyWith(
        comments: my,
      ),
    );
  }

  Future<bool> postComment() => sl<NetworkRepository>().postComments(
        lastMovieId,
        state.content,
        state.rating,
      );

  void reset() {
    lastMovieId = 0;

    emit(
      CommentsState(
        comments: [],
        rating: 0,
        content: "",
      ),
    );
  }
}
