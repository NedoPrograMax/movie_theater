import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:movie_theater/models/ticket/ticket_model.dart';
import 'package:movie_theater/state/old_tickets_cubit/old_ticket_cubit.dart';
import 'package:movie_theater/state/old_tickets_cubit/old_tickets_state.dart';

import 'package:movie_theater/widgets/old_tickets/pinned_ticket.dart';

class Pin extends HookWidget {
  Pin({super.key});
  List<TicketModel>? tickets;
  Offset? offset;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height =
        width * 0.8 * (13 / 6.5) * 0.3 + AppBar().preferredSize.height;
    final controller =
        useAnimationController(duration: const Duration(milliseconds: 300));

    return DragTarget<List<TicketModel>>(
      builder: (context, candidateData, rejectedData) {
        if (tickets != null) {
          final newOffset = Offset(offset!.dx - width / 2, offset!.dy - height);
          return BlocBuilder<OldTicketsCubit, OldTicketsState>(
            buildWhen: (previous, current) =>
                current.currenId != previous.currenId,
            builder: (context, state) => state.currenId == -1
                ? Container()
                : PinnedTicket(
                    controller: controller,
                    newOffset: newOffset,
                    tickets: tickets!,
                  ),
          );
        }

        return Container();
      },
      onAccept: (data) {
        tickets = data;
        controller.reset();
        controller.forward();
        context.read<OldTicketsCubit>().setId(tickets!.first.id);
      },
      onAcceptWithDetails: (details) => offset = details.offset,
    );
  }
}
