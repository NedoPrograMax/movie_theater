import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:movie_theater/generated/locale_keys.g.dart';
import 'package:movie_theater/state/booking_cubit/booking_cubit.dart';
import 'package:movie_theater/state/paying_cubit/paying_cubit.dart';
import 'package:movie_theater/state/paying_cubit/paying_state.dart';
import 'package:movie_theater/core/routes/movies_routes_generator.dart';
import 'package:movie_theater/widgets/new_tickets/new_tickets_screen.dart';
import 'package:movie_theater/widgets/paying/paying_stepper.dart';
import 'package:movie_theater/widgets/paying/user_data.dart';
import 'package:vibration/vibration.dart';

import 'paying_card.dart';
import 'package:flutter_shake_animated/flutter_shake_animated.dart';

class PayingScreen extends HookWidget {
  PayingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: BlocListener<PayingCubit, PayingState>(
          listener: (context, state) {
            if (state.errorText != null) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.errorText!)));
            }
          },
          listenWhen: (previous, current) => current.errorText != null,
          child: PayingStepper(),
        ),
      ),
    );
  }
}
