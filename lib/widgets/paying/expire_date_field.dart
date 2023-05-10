import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:movie_theater/state/paying_cubit/paying_cubit.dart';

import 'card_input_field.dart';

class ExpireDateField extends StatelessWidget {
  const ExpireDateField({super.key});

  @override
  Widget build(BuildContext context) {
    return CardInputField(
      initialValue: "00/00",
      cubitValue: context.read<PayingCubit>().state.expireDate,
      mask: '##/##',
      setData: (value) => context.read<PayingCubit>().setData(
          expireDate: MaskTextInputFormatter(mask: "##/##").maskText(value)),
    );
  }
}
