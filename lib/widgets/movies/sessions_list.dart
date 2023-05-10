import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:movie_theater/models/session/movie_session.dart';
import 'package:movie_theater/widgets/movies/movie_session_item.dart';
import 'package:movie_theater/widgets/room/session_item.dart';

class SessionsList extends StatelessWidget {
  final List<MovieSession> sessions;
  const SessionsList(this.sessions, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: sessions.length,
      itemBuilder: (context, index) => Center(
        child: MovieSessionItem(
          sessions[index],
        ),
      ),
    );
  }
}
