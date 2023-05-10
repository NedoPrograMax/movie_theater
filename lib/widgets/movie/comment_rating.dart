import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_theater/state/comments_cubit/comments_cubit.dart';
import 'package:movie_theater/state/comments_cubit/comments_state.dart';
import 'package:movie_theater/state/movie_cubit/movie_cubit.dart';
import 'package:movie_theater/widgets/movie/rating_star.dart';

class CommentRating extends StatelessWidget {
  final int rating;
  const CommentRating(this.rating, {super.key});

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: rating.toDouble(),
      minRating: 0,
      itemSize: 15,
      direction: Axis.horizontal,
      allowHalfRating: false,
      itemCount: 5,
      itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
      ignoreGestures: true,
      onRatingUpdate: (double value) {},
    );
  }
}
