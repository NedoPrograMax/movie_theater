import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_theater/core/utils.dart';
import 'package:movie_theater/generated/locale_keys.g.dart';

import 'package:movie_theater/models/session/seat_model.dart';
import 'package:movie_theater/state/booking_cubit/booking_cubit.dart';
import 'package:movie_theater/core/routes/movies_routes_generator.dart';

import 'package:movie_theater/widgets/booking/seats_table.dart';
import 'package:movie_theater/widgets/lotties/loading_movie.dart';

import 'popcorn_item.dart';
import 'price_display.dart';
import 'trash_item.dart';

class BookingScreen extends StatelessWidget {
  final Future<List<List<SeatModel>>> seats;
  const BookingScreen(this.seats, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: WillPopScope(
        onWillPop: () => shouldPopBooking(context),
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [Colors.black, Colors.blue.shade900, Colors.black],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )),
          child: FutureBuilder(
            future: seats,
            builder: (context, snapshot) => !snapshot.hasData
                ? const Center(
                    child: LoadingMovie(),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(child: Container()),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                PopcornItem(),
                                Expanded(
                                    child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.0),
                                  child: PriceDisplay(),
                                )),
                                TrashItem(),
                              ],
                            ),
                          ),
                          SeatsTable(snapshot.data!),
                        ],
                      ),
                      Expanded(child: Container()),
                      ElevatedButton(
                        onPressed: () async {
                          if (context
                              .read<BookingCubit>()
                              .state
                              .bookedSeats
                              .isNotEmpty) {
                            final success =
                                await context.read<BookingCubit>().bookSeats();
                            if (success) {
                              Navigator.of(context)
                                  .pushNamed(MoviesRoutesGenerator.paying);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(LocaleKeys.booking_error.tr()),
                                ),
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(LocaleKeys.zero_booked.tr()),
                              ),
                            );
                          }
                        },
                        child: Text(LocaleKeys.book.tr()),
                      )
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
