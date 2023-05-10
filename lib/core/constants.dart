import 'package:flutter/material.dart';

const hourHeight = 40.0;

const baseUrl = "https://fs-mt.qwerty123.tech";

const validCoupon = "Pivot";

const smallTicketScale = 0.3;

const ticketWidthFactor = 0.8;

const ticketHeightToWidth = 13 / 6.5;

final darkText = ThemeData.dark().textTheme.copyWith(
      bodyMedium: TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: 20,
        color: Colors.grey.shade200,
      ),
      displayMedium: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: Colors.grey.shade400,
      ),
    );

final lightText = ThemeData.light().textTheme.copyWith(
      bodyMedium: const TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: 20,
        color: Colors.black38,
      ),
      displayMedium: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: Colors.black54,
      ),
    );
