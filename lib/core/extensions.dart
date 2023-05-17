import 'dart:math';

import 'package:flutter/material.dart';
import 'package:movie_theater/core/constants.dart';
import 'package:movie_theater/models/movie/movie.dart';
import 'package:movie_theater/models/session/room_model.dart';
import 'package:movie_theater/models/session/row.dart' as row;
import 'package:movie_theater/models/session/seat_model.dart';
import 'package:movie_theater/models/session/seat_type.dart';

import 'package:movie_theater/models/session/session.dart';
import 'package:movie_theater/models/session/session_model.dart';
import 'package:movie_theater/models/session/session_ui.dart';
import 'package:movie_theater/models/ticket/ticket_model.dart';

extension SessionsExtension on List<Session> {
  List<SessionModel> toSessionModels(Movie movie) => map(
        (session) => SessionModel.fromSessionAndMovie(
          session,
          movie,
        ),
      ).toList();
}

extension SessionModelsExtension on List<SessionModel> {
  List<SessionUi> fillWithEmpties() {
    final newSessions = <SessionUi>[];
    var currentDuration = 0;

    final day = DateTime.fromMillisecondsSinceEpoch(
      first.date * 1000,
      isUtc: true,
    );
    final startOfDay = DateTime.utc(day.year, day.month, day.day);
    if (!startOfDay.isAtSameMomentAs(day)) {
      currentDuration = day.difference(startOfDay).inMinutes;
      newSessions.add(
        SessionUi(
          id: -1,
          colors: [Colors.transparent],
          title: "",
          durationInMinutes: currentDuration,
        ),
      );
    }

    for (int i = 0; i < length; i++) {
      newSessions.add(
        this[i].toSessionUi(),
      );
      if (i != length - 1) {
        if ((this[i + 1].date - this[i].date) / 60.0 - this[i].duration != 0) {
          newSessions.add(
            SessionUi(
              id: -1,
              title: "",
              colors: [Colors.transparent],
              durationInMinutes:
                  ((this[i + 1].date - this[i].date) / 60.0 - this[i].duration)
                      .toInt(),
            ),
          );
        }
      }
    }
    final lastInDay = DateTime.fromMillisecondsSinceEpoch(
      last.date * 1000,
      isUtc: true,
    ).add(
      Duration(minutes: last.duration),
    );
    final endOfDay = DateTime.utc(day.year, day.month, day.day).add(
      const Duration(days: 1),
    );
    if (lastInDay.isBefore(endOfDay)) {
      newSessions.add(
        SessionUi(
          id: -1,
          title: "",
          durationInMinutes: (endOfDay.difference(lastInDay).inMinutes),
          colors: [Colors.transparent],
        ),
      );
    } else if (lastInDay.isAfter(endOfDay)) {
      final lastHour = last.getLastHour() - 24;
      final lastHourDate = DateTime.utc(
          lastInDay.year, lastInDay.month, lastInDay.day, lastHour);
      final minutesDiference = lastHourDate.difference(lastInDay).inMinutes;
      newSessions.add(
        SessionUi(
          id: -1,
          title: "",
          durationInMinutes: minutesDiference,
          colors: [Colors.transparent],
        ),
      );
    }
    return newSessions;
  }

  List<SessionModel> removeCopiesAndOlds() {
    final list = <SessionModel>[];

    final set = toSet();
    final withoutOlds =
        set.where((element) => element.date.isGonnaCatch()).toList();
    return withoutOlds;
  }
}

extension SessionUIExtension on SessionModel {
  int getLastHour() {
    var endTime = DateTime.fromMillisecondsSinceEpoch(
      date * 1000,
      isUtc: true,
    );

    final endOfDay = DateTime.utc(endTime.year, endTime.month, endTime.day)
        .add(const Duration(days: 1));

    endTime = endTime.add(
      Duration(minutes: duration),
    );

    if (endTime.isBefore(endOfDay)) {
      return 24;
    }

    var lastHour =
        DateTime.utc(endTime.year, endTime.month, endTime.day, endTime.hour);

    if (endTime.minute != 0) {
      lastHour = lastHour.add(const Duration(hours: 1));
    }
    return 24 + lastHour.hour;
  }
}

extension NumExtension on num {
  double toPixels() {
    const oneMinute = hourHeight / 60.0;
    return this * oneMinute;
  }

  bool isInt() {
    return toDouble() == toInt();
  }
}

extension RoomModelsExtension on List<RoomModel> {
  List<Widget> toTexts() => map(
        (room) => Text(
          room.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ).toList();
}

extension RowsExtension on List<row.Row> {
  List<List<SeatModel>> toSeats() => map(
        (row) => row.seats
            .map(
              (seat) => seat.toSeatModel(row.index),
            )
            .toList(),
      ).toList();
}

extension DoubleExtension on double {
  bool isFront() {
    final value = abs();
    final pis = value ~/ pi;
    final remainder = value - pis * pi;

    if (pis % 2 == 0) {
      return remainder < pi / 2;
    } else {
      return remainder > pi / 2;
    }
  }
}

extension TicketExtension on TicketModel {
  bool isSameSession(TicketModel other) =>
      date == other.date && movieId == other.movieId;
}

extension TicketsExtension on List<TicketModel> {
  List<List<TicketModel>> groupSimiliar() {
    final result = <List<TicketModel>>[];
    final list = [...this];
    forEach((ticket) {
      final similiar =
          list.where((element) => ticket.isSameSession(element)).toList();
      if (similiar.isNotEmpty) {
        result.add(similiar);
        list.removeWhere((element) => ticket.isSameSession(element));
      }
    });
    return result;
  }
}

extension DateTimeExtension on DateTime {
  bool isSameDay(DateTime other) =>
      year == other.year && month == other.month && day == other.day;
}

extension IntExtension on int {
  String toHoursMinutes() {
    final hours = this ~/ 60;
    final minutes = remainder(60);
    var result = "";
    if (hours < 10) {
      result = "0$hours:";
    } else {
      result = "$hours:";
    }
    if (minutes < 10) {
      result = "${result}0$minutes";
    } else {
      result = "$result$minutes";
    }
    return result;
  }

  bool isGonnaCatch() {
    final date = DateTime.fromMillisecondsSinceEpoch((this + 20 * 60) * 1000,
        isUtc: true);
    final realDate = DateTime(
        date.year, date.month, date.day, date.hour, date.minute, date.second);
    final now = DateTime.now();
    final isAfter = realDate.isAfter(now);

    return isAfter;
  }
}

extension NavigatorExtension on NavigatorState {
  String get currentRoute {
    late final String myRoute;
    popUntil((route) {
      myRoute = route.settings.name ?? "";
      return true;
    });
    return myRoute;
  }
}

extension SeatModelsExtension on List<SeatModel> {
  Map<SeatType, int> countTypes() {
    final map = <SeatType, int>{};
    forEach((seat) {
      if (map.containsKey(seat.type)) {
        map.update(seat.type, (value) => value + 1);
      } else {
        map.putIfAbsent(seat.type, () => 1);
      }
    });
    return map;
  }
}

extension ListListsExtension on List<List<Object>> {
  int findMaxLenght() {
    int maxLenght = 0;
    forEach((list) {
      maxLenght = max(maxLenght, list.length);
    });
    return maxLenght;
  }
}

extension ColorExtension on Color {
  bool isLight() {
    final grayscale = (0.299 * red) + (0.587 * green) + (0.114 * blue);
    return grayscale > 128;
  }
}
