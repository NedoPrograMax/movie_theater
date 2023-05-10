import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_theater/core/routes/movies_routes_generator.dart';
import 'package:movie_theater/generated/locale_keys.g.dart';
import 'package:movie_theater/state/booking_cubit/booking_cubit.dart';
import 'package:movie_theater/state/paying_cubit/paying_cubit.dart';
import 'package:movie_theater/state/paying_cubit/paying_state.dart';
import 'package:vibration/vibration.dart';

class PayButton extends StatelessWidget {
  final ValueNotifier<bool> isShaking;
  final AnimationController dissapearingController;

  const PayButton(
      {required this.isShaking,
      required this.dissapearingController,
      super.key});

  @override
  Widget build(BuildContext context) {
    final wholePrice = context.read<BookingCubit>().state.price;

    return ElevatedButton(
      onPressed: () async {
        final validated = context.read<PayingCubit>().validate();
        if (validated != null) {
          isShaking.value = true;
          Future.delayed(const Duration(milliseconds: 500))
              .then((value) => isShaking.value = false);
          if (await Vibration.hasVibrator() ?? false) {
            Vibration.vibrate();
          }

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(validated),
            ),
          );
        } else {
          final animationFuture = dissapearingController.forward() as Future;
          final successFuture = context.read<PayingCubit>().buySeats(
                context.read<BookingCubit>().state.bookedSeats.toList(),
              );
          Future.wait([
            animationFuture,
            successFuture,
          ]).then((value) {
            if (!value[1]) {
              dissapearingController.reverse();
            } else {
              context.read<PayingCubit>().reset();
              Navigator.of(context).pushNamed(MoviesRoutesGenerator.newTickets);
            }
          });
          return;
        }
      },
      child: BlocBuilder<PayingCubit, PayingState>(
          buildWhen: (previous, current) =>
              previous.discount != current.discount,
          builder: (context, state) => Text(
              "${LocaleKeys.pay.tr()} ${(wholePrice * (1 - state.discount)).toInt()} ${LocaleKeys.uah.tr()}")),
    );
  }
}
