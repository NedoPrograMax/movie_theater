import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:movie_theater/models/ticket/ticket_model.dart';
import 'package:movie_theater/widgets/new_tickets/count_displayer.dart';
import 'package:movie_theater/widgets/new_tickets/ticket.dart';

class TicketsTab extends HookWidget {
  final List<TicketModel> tickets;
  final double scale;
  final bool isDragging;
  const TicketsTab(
    this.tickets, {
    this.scale = 1,
    this.isDragging = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final tabController = useTabController(initialLength: tickets.length);
    final width = MediaQuery.of(context).size.width * 0.8 * scale;
    final height = width * (13 / 6.5);
    final isShowing = useState(true);
    return isShowing.value
        ? Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AnimatedBuilder(
                    animation: tabController,
                    builder: (context, child) => CountDisplayer(tabController
                                .length >
                            1
                        ? '${tabController.index + 1}/${tabController.length}'
                        : ""),
                  ),
                ],
              ),
              SizedBox(
                height: height,
                child: TabBarView(
                  viewportFraction: 1.1,
                  controller: tabController,
                  children: tickets
                      .map(
                        (ticket) => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            isDragging
                                ? Draggable<TicketModel>(
                                    affinity: Axis.vertical,
                                    data: tickets.first,
                                    onDragCompleted: () =>
                                        isShowing.value = false,
                                    feedback: Material(
                                      color: Colors.transparent,
                                      child: Ticket(
                                        ticket,
                                        scale: scale,
                                      ),
                                    ),
                                    childWhenDragging: Container(),
                                    child: Ticket(
                                      ticket,
                                      scale: scale,
                                    ),
                                  )
                                : Ticket(
                                    ticket,
                                    scale: scale,
                                  ),
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          )
        : Container();
  }
}
