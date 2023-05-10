import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:movie_theater/state/room_cubit/room_cubit.dart';
import 'package:movie_theater/state/room_cubit/room_cubit_state.dart';
import 'package:movie_theater/widgets/room/room_chooser.dart';

import 'hours_list.dart';
import 'sessions_list.dart';

class DayScheduale extends StatefulWidget {
  const DayScheduale({super.key});

  @override
  State<DayScheduale> createState() => _DaySchedualeState();
}

class _DaySchedualeState extends State<DayScheduale> {
  late final LinkedScrollControllerGroup _controllers;
  late final ScrollController _hoursScrollController;
  late final ScrollController _sessionsScrollController;

  @override
  void initState() {
    super.initState();
    _controllers = LinkedScrollControllerGroup();
    _hoursScrollController = _controllers.addAndGet();
    _sessionsScrollController = _controllers.addAndGet();
  }

  @override
  void dispose() {
    _hoursScrollController.dispose();
    _sessionsScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          HoursList(_hoursScrollController),
          SesionsList(_sessionsScrollController),
        ],
      ),
    );
  }
}
