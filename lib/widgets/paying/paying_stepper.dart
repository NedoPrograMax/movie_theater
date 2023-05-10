import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:movie_theater/state/paying_cubit/paying_cubit.dart';
import 'package:movie_theater/state/paying_cubit/paying_state.dart';
import 'package:movie_theater/widgets/paying/paying_data.dart';
import 'package:movie_theater/widgets/paying/user_data.dart';
import 'package:movie_theater/generated/locale_keys.g.dart';

class PayingStepper extends HookWidget {
  final GlobalKey<FormState> form = GlobalKey();
  PayingStepper({super.key});

  bool canContinue(int step) {
    if (step == 0) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final currentStep = useState(0);
    final textStyle = TextStyle(
      color: Theme.of(context).brightness == Brightness.light
          ? Colors.black
          : Colors.white,
    );
    return SingleChildScrollView(
      child: Column(
        children: [
          Stepper(
            margin: const EdgeInsets.all(0),
            currentStep: currentStep.value,
            controlsBuilder: (context, details) => Padding(
              padding: EdgeInsets.only(left: width * 0.15),
              child: Row(
                children: [
                  TextButton(
                    onPressed: details.onStepContinue,
                    child: Text(LocaleKeys.continue_button.tr()),
                  ),
                  TextButton(
                    onPressed: details.onStepCancel,
                    child: Text(LocaleKeys.back.tr()),
                  ),
                ],
              ),
            ),
            steps: [
              Step(
                title: Text(
                  LocaleKeys.user_data.tr(),
                  style: textStyle,
                ),
                content: UserData(form: form),
              ),
              Step(
                title: Text(
                  LocaleKeys.paying_data.tr(),
                  style: textStyle,
                ),
                content: const PayingData(),
              ),
            ],
            onStepContinue: canContinue(currentStep.value)
                ? () {
                    if (form.currentState?.validate() == true) {
                      currentStep.value++;
                    }
                  }
                : null,
            onStepCancel:
                currentStep.value != 0 ? () => currentStep.value-- : null,
          ),
        ],
      ),
    );
  }
}
