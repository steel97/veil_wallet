import 'package:flutter/material.dart';
import 'package:veil_wallet/src/generated/i18n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:veil_wallet/src/layouts/mobile/loading_layout.dart';
import 'package:veil_wallet/src/states/provider/wallet_state.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        child: LoadingLayout(
            child: Container(
          width: double.infinity,
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 100),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                width: 70 * 1.8,
                height: 28 * 1.8,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(context.watch<WalletState>().darkMode
                            ? './assets/images/logo_full.png'
                            : './assets/images/logo_full_light.png'),
                        fit: BoxFit.fitWidth))),
            CircularProgressIndicator(
              semanticsLabel: AppLocalizations.of(context)?.loadingAppSemantics,
            ),
          ]),
        )));
  }
}
