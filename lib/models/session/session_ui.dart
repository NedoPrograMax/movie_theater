import 'dart:ui';

class SessionUi {
  final int id;
  final String title;
  final List<Color> colors;
  final int durationInMinutes;

  SessionUi({
    required this.id,
    required this.title,
    required this.colors,
    required this.durationInMinutes,
  });
}
