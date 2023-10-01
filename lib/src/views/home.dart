import 'package:flutter/material.dart';
import 'package:veil_wallet/src/components/balance_widget.dart';
import 'package:veil_wallet/src/components/coin_control_widget.dart';
import 'package:veil_wallet/src/components/transactions_list_widget.dart';
import 'package:veil_wallet/src/layouts/mobile/main_layout.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
        child: Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: ListView(
          //mainAxisAlignment: MainAxisAlignment.start,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            BalanceWidget(),
            SizedBox(height: 10),
            CoinControlWidget(),
            SizedBox(height: 10),
            TransactionsListWidget()
          ]),
    ));
  }
}
