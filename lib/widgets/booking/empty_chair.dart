import 'package:flutter/material.dart';
import 'package:movie_theater/models/session/seat_type.dart';

import '../../models/enums/drags.dart';

class EmptyChair extends StatefulWidget {
  final ValueNotifier<bool> isChosen;
  final SeatType type;
  final double seatSize;
  const EmptyChair(this.isChosen, this.type, this.seatSize, {super.key});

  @override
  State<EmptyChair> createState() => _EmptyChairState();
}

class _EmptyChairState extends State<EmptyChair> {
  late final Image emptyChairImage;

  @override
  void initState() {
    emptyChairImage = Image.asset(
      getEmptyChairImage(),
      height: widget.seatSize,
      width: widget.seatSize,
    );
    super.initState();
  }

  @override
  void didChangeDependencies() {
    //  precacheImage(emptyChairImage.image, context);
    super.didChangeDependencies();
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
    return DragTarget<Drags>(
      builder: (context, candidateData, rejectedData) => emptyChairImage,
      onWillAccept: (data) => data is Drags,
      onAccept: (_) => widget.isChosen.value = true,
    );
  }
}
