import 'package:movie_theater/models/session/seat_type.dart';

class SeatModel {
  SeatModel({
    required this.row,
    required this.id,
    required this.index,
    required this.type,
    required this.price,
    required this.isAvailable,
  });

  final int row;
  final int id;
  final int index;
  final SeatType type;
  final int price;
  final bool isAvailable;
}
