import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:veil_wallet/src/core/constants.dart';
import 'package:veil_wallet/src/views/receive_coins.dart';

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
            onDestinationSelected: (value) async {
              if (value == 1) {
                Navigator.of(context).push(_createReceiveRoute());
              } else if (value == 2) {
                try {
                  var url = Uri.parse(buyCryptoLink);
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  }
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

Route _createReceiveRoute() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
    return const ReceiveCoins();
  }, transitionsBuilder: (context, animation, secondaryAnimation, child) {
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
