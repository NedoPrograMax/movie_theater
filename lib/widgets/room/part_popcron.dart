import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:movie_theater/core/utils.dart';

class PartPopcorn extends HookWidget {
  final double percent;
  const PartPopcorn(this.percent, {super.key});

  @override
  Widget build(BuildContext context) {
    final future = useMemoized(
      () => getImageAssetAspectRatio("assets/images/popcorn.png"),
    );
    final aspectRatio = useFuture(future);
    if (aspectRatio.hasData) {
      return SizedBox(
        height: 50,
        width: (aspectRatio.data! * 50) * percent,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              alignment: FractionalOffset.centerLeft,
              image: AssetImage("assets/images/popcorn.png"),
            ),
          ),
        ),
      );
    }
    return Container();
  }
}
