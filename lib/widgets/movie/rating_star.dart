import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class RatingStar extends StatelessWidget {
  final bool isRated;
  const RatingStar(this.isRated, {super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.star,
      color: isRated ? Colors.amber : Colors.grey,
    );
  }
}
