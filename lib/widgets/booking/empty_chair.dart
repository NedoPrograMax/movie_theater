import 'package:flutter/material.dart';
import 'package:movie_theater/models/session/seat_type.dart';

import '../../models/enums/drags.dart';

class EmptyChair extends StatelessWidget {
  final ValueNotifier<bool> isChosen;
  final SeatType type;
  final double seatSize;
  const EmptyChair(this.isChosen, this.type, this.seatSize, {super.key});

  String getEmptyChairImage() {
    switch (type) {
      case SeatType.NORMAL:
        return "assets/images/chair.png";
      case SeatType.BETTER:
        return "assets/images/better_chair.png";
      case SeatType.VIP:
        return "assets/images/vip_chair.png";
    }
  }

  @override
  Widget build(BuildContext context) {
    return DragTarget<Drags>(
      builder: (context, candidateData, rejectedData) => Image.asset(
        getEmptyChairImage(),
        height: seatSize,
        width: seatSize,
      ),
      onWillAccept: (data) => data is Drags,
      onAccept: (_) => isChosen.value = true,
    );
  }
}
