import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:movie_theater/models/ticket/ticket_model.dart';
import 'package:movie_theater/widgets/new_tickets/room_displayer.dart';
import 'package:movie_theater/widgets/new_tickets/seat_displayer.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:intl/intl.dart';

class TicketBottom extends StatelessWidget {
  final int date;
  late final String dateString;
  final TicketModel tiket;
  final bool isLight;
  TicketBottom(
      {required this.date,
      required this.tiket,
      required this.isLight,
      super.key}) {
    final dateTime =
        DateTime.fromMillisecondsSinceEpoch(date * 1000, isUtc: true);
    dateString = DateFormat().addPattern("dd.MM. HH:mm").format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LayoutBuilder(
        builder: (p0, constraints) => Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: FittedBox(
                  child: Text(
                    dateString,
                    style: TextStyle(
                      color: isLight ? Colors.black : Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: GestureDetector(
                  onTap: () => launchUrl(
                      Uri.parse("https://www.youtube.com/watch?v=dQw4w9WgXcQ")),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            SeatDisplayer(
                              tiket.rowIndex,
                              tiket.seatIndex,
                              isLight,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: BarcodeWidget(
                          height: constraints.maxHeight * 0.6,
                          barcode: Barcode.qrCode(),
                          data: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
                          //  padding: EdgeInsets.all(22),
                          drawText: false,
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            RoomDisplayer(
                              tiket.roomName,
                              isLight,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
