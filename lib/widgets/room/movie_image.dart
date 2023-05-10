import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:movie_theater/core/constants.dart';
import 'package:movie_theater/core/utils.dart';
import 'package:movie_theater/state/room_cubit/room_cubit.dart';
import 'package:movie_theater/state/room_cubit/room_cubit_state.dart';

class MovieImage extends HookWidget {
  final String path;
  const MovieImage(this.path, {super.key});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      path,
      fit: BoxFit.fitHeight,
    );
  }
}
