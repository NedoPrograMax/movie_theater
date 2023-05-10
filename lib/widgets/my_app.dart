import 'package:adaptive_theme/adaptive_theme.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:movie_theater/initialize.dart';
import 'package:movie_theater/repositories/local_repository.dart';
import 'package:movie_theater/services/locale.dart';
import 'package:movie_theater/state/booking_cubit/booking_cubit.dart';
import 'package:movie_theater/state/comments_cubit/comments_cubit.dart';
import 'package:movie_theater/state/movie_cubit/movie_cubit.dart';
import 'package:movie_theater/state/old_tickets_cubit/old_ticket_cubit.dart';
import 'package:movie_theater/state/paying_cubit/paying_cubit.dart';
import 'package:movie_theater/state/room_cubit/room_cubit.dart';

import 'main_screen.dart';

class MyApp extends HookWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final isLight = useMemoized(() => sl<LocalRepository>().isLight);
    Locale.instance().setLocale(context.locale.languageCode);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BookingCubit(),
        ),
        BlocProvider(
          create: (context) => PayingCubit(),
        ),
        BlocProvider(
          create: (_) => RoomCubit(),
        ),
        BlocProvider(
          create: (_) => OldTicketsCubit(),
        ),
        BlocProvider(
          create: (_) => MovieCubit(),
        ),
        BlocProvider(
          create: (_) => CommentsCubit(),
        ),
      ],
      child: AdaptiveTheme(
        light: ThemeData.light().copyWith(
          textTheme: const TextTheme(
            bodyMedium: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 20,
              color: Colors.black38,
            ),
            displayMedium: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.black54,
            ),
          ),
        ),
        dark: ThemeData.dark().copyWith(
          textTheme: TextTheme(
            bodyMedium: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 20,
              color: Colors.grey.shade200,
            ),
            displayMedium: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.grey.shade400,
            ),
          ),
        ),
        initial: AdaptiveThemeMode.light,
        builder: (theme, darkTheme) => MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          title: "Movie Theater",
          theme: theme,
          darkTheme: darkTheme,
          home: const MainScreen(),
        ),
      ),
    );
  }
}
