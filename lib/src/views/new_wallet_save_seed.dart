import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:veil_wallet/src/core/constants.dart';
import 'package:veil_wallet/src/core/screen.dart';
import 'package:veil_wallet/src/layouts/mobile/back_layout.dart';
import 'package:veil_wallet/src/states/static/base_static_state.dart';
import 'package:veil_wallet/src/views/new_wallet_verify_seed.dart';
import 'package:veil_wallet/src/views/settings.dart';
import 'package:veil_wallet/src/views/wallet_advanced.dart';
import 'package:veil_wallet/src/views/welcome.dart';

class NewWalletSaveSeed extends StatefulWidget {
  const NewWalletSaveSeed({super.key});

  @override
  State<NewWalletSaveSeed> createState() => _NewWalletSaveSeedState();
}

class _NewWalletSaveSeedState extends State<NewWalletSaveSeed> {
  final _walletNameInput = TextEditingController();

  @override
  void initState() {
    super.initState();

    _walletNameInput.text = BaseStaticState.tempWalletName;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvoked: (invoked) {
          _backAction();
        },
        child: BackLayout(
            title: AppLocalizations.of(context)?.saveSeedPhraseTitle,
            back: () {
              _backAction();
            },
            child: Container(
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: ListView(children: [
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
                        controller: _walletNameInput,
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
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 24,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisExtent: 62,
                                crossAxisSpacing: 5),
                        itemBuilder: (_, index) {
                          // hot reload fix
                          if (BaseStaticState.newWalletWords.length <= index) {
                            return const SizedBox(width: 1);
                          }
                          var entry = BaseStaticState.newWalletWords[index];
                          var txt = TextEditingController();
                          txt.text = '${index + 1}. $entry';
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              /*Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: SizedBox(
                                width: 24, child: Text('${index + 1}.'))),*/
                              Expanded(
                                  child: TextField(
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.only(bottom: 0.0),
                                        border: const UnderlineInputBorder(),
                                        hintText: '${index + 1}.',
                                      ),
                                      controller: txt))
                            ],
                          );
                        }),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: OutlinedButton.icon(
                      style: FilledButton.styleFrom(
                          minimumSize: const Size.fromHeight(45)),
                      onPressed: () {
                        BaseStaticState.prevWalAdvancedScreen =
                            Screen.newWallet;
                        BaseStaticState.tempWalletName = _walletNameInput.text;
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
                        BaseStaticState.tempWalletName = _walletNameInput.text;
                        Navigator.of(context).push(_createVerifySeedRoute());
                      },
                      child: Text(
                          AppLocalizations.of(context)?.nextButton ??
                              stringNotFoundText,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ),
                ]))));
  }

  _backAction() {
    BaseStaticState.walletEncryptionPassword = '';
    BaseStaticState.tempWalletName = '';
    BaseStaticState.newWalletWords = [];
    Navigator.of(context).push(_createBackRoute());
  }
}

Route _createBackRoute() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
    if (BaseStaticState.prevScreen == Screen.settings ||
        BaseStaticState.useHomeBack) {
      return const Settings();
    }
    return const Welcome();
  }, transitionsBuilder: (context, animation, secondaryAnimation, child) {
    const begin = Offset(-1.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.ease;

    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

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
