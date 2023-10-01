import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:veil_wallet/src/core/constants.dart';

class CoinControlWidget extends StatelessWidget {
  const CoinControlWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        child: NavigationBar(
            surfaceTintColor: Colors.transparent,
            indicatorColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            selectedIndex: 0,
            destinations: [
              NavigationDestination(
                icon: const Icon(Icons.arrow_upward_rounded),
                label: AppLocalizations.of(context)?.sendButton ??
                    stringNotFoundText,
              ),
              NavigationDestination(
                icon: const Icon(Icons.arrow_downward_rounded),
                label: AppLocalizations.of(context)?.receiveButton ??
                    stringNotFoundText,
              ),
              NavigationDestination(
                icon: const Icon(Icons.currency_exchange_rounded),
                label: AppLocalizations.of(context)?.buyButton ??
                    stringNotFoundText,
              ),
            ]));
  }
}
