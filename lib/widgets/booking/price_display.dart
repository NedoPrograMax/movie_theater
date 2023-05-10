import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_theater/core/extensions.dart';
import 'package:movie_theater/models/session/seat_type.dart';
import 'package:movie_theater/state/booking_cubit/booking_cubit.dart';
import 'package:movie_theater/state/booking_cubit/booking_state.dart';
import 'package:movie_theater/widgets/booking/seat_price.dart';
import 'package:movie_theater/widgets/booking/total_price.dart';

class PriceDisplay extends StatelessWidget {
  const PriceDisplay({super.key});

  bool isNext(Map<SeatType, int> map, SeatType type) {
    switch (type) {
      case SeatType.NORMAL:
        return map.containsKey(SeatType.BETTER) ||
            map.containsKey(SeatType.VIP);

      case SeatType.BETTER:
        return map.containsKey(SeatType.VIP);

      case SeatType.VIP:
        return false;
    }
  }

  List<Widget> buildSeats(Map<SeatType, int> typesMap, double width) {
    final widgets = <Widget>[];
    for (int i = 0; i < SeatType.values.length; i++) {
      final type = SeatType.values[i];
      if (typesMap.containsKey(type)) {
        widgets.add(
          SizedBox(
            width: width,
            child: SeatPrice(
              count: typesMap[type]!,
              type: type,
              isNext: isNext(typesMap, type),
            ),
          ),
        );
      }
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return BlocBuilder<BookingCubit, BookingState>(
      builder: (context, state) {
        final typesMap = state.bookedSeats.toList().countTypes();

        return LayoutBuilder(
          builder: (p0, constraints) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              ...buildSeats(typesMap, constraints.maxWidth / 4),
              SizedBox(
                width: constraints.maxWidth / 4,
                child: TotalPrice(state.price),
              ),
            ],
          ),
        );
      },
    );
  }
}
