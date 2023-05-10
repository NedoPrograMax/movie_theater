import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:movie_theater/widgets/movie/percent_clipper.dart';

class PartOfStar extends StatelessWidget {
  final double percent;
  const PartOfStar(this.percent, {super.key});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: PercentClipper(percent),
      child: const Icon(
        Icons.star,
        color: Colors.amber,
        size: 40,
      ),
    );
  }
}
