import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:movie_theater/core/constants.dart';
import 'package:movie_theater/models/ticket/ticket_model.dart';
import 'package:movie_theater/widgets/old_tickets/rotated_ticket.dart';

class TicketsList extends StatelessWidget {
  final List<List<TicketModel>> tickets;
  const TicketsList({required this.tickets, super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * ticketWidthFactor;
    final height = width * ticketHeightToWidth * smallTicketScale;
    return Transform.translate(
      offset: Offset(0, height * 0.5),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tickets.length,
        itemBuilder: (context, index) {
          final child = RotatedTicket(
            offsetHeight: height * 0.7,
            ticket: tickets[index].first,
          );
          return Draggable<List<TicketModel>>(
            affinity: Axis.vertical,
            data: tickets[index],
            feedback: Material(
              color: Colors.transparent,
              child: child,
            ),
            childWhenDragging: Container(
              width: width * 0.3,
            ),
            child: child,
          );
        },
      ),
    );
  }
}
