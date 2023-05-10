import 'package:flutter/material.dart';
import 'package:movie_theater/widgets/paying/card_number_field.dart';
import 'package:movie_theater/widgets/paying/expire_date_field.dart';

class FrontCardContent extends StatelessWidget {
  const FrontCardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: const [
              Text(
                "CoolPeopleBank",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                ),
              ),
            ],
          ),
          Column(
            children: [
              const CardNumberField(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SizedBox(width: 90),
                  ExpireDateField(),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              Icon(
                Icons.balance,
                color: Colors.amber,
                size: 40,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
