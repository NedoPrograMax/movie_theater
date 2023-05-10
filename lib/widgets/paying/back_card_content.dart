import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'cvc_field.dart';

class BackCardContent extends StatelessWidget {
  const BackCardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()..rotateY(pi),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const AspectRatio(
                  aspectRatio: 6.0 / 0.5,
                  child: SizedBox(
                    width: double.infinity,
                  ),
                ),
                AspectRatio(
                  aspectRatio: 6.0 / 0.7,
                  child: Container(
                    width: double.infinity,
                    color: Colors.grey.shade800,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const CVCField(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
