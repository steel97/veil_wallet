import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:veil_wallet/src/core/constants.dart';
import 'package:veil_wallet/src/layouts/mobile/back_layout.dart';
import 'package:veil_wallet/src/views/import_seed.dart';

class WalletAdvanced extends StatelessWidget {
  const WalletAdvanced({super.key});

  @override
  Widget build(BuildContext context) {
    return BackLayout(
        title: AppLocalizations.of(context)?.walletAdvancedTitle,
        back: () => {Navigator.of(context).push(_createBackRoute())},
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: TextField(
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(bottom: 0.0),
                          border: const UnderlineInputBorder(),
                          hintText: AppLocalizations.of(context)
                              ?.walletEncryptionPasswordInputFieldHint,
                          label: Text(AppLocalizations.of(context)
                                  ?.walletEncryptionPasswordInputField ??
                              stringNotFoundText)),
                    )),
                Container(
                    margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: TextField(
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(bottom: 0.0),
                          border: const UnderlineInputBorder(),
                          hintText: AppLocalizations.of(context)
                              ?.walletEncryptionPasswordRepeatInputFieldHint,
                          label: Text(AppLocalizations.of(context)
                                  ?.walletEncryptionPasswordRepeatInputField ??
                              stringNotFoundText)),
                    )),
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: OutlinedButton.icon(
                    style: FilledButton.styleFrom(
                        minimumSize: const Size.fromHeight(45)),
                    onPressed: () {},
                    icon: const Icon(Icons.file_open_rounded),
                    label: Text(AppLocalizations.of(context)!
                        .walletImportTransactionsData('transactions.json')),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: FilledButton.icon(
                    style: FilledButton.styleFrom(
                        minimumSize: const Size.fromHeight(45)),
                    onPressed: () {},
                    icon: const Icon(Icons.save_rounded),
                    label: Text(AppLocalizations.of(context)?.saveButton ??
                        stringNotFoundText),
                  ),
                ),
              ]),
        ));
  }
}

Route _createBackRoute() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const ImportSeed(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, -1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      });
}
