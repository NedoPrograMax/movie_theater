import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movie_theater/state/paying_cubit/paying_cubit.dart';
import 'package:movie_theater/widgets/paying/card_input_field.dart';

class CardNumberField extends StatelessWidget {
  const CardNumberField({super.key});

  @override
  Widget build(BuildContext context) {
    return CardInputField(
      initialValue: "0000 0000 0000 0000",
      cubitValue: context.read<PayingCubit>().state.cardNumber,
      mask: '#### #### #### ####',
      setData: (value) =>
          context.read<PayingCubit>().setData(cardNumber: value),
    );
  }
}
