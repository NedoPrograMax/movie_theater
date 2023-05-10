import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';

@JsonSerializable()
class Comment {
  final int id;
  final String? author;
  final String? content;
  final int? rating;
  final bool isMy;

  Comment({
    required this.id,
    required this.author,
    required this.content,
    required this.rating,
    required this.isMy,
  });

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);
}
