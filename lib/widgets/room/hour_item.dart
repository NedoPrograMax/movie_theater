import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../core/constants.dart';

class HourItem extends StatelessWidget {
  final Color color;
  final String time;
  const HourItem({required this.color, required this.time, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: hourHeight,
      decoration: BoxDecoration(
        border: const Border(
          top: BorderSide(
            color: Colors.black,
            width: 2,
          ),
        ),
        color: color,
      ),
      child: Text(
        time,
        style: const TextStyle(
          fontSize: 15,
        ),
      ),
    );
  }
}
