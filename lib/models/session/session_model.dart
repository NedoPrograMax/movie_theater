import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:movie_theater/core/extensions.dart';
import 'package:movie_theater/core/utils.dart';
import 'package:movie_theater/initialize.dart';
import 'package:movie_theater/models/movie/movie.dart';
import 'package:movie_theater/models/session/movie_session.dart';
import 'package:movie_theater/models/session/room_model.dart';
import 'package:movie_theater/models/session/session.dart';
import 'package:movie_theater/models/session/session_ui.dart';
import 'package:movie_theater/repositories/api_repository.dart';

class SessionModel extends Equatable {
  final int id;
  final String title;

  final int date;
  final int duration;
  final RoomModel room;
  final int movieId;
  List<Color>? colors;

  SessionModel({
    required this.id,
    required this.title,
    required this.date,
    required this.duration,
    required this.room,
    required this.movieId,
    this.colors,
  });

  factory SessionModel.fromSessionAndMovie(Session session, Movie movie) {
    return SessionModel(
      id: session.id,
      title: movie.originalName,
      date: session.date,
      duration: movie.duration,
      room: session.room.toRoomModel(),
      movieId: movie.id,
    );
  }

  SessionUi toSessionUi() => SessionUi(
        id: id,
        title: title,
        durationInMinutes: duration,
        colors: colors ?? [Colors.transparent],
      );

  MovieSession toMovieSession(int duration) => MovieSession(
      start: DateTime.fromMillisecondsSinceEpoch(
        date * 1000,
        isUtc: true,
      ),
      duration: Duration(minutes: duration),
      id: id);

  @override
  // TODO: implement props
  List<Object?> get props => [date, room.id];
}
