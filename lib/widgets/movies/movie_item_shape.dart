import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:movie_theater/models/movie/movie_model.dart';
import 'package:movie_theater/widgets/movies/movie_back.dart';
import 'package:movie_theater/widgets/movies/movie_front.dart';
import 'package:movie_theater/widgets/paying/back_card_content.dart';
import 'package:movie_theater/widgets/paying/front_card_content.dart';

class MovieItemShape extends StatefulWidget {
  final bool isFront;
  final MovieModel movie;
  const MovieItemShape({required this.isFront, required this.movie, super.key});

  @override
  State<MovieItemShape> createState() => _MovieItemShapeState();
}

class _MovieItemShapeState extends State<MovieItemShape> {
  late final MovieFront frontCardContent;
  late final MovieBack backCardContent;
  @override
  void initState() {
    frontCardContent = MovieFront(widget.movie.image);
    backCardContent = MovieBack(movie: widget.movie);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: AspectRatio(
        aspectRatio: 2 / 3,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  widget.movie.colors.first,
                  widget.movie.colors.first.withAlpha(100),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  offset: Offset(0, 5),
                  blurRadius: 4,
                  spreadRadius: 0.1,
                  color: Colors.black,
                ),
              ]),
          child: IndexedStack(
            index: widget.isFront ? 0 : 1,
            children: [frontCardContent, backCardContent],
          ),
        ),
      ),
    );
  }
}
