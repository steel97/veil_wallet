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
        child: NavigationBar(
            surfaceTintColor: Colors.transparent,
            indicatorColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            selectedIndex: 0,
            destinations: [
              NavigationDestination(
                icon: Icon(Icons.arrow_upward_rounded),
                label: 'Send',
              ),
              NavigationDestination(
                icon: Icon(Icons.arrow_downward_rounded),
                label: 'Receive',
              ),
              NavigationDestination(
                icon: Icon(Icons.currency_exchange_rounded),
                label: 'Buy',
              ),
            ]));
  }
}
