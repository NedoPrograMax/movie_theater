import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_theater/state/booking_cubit/booking_cubit.dart';

import 'counter_painter.dart';

class CountDisplayer extends StatelessWidget {
  final String count;
  const CountDisplayer(this.count, {super.key});

  @override
  Widget build(BuildContext context) {
    if (count.isNotEmpty) {
      return CustomPaint(
        painter: CounterPainter(),
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                count,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.amber,
                  fontSize: 40,
                ),
              ),
            ],
          ),
        ),
      );
    }
    return Container();
  }
}
