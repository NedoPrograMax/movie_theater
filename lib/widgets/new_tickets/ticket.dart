import 'dart:io';
import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:movie_theater/core/extensions.dart';
import 'package:movie_theater/generated/locale_keys.g.dart';
import 'package:movie_theater/widgets/new_tickets/ticket_bottom.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:movie_theater/core/utils.dart';
import 'package:movie_theater/models/ticket/ticket_model.dart';
import 'package:movie_theater/widgets/new_tickets/ticket_clipper.dart';
import 'package:movie_theater/widgets/new_tickets/ticket_divider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:ui' as ui;

class Ticket extends HookWidget {
  final TicketModel ticket;
  final double scale;
  final repaintKey = GlobalKey();
  Ticket(this.ticket, {this.scale = 1, super.key});

  Future<void> share() async {
    RenderRepaintBoundary boundary =
        repaintKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    final directory = (await getApplicationDocumentsDirectory()).path;
    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List pngBytes = byteData!.buffer.asUint8List();
    final realFile = File("$directory/photo.png");
    await realFile.writeAsBytes(pngBytes);

    await Share.shareFiles(["$directory/photo.png"],
        subject: "", text: LocaleKeys.share_text.tr() + ticket.name);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.8 * scale;
    final color =
        ticket.colors?.first ?? Theme.of(context).scaffoldBackgroundColor;

    return RepaintBoundary(
      key: repaintKey,
      child: GestureDetector(
        onLongPress: () async {
          await share();
        },
        child: ClipPath(
          clipper: TicketClipper(3 / 1),
          child: Container(
            width: width,
            clipBehavior: Clip.antiAlias,
            height: width * 13 / 6.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(width * 0.1),
            ),
            child: Column(
              children: [
                Flexible(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(ticket.image),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        color: color,
                        child: TicketBottom(
                          date: ticket.date,
                          tiket: ticket,
                          isLight: color.isLight(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
