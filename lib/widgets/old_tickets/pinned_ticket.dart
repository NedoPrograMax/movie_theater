import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:movie_theater/models/ticket/ticket_model.dart';
import 'package:movie_theater/widgets/new_tickets/ticket.dart';
import 'package:movie_theater/widgets/old_tickets/tikcets_tab.dart';

class PinnedTicket extends HookWidget {
  final AnimationController controller;
  final Offset newOffset;
  final List<TicketModel> tickets;
  const PinnedTicket(
      {required this.controller,
      required this.newOffset,
      required this.tickets,
      super.key});

  @override
  Widget build(BuildContext context) {
    final areTabsShown = useState(false);
    useEffect(
      () {
        void listener(status) {
          if (controller.value == controller.upperBound) {
            areTabsShown.value = true;
          } else {
            if (areTabsShown.value) {
              areTabsShown.value = false;
            }
          }
        }

        controller.addStatusListener(listener);
        return () => controller.removeStatusListener(listener);
      },
      [controller],
    );
    if (areTabsShown.value) {
      return TicketsTab(
        tickets,
        scale: 0.9,
      );
    }

    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) => Transform.translate(
          offset:
              controller.drive(Tween(begin: newOffset, end: Offset.zero)).value,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Ticket(
                tickets.first,
                scale: controller.drive(Tween(begin: 0.3, end: 0.9)).value,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
