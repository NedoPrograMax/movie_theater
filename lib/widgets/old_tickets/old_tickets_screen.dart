import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:movie_theater/repositories/network_repository.dart';
import 'package:movie_theater/initialize.dart';
import 'package:movie_theater/models/ticket/ticket_model.dart';
import 'package:movie_theater/state/old_tickets_cubit/old_ticket_cubit.dart';
import 'package:movie_theater/widgets/old_tickets/pin.dart';
import 'package:movie_theater/widgets/old_tickets/tikcets_row.dart';

class OldTicketsScreen extends HookWidget {
  const OldTicketsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height =
        MediaQuery.of(context).size.width * (13 / 6.5) * 0.3 * 0.8 * 1;
    final stream =
        useMemoized(() => sl<NetworkRepository>().fetchTicketsStream());
    final tickets = useStream(stream);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: TicketsRow(
                tickets.data ?? [],
              ),
            ),
            Pin(),
          ],
        ),
      ),
    );
  }
}
