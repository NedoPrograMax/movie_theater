import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:movie_theater/models/enums/drags.dart';
import 'package:movie_theater/models/session/seat_type.dart';
import 'package:movie_theater/widgets/booking/popcorn_image.dart';

class ChoosedChair extends StatelessWidget {
  final ValueNotifier isChosen;
  final SeatType type;
  final double seatSize;
  const ChoosedChair(this.isChosen, this.type, this.seatSize, {super.key});

  String getChoosedChairImage() {
    switch (type) {
      case SeatType.NORMAL:
        return "assets/images/chosen_chair.png";
      case SeatType.BETTER:
        return "assets/images/chosen_better_chair.png";
      case SeatType.VIP:
        return "assets/images/chosen_vip_chair.png";
    }
  }

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
    return Draggable<Drags>(
      feedback: PopcronImage(34),
      data: Drags.PopcornToDelete,
      childWhenDragging: Image.asset(
        getEmptyChairImage(),
        height: seatSize,
        width: seatSize,
      ),
      child: Image.asset(
        getChoosedChairImage(),
        height: seatSize,
        width: seatSize,
      ),
      onDragCompleted: () => isChosen.value = false,
    );
  }
}
