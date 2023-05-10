import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_theater/core/constants.dart';
import 'package:movie_theater/models/ticket/ticket_model.dart';
import 'package:movie_theater/state/old_tickets_cubit/old_ticket_cubit.dart';
import 'package:movie_theater/state/old_tickets_cubit/old_tickets_state.dart';
import 'package:movie_theater/widgets/new_tickets/ticket.dart';

class RotatedTicket extends StatelessWidget {
  final double offsetHeight;
  final TicketModel ticket;
  const RotatedTicket(
      {required this.offsetHeight, required this.ticket, super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * ticketWidthFactor;
    return BlocBuilder<OldTicketsCubit, OldTicketsState>(
      builder: (context, state) {
        if (state.currenId == ticket.id) {
          return Container(
            width: width * smallTicketScale,
          );
        } else {
          return Ticket(
            ticket,
            scale: smallTicketScale,
          );
        }
      },
    );
  }
}
