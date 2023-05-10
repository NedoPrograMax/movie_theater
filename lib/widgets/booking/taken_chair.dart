import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:movie_theater/models/enums/drags.dart';
import 'package:movie_theater/models/session/seat_type.dart';

class TakenChair extends StatelessWidget {
  final SeatType type;
  final double seatSize;
  const TakenChair(this.type, this.seatSize, {super.key});

  String getTakenChairImage() {
    switch (type) {
      case SeatType.NORMAL:
        return "assets/images/taken_chair.png";
      case SeatType.BETTER:
        return "assets/images/taken_better_chair.png";
      case SeatType.VIP:
        return "assets/images/taken_vip_chair.png";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      getTakenChairImage(),
      height: seatSize,
      width: seatSize,
    );
  }
}
