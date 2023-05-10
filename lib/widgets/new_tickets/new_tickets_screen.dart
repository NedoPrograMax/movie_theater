import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:movie_theater/core/utils.dart';
import 'package:movie_theater/repositories/api_repository.dart';
import 'package:movie_theater/initialize.dart';

import 'package:movie_theater/state/booking_cubit/booking_cubit.dart';
import 'package:movie_theater/state/movie_cubit/movie_cubit.dart';

import 'package:movie_theater/widgets/new_tickets/count_displayer.dart';

import 'package:movie_theater/widgets/old_tickets/tikcets_tab.dart';

class NewTicketsScreen extends HookWidget {
  const NewTicketsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.8;
    final appearingController = useAnimationController(
      duration: const Duration(seconds: 2),
    );
    final ticketsFuture = useMemoized(
      () => Future.wait(
        context.read<BookingCubit>().state.bookedSeats.map(
              (seat) => context.read<MovieCubit>().state.currentMovie.toTicket(
                    date: sl<ApiRepository>().lastSession?.date ?? 0,
                    roomName: sl<ApiRepository>().lastSession?.room.name ?? "",
                    seat: seat,
                  ),
            ),
      ),
    );
    useEffect(
      () {
        Future.wait([
          ticketsFuture,
          Future.delayed(const Duration(milliseconds: 300))
        ]).then((_) => appearingController.forward());
        return null;
      },
      [appearingController],
    );

    final tickets = useFuture(ticketsFuture);

    final height = width * (13 / 6.5);

    return WillPopScope(
      onWillPop: () async {
        return newTicketsScreenPop(context);
      },
      child: Scaffold(
        body: Center(
          child: SizedBox(
            width: width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: SlideTransition(
                    position: appearingController.drive(
                      Tween(begin: const Offset(0, -2), end: Offset.zero),
                    ),
                    child: ScaleTransition(
                      scale: appearingController,
                      child: tickets.hasData
                          ? TicketsTab(tickets.data!)
                          : Container(),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                    context.read<BookingCubit>().reset();
                  },
                  child: Text("Ok"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
