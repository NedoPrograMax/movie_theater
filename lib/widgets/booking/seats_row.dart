import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:movie_theater/models/session/seat.dart';
import 'package:movie_theater/models/session/seat_model.dart';

import 'package:movie_theater/widgets/booking/seat_item.dart';

class SeatsRow extends StatelessWidget {
  final List<SeatModel> seats;
  final double seatSize;
  const SeatsRow(this.seats, this.seatSize, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: seatSize,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(0),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: seats.length,
        itemBuilder: (context, index) => SeatItem(
          seats[index],
          seatSize,
        ),
      ),
    );
  }
}
