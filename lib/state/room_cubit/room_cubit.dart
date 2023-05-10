import 'package:bloc/bloc.dart';
import 'package:movie_theater/repositories/network_repository.dart';
import 'package:movie_theater/core/extensions.dart';
import 'package:movie_theater/models/session/room_model.dart';
import 'package:movie_theater/models/session/seat_model.dart';

import 'package:movie_theater/models/session/session_model.dart';
import 'package:movie_theater/state/room_cubit/room_cubit_state.dart';

import '../../initialize.dart';
import '../../models/session/seat.dart';

class RoomCubit extends Cubit<RoomCubitState> {
  List<SessionModel> allSessions = [];
  List<RoomModel> rooms = [];
  int chosedSessionId = 0;
  RoomCubit()
      : super(
          const RoomCubitState(
            roomId: -1,
            sessions: [],
            hoursCount: 24,
            rooms: [],
            movie: null,
          ),
        );

  void setSessions(List<SessionModel> sessions) {
    if (sessions.isEmpty) {
      return;
    }
    final Set<RoomModel> roomsSet = {};
    allSessions = sessions;
    allSessions.forEach(
      (session) => roomsSet.add(session.room),
    );
    rooms = roomsSet.toList();
    setRoom(allSessions.first.room.id);
  }

  void setRoom(int roomId) {
    final choosedSessions =
        allSessions.where((session) => session.room.id == roomId).toList();
    choosedSessions.sort(
      (a, b) => a.date.compareTo(b.date),
    );
    chosedSessionId = choosedSessions.first.id;
    emit(
      RoomCubitState(
        roomId: roomId,
        sessions: choosedSessions.removeCopiesAndOlds().fillWithEmpties(),
        hoursCount: choosedSessions.last.getLastHour(),
        rooms: rooms,
        movie: sl<NetworkRepository>()
            .getMovieFromCache(choosedSessions.first.movieId),
      ),
    );
  }

  void setRoomByIndex(int index) {
    final roomId = state.rooms[index].id;
    setRoom(roomId);
  }

  void chooseSession(int sessionId) {
    chosedSessionId = sessionId;
    final choosedSession =
        allSessions.firstWhere((session) => session.id == sessionId);
    final choosedMovie =
        sl<NetworkRepository>().getMovieFromCache(choosedSession.movieId);
    emit(
      state.copyWith(movie: choosedMovie),
    );
  }

  Future<List<List<SeatModel>>> getSeats() async {
    final session = await sl<NetworkRepository>().fetchSession(chosedSessionId);
    return session.room.rows.toSeats();
  }
}
