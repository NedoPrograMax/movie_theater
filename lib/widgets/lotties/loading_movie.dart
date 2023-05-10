import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lottie/lottie.dart';

class LoadingMovie extends StatelessWidget {
  const LoadingMovie({super.key});

  @override
  Widget build(BuildContext context) {
    return LottieBuilder.asset("assets/animations/1961-movie-loading.json");
  }
}
