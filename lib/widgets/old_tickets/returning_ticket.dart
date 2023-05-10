import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:movie_theater/core/constants.dart';
import 'package:movie_theater/models/ticket/ticket_model.dart';
import 'package:movie_theater/widgets/new_tickets/ticket.dart';

class ReturningTicket extends StatelessWidget {
  final Offset startOffset;
  final Offset endOffset;
  final AnimationController controller;
  final TicketModel ticket;
  const ReturningTicket(
    this.startOffset,
    this.endOffset,
    this.controller,
    this.ticket, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final offsetAnimation =
        Tween(begin: startOffset, end: endOffset).animate(controller);
    final scaleAnimation =
        Tween(begin: 0.9, end: smallTicketScale).animate(controller);

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) => Positioned(
        left: offsetAnimation.value.dx,
        top: offsetAnimation.value.dy,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Ticket(
              ticket,
              scale: scaleAnimation.value,
            ),
          ],
        ),
      ),
    );
  }
}
