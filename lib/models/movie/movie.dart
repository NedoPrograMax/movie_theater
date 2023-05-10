import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_theater/core/utils.dart';
import 'package:movie_theater/models/movie/movie_model.dart';
import 'package:movie_theater/models/session/movie_session.dart';
import 'package:movie_theater/models/session/seat_model.dart';
import 'package:movie_theater/models/session/session.dart';
import 'package:movie_theater/models/session/session_model.dart';
import 'package:uuid/uuid.dart';

import '../ticket/ticket_model.dart';

part 'movie.g.dart';

@JsonSerializable()
class Movie {
  Movie({
    required this.id,
    required this.name,
    required this.age,
    required this.trailer,
    required this.image,
    required this.smallImage,
    required this.originalName,
    required this.duration,
    required this.language,
    required this.rating,
    required this.year,
    required this.country,
    required this.genre,
    required this.plot,
    required this.starring,
    required this.director,
    required this.screenwriter,
    required this.studio,
  });

  final int id;
  final String name;
  final int age;
  final String trailer;
  final String image;
  final String smallImage;
  final String originalName;
  final int duration;
  final String language;
  final String rating;
  final int year;
  final String country;
  final String genre;
  final String plot;
  final String starring;
  final String director;
  final String screenwriter;
  final String studio;

  Movie.empty()
      : id = 0,
        name = "",
        age = 0,
        trailer = "",
        image = "",
        smallImage = "",
        originalName = "",
        duration = 0,
        language = "",
        rating = '',
        year = 0,
        country = '',
        genre = '',
        plot = '',
        starring = '',
        director = '',
        screenwriter = '',
        studio = '';

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);

  Map<String, dynamic> toJson() => _$MovieToJson(this);

  Future<TicketModel> toTicket({
    required int date,
    required String roomName,
    required SeatModel seat,
  }) async =>
      TicketModel(
        movieId: id,
        name: name,
        image: image,
        id: const Uuid().v4().hashCode,
        roomName: roomName,
        rowIndex: seat.row,
        seatIndex: seat.index,
        smallImage: smallImage,
        date: date,
        colors: await getColors(
          image,
        ),
      );

  Future<MovieModel> toMovieModel(List<SessionModel> sessions) async =>
      MovieModel(
        id: id,
        image: image,
        colors: await getColors(image),
        sessions:
            sessions.map((session) => session.toMovieSession(duration)).toList()
              ..sort(
                (a, b) => a.start.compareTo(b.start),
              ),
      );
}
