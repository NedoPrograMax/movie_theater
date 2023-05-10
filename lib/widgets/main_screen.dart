import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_theater/core/routes/profile_routes_generator.dart';
import 'package:movie_theater/core/utils.dart';
import 'package:movie_theater/state/booking_cubit/booking_cubit.dart';
import 'package:movie_theater/state/comments_cubit/comments_cubit.dart';
import 'package:movie_theater/widgets/lotties/loading_movie.dart';
import 'package:movie_theater/widgets/movie_chooser/movie_chooser.dart';
import 'package:movie_theater/widgets/movie_chooser/movie_chooser_navigator.dart';
import 'package:movie_theater/widgets/movies/movies_screen.dart';
import 'package:movie_theater/core/routes/movies_routes_generator.dart';
import 'package:movie_theater/widgets/profile/profile_navigator.dart';
import 'package:movie_theater/widgets/profile/profile_screen.dart';
import 'package:movie_theater/widgets/profile/theme_button.dart';
import 'package:movie_theater/widgets/room/rooms_screen.dart';
import 'package:movie_theater/widgets/old_tickets/old_tickets_screen.dart';
import '../core/extensions.dart';

import '../services/authentication.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late final Future<bool> authenticateFuture;
  late final GlobalKey<NavigatorState> moviesNavigator;
  late final GlobalKey<NavigatorState> profileNavigator;
  int index = 0;

  @override
  void initState() {
    authenticateFuture = Authentication.instance().authorize();
    moviesNavigator = GlobalKey();
    profileNavigator = GlobalKey();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.movie), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.airplane_ticket), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
        ],
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
      ),
      body: FutureBuilder(
        future: authenticateFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == true) {
              return WillPopScope(
                onWillPop: () => dealWithPop(
                    index, moviesNavigator, profileNavigator, context),
                child: IndexedStack(
                  index: index,
                  children: [
                    MovieChooserNavigator(moviesNavigator),
                    const OldTicketsScreen(),
                    ProfileNavigator(profileNavigator),
                  ],
                ),
              );
            }
            return const Center(
              child: Text("An error occured"),
            );
          }
          return const Center(
            child: LoadingMovie(),
          );
        },
      ),
    );
  }
}
