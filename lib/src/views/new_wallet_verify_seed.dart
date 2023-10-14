// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:veil_light_plugin/veil_light.dart';
import 'package:veil_wallet/src/core/constants.dart';
import 'package:veil_wallet/src/core/screen.dart';
import 'package:veil_wallet/src/core/wallet_helper.dart';
import 'package:veil_wallet/src/layouts/mobile/back_layout.dart';
import 'package:veil_wallet/src/states/static/base_static_state.dart';
import 'package:veil_wallet/src/views/home.dart';
import 'package:veil_wallet/src/views/new_wallet_save_seed.dart';
import 'package:veil_wallet/src/views/setup_biometrics.dart';

class NewWalletVerifySeed extends StatefulWidget {
  const NewWalletVerifySeed({super.key});

  @override
  State<NewWalletVerifySeed> createState() => _NewWalletVerifySeedState();
}

class _NewWalletVerifySeedState extends State<NewWalletVerifySeed> {
  final _formKey = GlobalKey<FormState>();
  bool _createLoading = false;

  @override
  Widget build(BuildContext context) {
    return BackLayout(
        title: AppLocalizations.of(context)?.verifySeedPhraseTitle,
        back: () => {Navigator.of(context).push(_createBackRoute())},
        child: Form(
            key: _formKey,
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: ListView(children: [
                Container(
                    margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    width: double.infinity,
                    child: Text(
                      AppLocalizations.of(context)
                              ?.verifySeedPhraseDescription ??
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
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            /*Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: SizedBox(
                                width: 24, child: Text('${index + 1}.'))),*/
                            Expanded(
                                child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return AppLocalizations.of(context)
                                      ?.seedWordCantBeEmpty;
                                }

                                var word = value.toLowerCase().trim();
                                var tres = Lightwallet.verifyWord(word)
                                    ? null
                                    : AppLocalizations.of(context)
                                        ?.seedWordWrong;

                                if (tres != null) {
                                  return tres;
                                }

                                var expectedWord =
                                    BaseStaticState.newWalletWords[index];
                                if (expectedWord != word) {
                                  return AppLocalizations.of(context)
                                      ?.seedWordNotMatch;
                                }

                                return null;
                              },
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.only(bottom: 0.0),
                                border: const UnderlineInputBorder(),
                                hintText: '${index + 1}.',
                              ),
                              autofillHints: Lightwallet.getValidWords(),
                            ))
                          ],
                        );
                      }),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: FilledButton.icon(
                    style: FilledButton.styleFrom(
                        minimumSize: const Size.fromHeight(45)),
                    onPressed: _createLoading
                        ? null
                        : () async {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }

                            // move to biometrics if not opened from settings
                            if (BaseStaticState.prevScreen == Screen.settings) {
                              // create and save wallet
                              try {
                                setState(() {
                                  _createLoading = true;
                                });

                                var valName = BaseStaticState.tempWalletName;
                                if (valName.trim().isEmpty) {
                                  valName = defaultWalletName;
                                }
                                await WalletHelper.createOrImportWallet(
                                    valName,
                                    BaseStaticState.newWalletWords,
                                    BaseStaticState.walletEncryptionPassword,
                                    true,
                                    context);
                                // clear new wallet words
                                BaseStaticState.newWalletWords = [];
                                BaseStaticState.tempWalletName = '';
                                // move to home
                                await WalletHelper.prepareHomePage(context);
                                WidgetsBinding.instance
                                    .scheduleFrameCallback((_) {
                                  Navigator.of(context)
                                      .push(_createHomeRoute());
                                });
                              } catch (e) {
                                WidgetsBinding.instance
                                    .scheduleFrameCallback((_) {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                            title: Text(AppLocalizations.of(
                                                        context)
                                                    ?.nodeFailedAlertTitle ??
                                                stringNotFoundText),
                                            content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(AppLocalizations.of(
                                                              context)
                                                          ?.nodeFailedAlertDescription ??
                                                      stringNotFoundText)
                                                ]),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text(
                                                      AppLocalizations.of(
                                                                  context)
                                                              ?.alertOkAction ??
                                                          stringNotFoundText))
                                            ]);
                                      });
                                });

                                setState(() {
                                  _createLoading = false;
                                });
                              }
                            } else {
                              // move to biometrics
                              BaseStaticState.walletMnemonic =
                                  BaseStaticState.newWalletWords;
                              BaseStaticState.newWalletWords = [];
                              Navigator.of(context)
                                  .push(_createBiometricsRoute());
                            }
                          },
                    label: Text(
                        AppLocalizations.of(context)?.createWalletButton ??
                            stringNotFoundText,
                        overflow: TextOverflow.ellipsis),
                    icon: _createLoading
                        ? Container(
                            width: 24,
                            height: 24,
                            padding: const EdgeInsets.all(2.0),
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 3,
                            ),
                          )
                        : const SizedBox(width: 1, height: 1),
                  ),
                ),
              ]),
            )));
  }
}

Route _createBackRoute() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const NewWalletSaveSeed(),
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

Route _createBiometricsRoute() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const SetupBiometrics(),
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

Route _createHomeRoute() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const Home(),
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
