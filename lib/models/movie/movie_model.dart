import 'package:flutter/material.dart';
import 'package:movie_theater/models/session/movie_session.dart';

class MovieModel {
  final int id;
  final String image;
  final List<MovieSession> sessions;
  final List<Color> colors;

  MovieModel({
    required this.id,
    required this.image,
    required this.sessions,
    required this.colors,
  });
}
