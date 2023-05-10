import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class PopcronImage extends StatelessWidget {
  final double? size;
  const PopcronImage([this.size = 40]);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/popcorn.png",
      height: size,
      width: size,
    );
  }
}
