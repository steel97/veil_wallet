import 'package:flutter/material.dart';
import 'package:veil_wallet/src/layouts/mobile/back_layout.dart';
import 'package:veil_wallet/src/layouts/mobile/main_layout.dart';

class CoinControlWidget extends StatelessWidget {
  const CoinControlWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          IconButton.filled(
              onPressed: () => {}, icon: Icon(Icons.send_rounded)),
          SizedBox(width: 15),
          IconButton.filled(
              onPressed: () => {}, icon: Icon(Icons.receipt_rounded)),
          SizedBox(width: 15),
          IconButton.filled(
              onPressed: () => {}, icon: Icon(Icons.currency_exchange_rounded))
        ]));
  }
}
