import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_theater/state/room_cubit/room_cubit.dart';
import 'package:movie_theater/state/room_cubit/room_cubit_state.dart';
import 'package:movie_theater/widgets/room/hour_item.dart';

class HoursList extends StatelessWidget {
  final ScrollController controller;
  const HoursList(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomCubit, RoomCubitState>(
      builder: (context, state) => ListView.builder(
        controller: controller,
        itemCount: state.hoursCount,
        itemBuilder: (context, index) {
          final color =
              index % 2 == 0 ? Colors.grey.shade600 : Colors.grey.shade800;
          final myIndex = index % 24;
          final hourString = myIndex < 10 ? "0$myIndex" : myIndex.toString();
          return HourItem(
            color: color,
            time: "$hourString:00",
          );
        },
      ),
      buildWhen: (previous, current) =>
          previous.hoursCount != current.hoursCount,
    );
  }
}
