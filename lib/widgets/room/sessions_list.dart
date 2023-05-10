import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:movie_theater/state/room_cubit/room_cubit.dart';
import 'package:movie_theater/state/room_cubit/room_cubit_state.dart';
import 'package:movie_theater/widgets/room/session_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SesionsList extends StatelessWidget {
  final ScrollController controller;
  const SesionsList(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomCubit, RoomCubitState>(
      builder: (context, state) => Padding(
        padding: const EdgeInsets.only(left: 50, right: 5),
        child: ListView.builder(
          controller: controller,
          itemCount: state.sessions.length,
          itemBuilder: (context, index) => SessionItem(state.sessions[index]),
        ),
      ),
    );
  }
}
