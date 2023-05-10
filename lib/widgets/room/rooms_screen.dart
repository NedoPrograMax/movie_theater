import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:movie_theater/repositories/api_repository.dart';

import 'package:movie_theater/models/session/session_model.dart';
import 'package:movie_theater/state/room_cubit/room_cubit.dart';
import 'package:movie_theater/state/room_cubit/room_cubit_state.dart';
import 'package:movie_theater/widgets/room/movie_image.dart';
import 'package:movie_theater/widgets/room/movie_info.dart';

import '../../initialize.dart';
import 'day_scheduale.dart';

class RoomsScreen extends HookWidget {
  final List<SessionModel> sessions;
  RoomsScreen(this.sessions, {super.key});

  @override
  Widget build(BuildContext context) {
    if (sessions.isNotEmpty) {
      useEffect(() {
        context.read<RoomCubit>().setSessions(sessions);
        return null;
      }, [1]);
      return SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  const Expanded(child: DayScheduale()),
                  Expanded(
                    child: BlocBuilder<RoomCubit, RoomCubitState>(
                      builder: (context, state) =>
                          MovieImage(state.movie?.image ?? ""),
                      buildWhen: (previous, current) =>
                          previous.movie?.image != current.movie?.image,
                    ),
                  )
                ],
              ),
            ),
            const Expanded(child: MovieInfo())
          ],
        ),
      );
    } else {
      return Center(
        child: Text("There is no data"),
      );
    }
  }
}
