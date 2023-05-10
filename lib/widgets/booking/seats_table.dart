import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:movie_theater/core/extensions.dart';
import 'package:movie_theater/models/session/seat_model.dart';

import 'package:movie_theater/widgets/booking/seats_row.dart';

import '../../models/session/seat.dart';

class SeatsTable extends StatelessWidget {
  final List<List<SeatModel>> seats;
  const SeatsTable(this.seats, {super.key});

  @override
  Widget build(BuildContext context) {
    final maxLength = seats.findMaxLenght();
    final width = MediaQuery.of(context).size.width;
    final seatSize = width ~/ maxLength;
    return Center(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: seats.length,
        itemBuilder: (context, index) => Center(
          child: SeatsRow(
            seats[index],
            seatSize.toDouble(),
          ),
        ),
      ),
    );
  }
}
