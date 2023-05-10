import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_theater/state/comments_cubit/comments_cubit.dart';
import 'package:movie_theater/state/comments_cubit/comments_state.dart';
import 'package:movie_theater/widgets/movie/comment_item.dart';

class Comments extends StatelessWidget {
  const Comments({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return BlocBuilder<CommentsCubit, CommentsState>(
        buildWhen: (previous, current) => previous.comments != current.comments,
        builder: (context, state) {
          if (state.comments.isNotEmpty) {
            return ConstrainedBox(
              constraints: BoxConstraints(maxHeight: height * 0.15),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.all(0),
                shrinkWrap: true,
                itemCount: state.comments.length,
                itemBuilder: (context, index) => CommentItem(
                  state.comments[index],
                ),
              ),
            );
          }
          return Container();
        });
  }
}
