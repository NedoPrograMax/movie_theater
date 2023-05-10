import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:movie_theater/repositories/network_repository.dart';
import 'package:movie_theater/initialize.dart';
import 'package:movie_theater/models/comment/comment.dart';
import 'package:movie_theater/state/comments_cubit/comments_cubit.dart';
import 'package:movie_theater/widgets/movie/comment_rating.dart';

class CommentItem extends HookWidget {
  final Comment comment;
  const CommentItem(this.comment, {super.key});

  @override
  Widget build(BuildContext context) {
    final controller = useScrollController();
    final width = MediaQuery.of(context).size.width;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onLongPress: !comment.isMy
            ? null
            : () async {
                if (await sl<NetworkRepository>().deleteComment(comment.id)) {
                  context.read<CommentsCubit>().updateComments();
                }
              },
        child: Ink(
          child: Container(
            width: width * 0.5,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).cardColor,
                  Colors.grey,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const SizedBox(width: 20),
                    Text(
                      comment.author ?? "App user",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (comment.isMy)
                      const Icon(
                        Icons.circle,
                        size: 8,
                        color: Colors.red,
                      )
                  ],
                ),
                const SizedBox(height: 5),
                CommentRating(comment.rating ?? 0),
                Expanded(
                  child: NotificationListener<OverscrollNotification>(
                    // Suppress OverscrollNotification events that escape from the inner scrollable
                    onNotification: (notification) =>
                        notification.metrics.axisDirection !=
                        AxisDirection.left,
                    child: SingleChildScrollView(
                      controller: controller,
                      //    physics: const NeverScrollableScrollPhysics(),
                      child: Text(comment.content ?? ""),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
