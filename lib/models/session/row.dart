import 'package:json_annotation/json_annotation.dart';

import 'seat.dart';

part 'row.g.dart';

@JsonSerializable(explicitToJson: true)
class Row {
  Row({
    required this.id,
    required this.index,
    required this.seats,
  });

  final int id;
  final int index;
  final List<Seat> seats;

  factory Row.fromJson(Map<String, dynamic> json) => _$RowFromJson(json);

  Map<String, dynamic> toJson() => _$RowToJson(this);
}
