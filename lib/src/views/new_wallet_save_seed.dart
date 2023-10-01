import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:veil_wallet/src/core/constants.dart';
import 'package:veil_wallet/src/core/screen.dart';
import 'package:veil_wallet/src/layouts/mobile/back_layout.dart';
import 'package:veil_wallet/src/states/static/base_static_state.dart';
import 'package:veil_wallet/src/views/new_wallet_verify_seed.dart';
import 'package:veil_wallet/src/views/wallet_advanced.dart';
import 'package:veil_wallet/src/views/welcome.dart';

class NewWalletSaveSeed extends StatelessWidget {
  const NewWalletSaveSeed({super.key});

  @override
  Widget build(BuildContext context) {
    return BackLayout(
        title: AppLocalizations.of(context)?.saveSeedPhraseTitle,
        back: () => {Navigator.of(context).push(_createBackRoute())},
        child: Container(
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: TextField(
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(bottom: 0.0),
                            border: const UnderlineInputBorder(),
                            hintText: AppLocalizations.of(context)
                                ?.walletNameInputFieldHint,
                            label: Text(AppLocalizations.of(context)
                                    ?.walletNameInputField ??
                                stringNotFoundText)),
                      )),
                  Container(
                      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      width: double.infinity,
                      child: Text(
                        AppLocalizations.of(context)
                                ?.saveSeedPhraseDescription ??
                            stringNotFoundText,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      )),
                  Expanded(
                      child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: GridView.count(
                            // Create a grid with 2 columns. If you change the scrollDirection to
                            // horizontal, this produces 2 rows.
                            crossAxisCount: 3,
                            childAspectRatio: 2,
                            crossAxisSpacing: 10,
                            // Generate 100 widgets that display their index in the List.
                            children: BaseStaticState.newWalletWords
                                .asMap()
                                .entries
                                .map((entry) {
                              var txt = TextEditingController();
                              txt.text = '${entry.key + 1}. ${entry.value}';
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  /*Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: SizedBox(
                                width: 24, child: Text("${index + 1}."))),*/
                                  Expanded(
                                      child: TextField(
                                          enabled: false,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    bottom: 0.0),
                                            border:
                                                const UnderlineInputBorder(),
                                            hintText: '${entry.key + 1}.',
                                          ),
                                          controller: txt))
                                ],
                              );
                            }).toList(),
                          ))),
                  Container(
                    margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: OutlinedButton.icon(
                      style: FilledButton.styleFrom(
                          minimumSize: const Size.fromHeight(45)),
                      onPressed: () {
                        BaseStaticState.prevScreen = Screen.newWallet;
                        Navigator.of(context).push(_createAdvancedRoute());
                      },
                      icon: const Icon(Icons.file_open_rounded),
                      label: Text(
                          AppLocalizations.of(context)?.walletAdvancedButton ??
                              stringNotFoundText,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                          minimumSize: const Size.fromHeight(45)),
                      onPressed: () {
                        Navigator.of(context).push(_createVerifySeedRoute());
                      },
                      child: Text(
                          AppLocalizations.of(context)?.nextButton ??
                              stringNotFoundText,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ),
                ])));
  }
}

Route _createBackRoute() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const Welcome(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(-1.0, 0.0);
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

Route _createVerifySeedRoute() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const NewWalletVerifySeed(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
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

Route _createAdvancedRoute() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const WalletAdvanced(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
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
