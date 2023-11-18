import 'package:flutter/material.dart';
import 'package:veil_wallet/src/components/transactions_list_widget.dart';
import 'package:veil_wallet/src/layouts/mobile/main_layout.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        child: MainLayout(
          noWidthLimit: true,
          child: Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: const TransactionsListWidget()),
        ));
  }
}
