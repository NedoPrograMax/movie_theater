import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:movie_theater/core/constants.dart';
import 'package:movie_theater/models/ticket/ticket_model.dart';
import 'package:movie_theater/state/old_tickets_cubit/old_ticket_cubit.dart';
import 'package:movie_theater/widgets/new_tickets/ticket.dart';
import 'package:movie_theater/widgets/old_tickets/returning_ticket.dart';
import 'package:movie_theater/widgets/old_tickets/rotated_ticket.dart';
import 'package:movie_theater/widgets/old_tickets/tickets_list.dart';

class TicketsRow extends HookWidget {
  final List<List<TicketModel>> tickets;
  const TicketsRow(this.tickets, {super.key});

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      context.read<OldTicketsCubit>().tickets = tickets;

      return null;
    }, tickets);
    final size = MediaQuery.of(context).size;
    final wholeHeight = size.height;
    final width = size.width * 0.8;
    final height = width * (13 / 6.5) * smallTicketScale;
    final currentTicket = useState<TicketModel?>(null);
    final currentOffset = useState(Offset.zero);
    final currentId = useState(-1);
    final returningController = useAnimationController(
      duration: const Duration(milliseconds: 300),
    );

    return DragTarget<TicketModel>(
      builder: (context, candidateData, rejectedData) => Stack(
        clipBehavior: Clip.none,
        children: [
          SizedBox(height: height, child: TicketsList(tickets: tickets)),
          if (currentTicket.value != null)
            ReturningTicket(
              currentOffset.value,
              Offset(
                width *
                    smallTicketScale *
                    context
                        .read<OldTicketsCubit>()
                        .getIndexById(currentId.value),
                height * 0.5,
              ),
              returningController,
              currentTicket.value!,
            )
        ],
      ),
      onAcceptWithDetails: (details) {
        final index = context.read<OldTicketsCubit>().state.currenId;
        currentOffset.value = Offset(
          details.offset.dx,
          wholeHeight -
              details.offset.dy -
              height -
              AppBar().preferredSize.height,
        );
        currentTicket.value = details.data;
        currentId.value = index;

        returningController.forward().then((value) {
          currentTicket.value = null;
          context.read<OldTicketsCubit>().setId(-1);

          returningController.reset();
        });
      },
    );
  }
}
