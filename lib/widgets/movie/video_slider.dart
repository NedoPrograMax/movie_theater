import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoSlider extends HookWidget {
  final YoutubePlayerController controller;
  const VideoSlider({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    final current = useState(
      const Duration(seconds: 0),
    );
    useEffect(() {
      void listener() {
        current.value = controller.value.position;
      }

      controller.addListener(listener);

      return () => controller.removeListener(listener);
    }, [controller]);
    return Expanded(
      child: Slider(
        value: current.value.inSeconds.toDouble(),
        max: controller.value.metaData.duration.inSeconds.toDouble(),
        onChanged: (value) => controller.seekTo(
          Duration(
            seconds: value.toInt(),
          ),
        ),
      ),
    );
    // return controller.value.;
  }
}
