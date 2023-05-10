import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:movie_theater/models/enums/drags.dart';

class TrashItem extends StatelessWidget {
  const TrashItem({super.key});

  @override
  Widget build(BuildContext context) {
    return DragTarget<Drags>(
      builder: (context, candidateData, rejectedData) => const Icon(
        Icons.delete,
        color: Colors.white,
        size: 40,
      ),
      onWillAccept: (data) => data == Drags.PopcornToDelete,
    );
  }
}
