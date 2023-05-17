import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:movie_theater/models/enums/drags.dart';
import 'package:movie_theater/models/session/seat.dart';
import 'package:movie_theater/models/session/seat_model.dart';

import 'package:movie_theater/state/booking_cubit/booking_cubit.dart';
import 'package:movie_theater/widgets/booking/choosed_chair.dart';
import 'package:movie_theater/widgets/booking/empty_chair.dart';
import 'package:movie_theater/widgets/booking/taken_chair.dart';

class SeatItem extends HookWidget {
  final SeatModel seat;
  final double seatSize;
  const SeatItem(this.seat, this.seatSize, {super.key});

  @override
  Widget build(BuildContext context) {
    final isChoosen = useState(false);

    if (seat.isAvailable) {
      if (isChoosen.value) {
        context.read<BookingCubit>().addSeat(seat);
        return ChoosedChair(isChoosen, seat.type, seatSize);
      } else {
        context.read<BookingCubit>().removeSeat(seat);
        return EmptyChair(isChoosen, seat.type, seatSize);
      }
    } else {
      return TakenChair(seat.type, seatSize);
    }
  }
}
