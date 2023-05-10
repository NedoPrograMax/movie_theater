import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:movie_theater/core/extensions.dart';
import 'package:movie_theater/repositories/network_repository.dart';
import 'package:movie_theater/initialize.dart';
import 'package:movie_theater/state/movie_cubit/movie_cubit.dart';
import 'package:movie_theater/state/movie_cubit/movie_state.dart';
import 'package:movie_theater/widgets/movie_chooser/movie_chooser_content.dart';
import 'package:movie_theater/widgets/movies/movies_screen.dart';

import '../room/rooms_screen.dart';

class MovieChooser extends HookWidget {
  const MovieChooser({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieCubit, MovieState>(
      buildWhen: (previous, current) {
        return !current.choosedDate.isSameDay(previous.choosedDate);
      },
      builder: (context, state) => MovieChooserContent(state.choosedDate),
    );
  }
}
