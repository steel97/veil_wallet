import 'package:flutter/material.dart';
import 'package:veil_wallet/src/generated/i18n/app_localizations.dart';
import 'package:veil_wallet/src/core/constants.dart';
import 'package:veil_wallet/src/core/core.dart';
import 'package:veil_wallet/src/helpers/responsive.dart';
import 'package:veil_wallet/src/views/make_tx.dart';
import 'package:veil_wallet/src/views/receive_coins.dart';

class CoinControlWidget extends StatelessWidget {
  const CoinControlWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var useVerticalBar = isBigScreen(context);

    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        child: NavigationBar(
            surfaceTintColor: Colors.transparent,
            indicatorColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            selectedIndex: 0,
            onDestinationSelected: (value) async {
              if (value == 0) {
                Navigator.of(context).push(_createMakeTxRoute(useVerticalBar));
              } else if (value == 1) {
                Navigator.of(context).push(_createReceiveRoute(useVerticalBar));
              } else if (value == 2) {
                try {
                  var url = Uri.parse(buyCryptoLink);
                  await launchUrlWrapped(url);
                  // ignore: empty_catches
                } catch (e) {}
              }
            },
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

Route _createMakeTxRoute(bool useVerticalBar) {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
    return const MakeTx();
  }, transitionsBuilder: (context, animation, secondaryAnimation, child) {
    if (useVerticalBar) {
      return child;
    }

    const begin = Offset(1.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.ease;

    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  });
}

Route _createReceiveRoute(bool useVerticalBar) {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
    return const ReceiveCoins();
  }, transitionsBuilder: (context, animation, secondaryAnimation, child) {
    if (useVerticalBar) {
      return child;
    }

    const begin = Offset(1.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.ease;

    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  });
}
