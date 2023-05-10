import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_theater/core/extensions.dart';
import 'package:movie_theater/models/session/room_model.dart';
import 'package:movie_theater/state/room_cubit/room_cubit.dart';
import 'package:movie_theater/state/room_cubit/room_cubit_state.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class RoomChooser extends HookWidget {
  final List<RoomModel> rooms;
  RoomChooser(this.rooms, {super.key});

  @override
  Widget build(BuildContext context) {
    final tabController = useTabController(initialLength: rooms.length);
    useEffect(() {
      tabController.addListener(() {
        context.read<RoomCubit>().setRoomByIndex(tabController.index);
      });
      return null;
    });

    return BlocListener<RoomCubit, RoomCubitState>(
      child: SizedBox(
        height: 50,
        child: TabBarView(
          viewportFraction: 0.5,
          controller: tabController,
          children: rooms.toTexts(),
        ),
      ),
      listener: (context, state) {
        final currentRoomIndex =
            state.rooms.indexWhere((element) => element.id == state.roomId);
        tabController.animateTo(currentRoomIndex);
      },
    );
  }
}
