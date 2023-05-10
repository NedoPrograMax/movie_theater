import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:movie_theater/widgets/paying/card_input_field.dart';

import '../../state/paying_cubit/paying_cubit.dart';

class CVCField extends StatelessWidget {
  const CVCField({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * (0.8 / 6.0);
    return Container(
      width: width,
      height: width,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade800,
      ),
      child: Center(
        child: CardInputField(
          initialValue: "000",
          cubitValue: context.read<PayingCubit>().state.cvv,
          mask: '###',
          setData: (value) => context.read<PayingCubit>().setData(cvv: value),
        ),
      ),
    );
  }
}
