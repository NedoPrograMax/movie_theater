import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_theater/core/extensions.dart';
import 'package:movie_theater/models/session/session_ui.dart';
import 'package:movie_theater/state/room_cubit/room_cubit.dart';

class SessionItem extends StatelessWidget {
  final SessionUi session;
  const SessionItem(this.session, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: session.durationInMinutes.toPixels(),
      decoration: BoxDecoration(
        color: session.id == -1 ? Colors.transparent : null,
        gradient: session.id == -1
            ? null
            : LinearGradient(
                colors: [
                  session.colors.first,
                  session.colors.first,
                  session.colors[1],
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Center(
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(40),
            onTap: () => context.read<RoomCubit>().chooseSession(session.id),
            child: Ink(
              child: Center(
                child: Text(
                  session.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: session.colors.first.isLight()
                        ? Colors.black
                        : Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
