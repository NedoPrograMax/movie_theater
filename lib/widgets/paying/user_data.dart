import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_theater/core/constants.dart';
import 'package:movie_theater/generated/locale_keys.g.dart';
import 'package:movie_theater/state/paying_cubit/paying_cubit.dart';
import 'package:email_validator/email_validator.dart';

class UserData extends StatelessWidget {
  final GlobalKey<FormState> form;
  const UserData({
    required this.form,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(right: 8.0, left: width * 0.15),
      child: Form(
        key: form,
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: LocaleKeys.email_hint.tr(),
              ),
              validator: (value) {
                if (!EmailValidator.validate(value?.trim() ?? "")) {
                  return LocaleKeys.invalid_emial.tr();
                }
                return null;
              },
              onChanged: (value) =>
                  context.read<PayingCubit>().setData(email: value),
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: LocaleKeys.coupon_hint.tr(),
              ),
              onChanged: (value) =>
                  context.read<PayingCubit>().setCoupon(value),
            ),
          ],
        ),
      ),
    );
  }
}
