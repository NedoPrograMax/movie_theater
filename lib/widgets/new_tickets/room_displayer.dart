import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class RoomDisplayer extends StatelessWidget {
  final String room;
  final bool isLight;
  const RoomDisplayer(this.room, this.isLight, {super.key});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
        child: RotatedBox(
      quarterTurns: 1,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            room,
            style: TextStyle(
              color: isLight ? Colors.black : Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    ));
  }
}
