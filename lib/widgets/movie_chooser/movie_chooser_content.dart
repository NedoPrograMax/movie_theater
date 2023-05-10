import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:movie_theater/models/movie/movie_model.dart';
import 'package:movie_theater/repositories/api_repository.dart';
import 'package:movie_theater/initialize.dart';
import 'package:movie_theater/state/movie_cubit/movie_cubit.dart';
import 'package:movie_theater/widgets/locale_update_observer.dart';
import 'package:movie_theater/widgets/lotties/loading_movie.dart';
import 'package:movie_theater/widgets/movies/movies_screen.dart';
import 'package:easy_search_bar/easy_search_bar.dart';

import '../room/rooms_screen.dart';

class MovieChooserContent extends HookWidget {
  final DateTime date;
  const MovieChooserContent(this.date, {super.key});

  @override
  Widget build(BuildContext context) {
    Timer? timer;
    final controller = useAnimationController(
      duration: const Duration(milliseconds: 300),
    );

    final currentIndex = useState(0);
    final shouldRerunState = useState(1);
    final currentSearch = useState("");

    useEffect(() {
      currentSearch.addListener(
        () {
          if (timer != null) {
            timer?.cancel();
            timer = null;
          }

          timer = Timer(const Duration(milliseconds: 1500), () {
            shouldRerunState.value++;
          });
        },
      );
    }, [currentSearch]);
    final moviesFuture = useMemoized(
      () => sl<ApiRepository>().fetchMovieModels(
        date,
        currentSearch.value,
      ),
      [date, shouldRerunState.value],
    );
    final movies = useFuture(moviesFuture, preserveState: false);

    return Scaffold(
        appBar: currentIndex.value == 0
            ? buildSearchBar(controller, currentIndex, currentSearch, context)
            : buildAppBar(
                controller,
                currentIndex,
                context,
              ),
        body: movies.hasData
            ? ValueListenableBuilder(
                valueListenable: currentIndex,
                builder: (context, value, child) => IndexedStack(
                  index: value,
                  children: [
                    FadeTransition(
                      opacity: controller.drive(
                        Tween(begin: 1, end: 0),
                      ),
                      child: MoviesScreen(movies.data!),
                    ),
                    FadeTransition(
                      opacity: controller.drive(
                        Tween(begin: 0, end: 1),
                      ),
                      child: RoomsScreen(sl<ApiRepository>().sessionModels),
                    ),
                  ],
                ),
              )
            : const Center(
                child: LoadingMovie(),
              ));
  }
}

AppBar buildAppBar(
  AnimationController controller,
  ValueNotifier<int> currentIndex,
  BuildContext context,
) {
  return AppBar(
    backgroundColor: Theme.of(context).brightness == Brightness.dark
        ? Colors.grey.shade900
        : Colors.blue.shade300,
    actions: buildDefaultActions(
      controller,
      currentIndex,
      context,
    ),
  );
}

PreferredSizeWidget buildSearchBar(
  AnimationController controller,
  ValueNotifier<int> currentIndex,
  ValueNotifier<String> currentSearch,
  BuildContext context,
) {
  return EasySearchBar(
    backgroundColor: Theme.of(context).brightness == Brightness.dark
        ? Colors.grey.shade900
        : Colors.blue.shade400,
    title: const Text(""),
    onSearch: (value) => currentSearch.value = value,
    actions: buildDefaultActions(
      controller,
      currentIndex,
      context,
    ),
  );
}

List<Widget> buildDefaultActions(
  AnimationController controller,
  ValueNotifier<int> currentIndex,
  BuildContext context,
) {
  return [
    IconButton(
      onPressed: () {
        if (controller.value == 1) {
          controller.reverse().then((value) => currentIndex.value = 0);
        } else {
          controller.forward().then((value) => currentIndex.value = 1);
        }
      },
      icon: const Icon(Icons.loop),
    ),
    IconButton(
      onPressed: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: context.read<MovieCubit>().state.choosedDate,
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(
            const Duration(days: 28),
          ),
        );
        if (date != null) {
          context.read<MovieCubit>().setDate(date);
        }
      },
      icon: const Icon(Icons.calendar_month),
    ),
  ];
}
