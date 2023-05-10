import 'package:json_annotation/json_annotation.dart';
import 'package:movie_theater/models/session/seat_model.dart';
import 'package:movie_theater/models/session/seat_type.dart';

part 'seat.g.dart';

@JsonSerializable()
class Seat {
  Seat({
    required this.id,
    required this.index,
    required this.type,
    required this.price,
    required this.isAvailable,
  });

  final int id;
  final int index;
  final int type;
  final int price;
  final bool isAvailable;

  factory Seat.fromJson(Map<String, dynamic> json) => _$SeatFromJson(json);

  Map<String, dynamic> toJson() => _$SeatToJson(this);

  SeatModel toSeatModel(int row) => SeatModel(
        row: row,
        id: id,
        index: index,
        type: SeatType.values[type],
        price: price,
        isAvailable: isAvailable,
      );
}
