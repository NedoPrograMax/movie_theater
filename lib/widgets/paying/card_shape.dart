import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:movie_theater/widgets/paying/back_card_content.dart';
import 'package:movie_theater/widgets/paying/front_card_content.dart';

class CardShape extends StatefulWidget {
  final bool isFront;
  const CardShape({required this.isFront, super.key});

  @override
  State<CardShape> createState() => _CardShapeState();
}

class _CardShapeState extends State<CardShape> {
  late final FrontCardContent frontCardContent;
  late final BackCardContent backCardContent;
  @override
  void initState() {
    frontCardContent = const FrontCardContent();
    backCardContent = const BackCardContent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: AspectRatio(
        aspectRatio: 6.0 / 3.5,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.grey.shade900,
                  Colors.black87,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  offset: Offset(0, 10),
                  blurRadius: 5,
                  spreadRadius: 1,
                  color: Colors.black,
                ),
              ]),
          child: IndexedStack(
            index: widget.isFront ? 0 : 1,
            children: [frontCardContent, backCardContent],
          ),
        ),
      ),
    );
  }
}
