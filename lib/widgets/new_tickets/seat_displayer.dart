import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SeatDisplayer extends StatelessWidget {
  final int row;
  final int seat;
  final bool isLight;
  const SeatDisplayer(this.row, this.seat, this.isLight, {super.key});

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      color: isLight ? Colors.black : Colors.white,
      fontWeight: FontWeight.w400,
    );
    return FittedBox(
        child: RotatedBox(
      quarterTurns: -1,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Row ",
            style: style,
          ),
          Text(
            row.toString(),
            style: style,
          ),
          Text(
            " Seat ",
            style: style,
          ),
          Text(
            seat.toString(),
            style: style,
          ),
        ],
      ),
    ));
  }
}
