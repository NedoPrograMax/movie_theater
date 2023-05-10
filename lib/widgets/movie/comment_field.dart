import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:movie_theater/generated/locale_keys.g.dart';
import 'package:movie_theater/state/comments_cubit/comments_cubit.dart';
import 'package:movie_theater/state/comments_cubit/comments_state.dart';

class CommentField extends HookWidget {
  const CommentField({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    return BlocListener<CommentsCubit, CommentsState>(
      listenWhen: (previous, current) => current.content.isEmpty,
      listener: (context, state) {
        controller.text = state.content;
      },
      child: TextField(
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: LocaleKeys.comment_hint.tr(),
        ),
        maxLines: 3,
        controller: controller,
        minLines: 1,
        onChanged: (value) => context.read<CommentsCubit>().content = value,
        onSubmitted: (value) async {
          final success = await context.read<CommentsCubit>().postComment();
          if (success) {
            context.read<CommentsCubit>().reset();
            context.read<CommentsCubit>().updateComments();
          }
        },
      ),
    );
  }
}
