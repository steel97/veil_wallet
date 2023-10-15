import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:veil_wallet/src/core/constants.dart';
import 'package:veil_wallet/src/core/screen.dart';
import 'package:veil_wallet/src/layouts/mobile/welcome_layout.dart';
import 'package:veil_wallet/src/states/static/base_static_state.dart';
import 'package:veil_wallet/src/views/import_seed.dart';
import 'package:veil_wallet/src/views/new_wallet_save_seed.dart';
import 'package:veil_light_plugin/veil_light.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: WelcomeLayout(
            child: Container(
          width: double.infinity,
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 100),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              AppLocalizations.of(context)?.welcomeTitle ?? stringNotFoundText,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              AppLocalizations.of(context)?.welcomeDescription ??
                  stringNotFoundText,
              style: const TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
            Container(
                width: 170,
                margin: const EdgeInsets.fromLTRB(0, 15, 0, 6),
                child: FilledButton.icon(
                  style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(42)),
                  onPressed: () {
                    BaseStaticState.prevScreen = Screen.welcome;
                    var mnemonic = Lightwallet.generateMnemonic();
                    BaseStaticState.newWalletWords = mnemonic;
                    Navigator.of(context).push(_createSaveRoute());
                  },
                  icon: const Icon(Icons.new_label_rounded),
                  label: Text(
                      AppLocalizations.of(context)?.createWallet ??
                          stringNotFoundText,
                      overflow: TextOverflow.ellipsis),
                )),
            SizedBox(
                width: 170,
                child: OutlinedButton.icon(
                  style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(42)),
                  onPressed: () {
                    BaseStaticState.prevScreen = Screen.welcome;
                    BaseStaticState.importWalletWords = [];
                    Navigator.of(context).push(_createImportRoute());
                  },
                  icon: const Icon(Icons.upload_rounded),
                  label: Text(
                      AppLocalizations.of(context)?.importWallet ??
                          stringNotFoundText,
                      overflow: TextOverflow.ellipsis),
                )),
          ]),
        )));
  }
}

Route _createSaveRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        const NewWalletSaveSeed(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Route _createImportRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const ImportSeed(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
