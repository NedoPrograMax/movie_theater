import 'package:equatable/equatable.dart';

class RoomModel extends Equatable {
  final String name;
  final int id;

  const RoomModel({
    required this.name,
    required this.id,
  });

  @override
  List<Object?> get props => [name, id];
}
