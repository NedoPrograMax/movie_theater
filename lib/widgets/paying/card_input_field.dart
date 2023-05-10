import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CardInputField extends StatefulWidget {
  final String initialValue;
  final String cubitValue;
  final String mask;
  final void Function(String value) setData;
  const CardInputField({
    super.key,
    required this.initialValue,
    required this.cubitValue,
    required this.mask,
    required this.setData,
  });

  @override
  State<CardInputField> createState() => _CardInputFieldState();
}

class _CardInputFieldState extends State<CardInputField> {
  late final MaskTextInputFormatter maskFormatter;
  late final TextEditingController textController;
  late final FocusNode focus;
  late StreamSubscription<bool> keyboardSubscription;

  @override
  void initState() {
    late final initialText;
    if (widget.cubitValue.isEmpty) {
      initialText = widget.initialValue;
    } else {
      initialText = widget.cubitValue;
    }
    maskFormatter = MaskTextInputFormatter(
      initialText: initialText,
      mask: widget.mask,
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.eager,
    );

    textController = TextEditingController(text: maskFormatter.getMaskedText());

    focus = FocusNode();

    var keyboardVisibilityController = KeyboardVisibilityController();

    keyboardSubscription =
        keyboardVisibilityController.onChange.listen((bool visible) {
      if (!visible) {
        focus.unfocus();
      }
    });

    focus.addListener(focusListener);
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();

    focus.removeListener(focusListener);
    focus.dispose();
    keyboardSubscription.cancel();

    super.dispose();
  }

  void focusListener() {
    if (focus.hasFocus && textController.text == widget.initialValue) {
      textController.text = "";
      maskFormatter.clear();
    } else if (!focus.hasFocus && maskFormatter.getUnmaskedText().isEmpty) {
      textController.text = maskFormatter.maskText(widget.initialValue);

      widget.setData(maskFormatter.unmaskText(textController.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: TextField(
        focusNode: focus,
        controller: textController,
        onChanged: (value) => widget.setData(
          maskFormatter.unmaskText(textController.text),
        ),
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 24,
        ),
        inputFormatters: [maskFormatter],
        textAlign: TextAlign.center,
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}
