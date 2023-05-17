import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:movie_theater/models/enums/drags.dart';
import 'package:movie_theater/models/session/seat_type.dart';

class TakenChair extends StatefulWidget {
  final SeatType type;
  final double seatSize;
  const TakenChair(this.type, this.seatSize, {super.key});

  @override
  State<TakenChair> createState() => _TakenChairState();
}

class _TakenChairState extends State<TakenChair> {
  late final Image takenChairImage;

  @override
  void initState() {
    takenChairImage = Image.asset(
      getTakenChairImage(),
      height: widget.seatSize,
      width: widget.seatSize,
    );
    super.initState();
  }

  @override
  void didChangeDependencies() {
    //  precacheImage(takenChairImage.image, context);
    super.didChangeDependencies();
  }

  String getTakenChairImage() {
    switch (widget.type) {
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
    return takenChairImage;
  }
}
