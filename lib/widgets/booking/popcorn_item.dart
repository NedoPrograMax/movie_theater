import 'package:flutter/material.dart';
import 'package:movie_theater/widgets/booking/popcorn_image.dart';

import '../../models/enums/drags.dart';

class PopcornItem extends StatelessWidget {
  const PopcornItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Draggable<Drags>(
      data: Drags.PopcornToAdd,
      childWhenDragging: Container(
        height: 40,
        width: 40,
      ),
      feedback: const PopcronImage(),
      child: const PopcronImage(),
    );
  }
}
