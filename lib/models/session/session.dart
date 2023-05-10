import 'package:json_annotation/json_annotation.dart';
import 'package:movie_theater/models/session/movie_session.dart';

import 'room.dart';

part 'session.g.dart';

@JsonSerializable(explicitToJson: true)
class Session {
  Session({
    required this.id,
    required this.date,
    required this.type,
    required this.minPrice,
    required this.room,
  });

  final int id;
  final int date;
  final String type;
  final int minPrice;
  final Room room;

  factory Session.fromJson(Map<String, dynamic> json) =>
      _$SessionFromJson(json);

  Map<String, dynamic> toJson() => _$SessionToJson(this);
}
