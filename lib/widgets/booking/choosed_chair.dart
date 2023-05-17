import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:movie_theater/models/enums/drags.dart';
import 'package:movie_theater/models/session/seat_type.dart';
import 'package:movie_theater/widgets/booking/popcorn_image.dart';

class ChoosedChair extends StatefulWidget {
  final ValueNotifier isChosen;
  final SeatType type;
  final double seatSize;
  const ChoosedChair(this.isChosen, this.type, this.seatSize, {super.key});

  @override
  State<ChoosedChair> createState() => _ChoosedChairState();
}

class _ChoosedChairState extends State<ChoosedChair> {
  late final Image choosedChairImage;
  late final Image emptyChairImage;

  @override
  void initState() {
    choosedChairImage = Image.asset(
      getChoosedChairImage(),
      height: widget.seatSize,
      width: widget.seatSize,
    );
    emptyChairImage = Image.asset(
      getEmptyChairImage(),
      height: widget.seatSize,
      width: widget.seatSize,
    );
    super.initState();
  }

  @override
  void didChangeDependencies() {
    //  precacheImage(choosedChairImage.image, context);
    //   precacheImage(emptyChairImage.image, context);
    super.didChangeDependencies();
  }

  String getChoosedChairImage() {
    switch (widget.type) {
      case SeatType.NORMAL:
        return "assets/images/chosen_chair.png";
      case SeatType.BETTER:
        return "assets/images/chosen_better_chair.png";
      case SeatType.VIP:
        return "assets/images/chosen_vip_chair.png";
    }
  }

  String getEmptyChairImage() {
    switch (widget.type) {
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
      feedback: const PopcronImage(34),
      data: Drags.PopcornToDelete,
      childWhenDragging: emptyChairImage,
      child: choosedChairImage,
      onDragCompleted: () => widget.isChosen.value = false,
    );
  }
}
