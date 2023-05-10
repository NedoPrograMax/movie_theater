import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:movie_theater/models/session/seat_type.dart';

class SeatPrice extends StatelessWidget {
  final int count;
  final SeatType type;
  final bool isNext;
  const SeatPrice({
    required this.count,
    required this.type,
    required this.isNext,
    super.key,
  });

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
    return LayoutBuilder(builder: (p0, constaints) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: constaints.maxWidth * 0.2,
            child: FittedBox(
              child: Text(
                count.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.black
                      : Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(
            width: constaints.maxWidth * 0.6,
            child: Image.asset(
              getEmptyChairImage(),
            ),
          ),
          SizedBox(
            width: constaints.maxWidth * 0.2,
            child: FittedBox(
              child: Text(
                isNext ? "+ " : "= ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.black
                      : Colors.white,
                ),
              ),
            ),
          )
        ],
      );
    });
  }
}
