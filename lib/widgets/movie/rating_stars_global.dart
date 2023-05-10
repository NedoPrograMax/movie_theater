import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:movie_theater/widgets/movie/part_star.dart';
import 'package:movie_theater/widgets/movie/rating_star.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingStarsGlobal extends StatelessWidget {
  final double rating;
  const RatingStarsGlobal(this.rating, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < rating.toInt(); i++) const PartStar(1),
        if (rating != 5.0) PartStar(rating.remainder(1)),
        if (rating < 4) const PartStar(0)
      ],
    );
  }
}
