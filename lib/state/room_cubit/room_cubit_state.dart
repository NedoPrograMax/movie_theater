import 'package:movie_theater/models/session/room_model.dart';
import 'package:movie_theater/models/session/session.dart';
import 'package:movie_theater/models/session/session_ui.dart';

import '../../models/movie/movie.dart';

class RoomCubitState {
  final int roomId;
  final List<RoomModel> rooms;
  final List<SessionUi> sessions;
  final int hoursCount;
  final Movie? movie;

  const RoomCubitState({
    required this.roomId,
    required this.sessions,
    required this.hoursCount,
    required this.rooms,
    required this.movie,
  });

  RoomCubitState copyWith({
    int? roomId,
    List<RoomModel>? rooms,
    List<SessionUi>? sessions,
    int? hoursCount,
    Movie? movie,
  }) =>
      RoomCubitState(
        roomId: roomId ?? this.roomId,
        sessions: sessions ?? this.sessions,
        hoursCount: hoursCount ?? this.hoursCount,
        rooms: rooms ?? this.rooms,
        movie: movie ?? this.movie,
      );
}
