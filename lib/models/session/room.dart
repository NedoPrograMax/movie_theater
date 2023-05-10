import 'package:json_annotation/json_annotation.dart';
import 'package:movie_theater/models/session/room_model.dart';

import 'row.dart';

part 'room.g.dart';

@JsonSerializable(explicitToJson: true)
class Room {
  Room({
    required this.id,
    required this.name,
    required this.rows,
  });

  final int id;
  final String name;
  final List<Row> rows;

  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);

  Map<String, dynamic> toJson() => _$RoomToJson(this);

  RoomModel toRoomModel() => RoomModel(
        name: name,
        id: id,
      );
}
