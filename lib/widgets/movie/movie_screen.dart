import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:movie_theater/repositories/api_repository.dart';
import 'package:movie_theater/initialize.dart';
import 'package:movie_theater/models/movie/movie.dart';
import 'package:movie_theater/models/session/movie_session.dart';
import 'package:movie_theater/state/comments_cubit/comments_cubit.dart';
import 'package:movie_theater/widgets/movie/comment_field.dart';
import 'package:movie_theater/widgets/movie/comments.dart';
import 'package:movie_theater/widgets/movie/favoriteFab.dart';
import 'package:movie_theater/widgets/movie/movie_image_clipper.dart';
import 'package:movie_theater/widgets/movie/movie_main_info.dart';
import 'package:movie_theater/widgets/movie/my_comment.dart';
import 'package:movie_theater/widgets/movie/trailer_player.dart';
import 'package:movie_theater/widgets/movie/rating_stars.dart';
import 'package:movie_theater/widgets/movie/video_slider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieScreen extends StatefulWidget {
  final Movie movie;

  const MovieScreen({
    required this.movie,
    super.key,
  });

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  @override
  void initState() {
    context.read<CommentsCubit>().updateComments(widget.movie.id);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final imageHeight = width * 1.5;

    return WillPopScope(
      onWillPop: () {
        context.read<CommentsCubit>().reset();
        return Future.value(true);
      },
      child: Scaffold(
        floatingActionButton: FavoriteFab(widget.movie.id),
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Hero(
                tag: widget.movie.image,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(imageHeight * 0.3),
                    ),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.network(
                    widget.movie.image,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              MovieMainInfo(widget.movie),
              TrailerPlayer(trailer: widget.movie.trailer),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: const [
                    MyComment(),
                    SizedBox(height: 10),
                    Comments(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
