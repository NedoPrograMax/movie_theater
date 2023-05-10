import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:movie_theater/models/movie/movie_model.dart';
import 'package:movie_theater/widgets/movies/sessions_list.dart';

class MovieFront extends StatelessWidget {
  final String image;
  const MovieFront(this.image, {super.key});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: image,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              image,
            ),
          ),
        ),
      ),
    );
  }
}
