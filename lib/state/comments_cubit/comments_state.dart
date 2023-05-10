import 'package:movie_theater/models/comment/comment.dart';

class CommentsState {
  final String content;
  final double rating;
  final List<Comment> comments;

  CommentsState({
    required this.content,
    required this.rating,
    required this.comments,
  });

  CommentsState copyWith({
    String? content,
    double? rating,
    List<Comment>? comments,
  }) =>
      CommentsState(
        content: content ?? this.content,
        rating: rating ?? this.rating,
        comments: comments ?? this.comments,
      );
}
