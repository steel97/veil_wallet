import 'package:flutter/material.dart';
import 'package:veil_wallet/src/components/transaction.dart';
import 'package:veil_wallet/src/layouts/mobile/back_layout.dart';
import 'package:veil_wallet/src/layouts/mobile/main_layout.dart';

class TransactionsListWidget extends StatelessWidget {
  const TransactionsListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        child: Column(children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Transactions",
                style: TextStyle(fontSize: 24),
              ),
              FilledButton.icon(
                  onPressed: () => {},
                  icon: Icon(Icons.refresh_rounded),
                  label: Text("Refresh"))
            ],
          ),
          SizedBox(height: 10),
          Transaction(),
          SizedBox(height: 5),
          Transaction(),
          SizedBox(height: 5),
          Transaction(),
          SizedBox(height: 5),
          Transaction(),
          SizedBox(height: 5),
          Transaction()
        ]));
  }
}
