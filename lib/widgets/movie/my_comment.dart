import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_theater/state/comments_cubit/comments_cubit.dart';
import 'package:movie_theater/state/comments_cubit/comments_state.dart';
import 'package:movie_theater/widgets/movie/rating_stars.dart';

import 'comment_field.dart';

class MyComment extends StatelessWidget {
  const MyComment({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const RatingStars(),
            BlocBuilder<CommentsCubit, CommentsState>(
              builder: (context, state) => IconButton(
                onPressed: state.content.isEmpty && state.rating == 0
                    ? null
                    : () async {
                        final success =
                            await context.read<CommentsCubit>().postComment();
                        if (success) {
                          context.read<CommentsCubit>().reset();
                          context.read<CommentsCubit>().updateComments();
                        }
                      },
                icon: const Icon(
                  Icons.send,
                ),
              ),
            )
          ],
        ),
        const CommentField(),
      ],
    );
  }
}
