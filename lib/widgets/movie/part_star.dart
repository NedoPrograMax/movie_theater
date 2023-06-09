import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:movie_theater/widgets/movie/part_of_start.dart';
import 'package:movie_theater/widgets/movie/percent_clipper.dart';

class PartStar extends StatelessWidget {
  final double percent;
  const PartStar(this.percent, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Icon(
          Icons.star,
          size: 40,
        ),
        PartOfStar(percent),
      ],
    );
  }
}
