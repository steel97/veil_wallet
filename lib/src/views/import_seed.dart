// ignore_for_file: use_build_context_synchronously, empty_catches

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:veil_light_plugin/veil_light.dart';
import 'package:veil_wallet/src/core/constants.dart';
import 'package:veil_wallet/src/core/screen.dart';
import 'package:veil_wallet/src/core/wallet_helper.dart';
import 'package:veil_wallet/src/layouts/mobile/back_layout.dart';
import 'package:veil_wallet/src/states/static/base_static_state.dart';
import 'package:veil_wallet/src/views/home.dart';
import 'package:veil_wallet/src/views/settings.dart';
import 'package:veil_wallet/src/views/setup_biometrics.dart';
import 'package:veil_wallet/src/views/wallet_advanced.dart';
import 'package:veil_wallet/src/views/welcome.dart';

class ImportSeed extends StatefulWidget {
  const ImportSeed({super.key});

  @override
  State<ImportSeed> createState() => _ImportSeedState();
}

class _ImportSeedState extends State<ImportSeed> {
  final _formKey = GlobalKey<FormState>();
  final _mnemonicInput = List.generate(24, (index) => TextEditingController());
  final _walletNameInput = TextEditingController();
  bool _importLoading = false;

  @override
  void initState() {
    super.initState();

    _walletNameInput.text = BaseStaticState.tempWalletName;

    var index = 0;
    for (var element in BaseStaticState.importWalletWords) {
      _mnemonicInput[index].text = element;
      index++;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BackLayout(
        title: AppLocalizations.of(context)?.importSeedTitle,
        back: () {
          BaseStaticState.walletEncryptionPassword = '';
          BaseStaticState.tempWalletName = '';
          BaseStaticState.importWalletWords = [];
          Navigator.of(context).push(_createBackRoute());
        },
        child: Form(
            key: _formKey,
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: ListView(children: [
                Container(
                    margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: TextFormField(
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(bottom: 0.0),
                            border: const UnderlineInputBorder(),
                            hintText: AppLocalizations.of(context)
                                ?.walletNameInputFieldHint,
                            label: Text(AppLocalizations.of(context)
                                    ?.walletNameInputField ??
                                stringNotFoundText)),
                        controller: _walletNameInput)),
                Container(
                    margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    width: double.infinity,
                    child: Text(
                      AppLocalizations.of(context)?.importSeedDescription ??
                          stringNotFoundText,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )),
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      //
                      crossAxisCount: 3,
                      childAspectRatio: 2,
                      crossAxisSpacing: 5,
                      // Generate 100 widgets that display their index in the List.
                      children: List.generate(24, (index) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            /*Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: SizedBox(
                                width: 24, child: Text("${index + 1}."))),*/
                            Expanded(
                                child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return AppLocalizations.of(context)
                                      ?.seedWordCantBeEmpty;
                                }

                                var word = value.toLowerCase().trim();
                                return Lightwallet.verifyWord(word)
                                    ? null
                                    : AppLocalizations.of(context)
                                        ?.seedWordWrong;
                              },
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.only(bottom: 0.0),
                                border: const UnderlineInputBorder(),
                                hintText: '${index + 1}.',
                              ),
                              autofillHints: Lightwallet.getValidWords(),
                              controller: _mnemonicInput[index],
                            ))
                          ],
                        );
                      }),
                    )),
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: OutlinedButton.icon(
                    style: FilledButton.styleFrom(
                        minimumSize: const Size.fromHeight(45)),
                    onPressed: _importLoading
                        ? null
                        : () {
                            BaseStaticState.prevWalAdvancedScreen =
                                Screen.importSeed;
                            List<String> mnemonic = List.empty(growable: true);
                            for (var element in _mnemonicInput) {
                              mnemonic.add(element.text.toLowerCase().trim());
                            }
                            BaseStaticState.importWalletWords = mnemonic;
                            BaseStaticState.tempWalletName =
                                _walletNameInput.text;
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
                  child: FilledButton.icon(
                    style: FilledButton.styleFrom(
                        minimumSize: const Size.fromHeight(45)),
                    onPressed: _importLoading
                        ? null
                        : () async {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }

                            List<String> mnemonic = List.empty(growable: true);
                            for (var element in _mnemonicInput) {
                              mnemonic.add(element.text.toLowerCase().trim());
                            }

                            if (BaseStaticState.prevScreen == Screen.settings) {
                              // create and save wallet
                              setState(() {
                                _importLoading = true;
                              });
                              try {
                                var valName = _walletNameInput.text;
                                if (valName.trim().isEmpty) {
                                  valName = defaultWalletName;
                                }
                                await WalletHelper.createOrImportWallet(
                                    valName,
                                    mnemonic,
                                    BaseStaticState.walletEncryptionPassword,
                                    true,
                                    context);
                                // move to home
                                await WalletHelper.prepareHomePage(context);
                                BaseStaticState.importWalletWords = [];
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
                              }
                              setState(() {
                                _importLoading = false;
                              });
                            } else {
                              // move to biometrics
                              BaseStaticState.tempWalletName =
                                  _walletNameInput.text;
                              BaseStaticState.walletMnemonic = mnemonic;
                              BaseStaticState.importWalletWords = mnemonic;
                              Navigator.of(context)
                                  .push(_createBiometricsRoute());
                            }
                          },
                    icon: _importLoading
                        ? Container(
                            width: 24,
                            height: 24,
                            padding: const EdgeInsets.all(2.0),
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 3,
                            ),
                          )
                        : const Icon(Icons.upload_rounded),
                    label: Text(
                        AppLocalizations.of(context)?.importWallet ??
                            stringNotFoundText,
                        overflow: TextOverflow.ellipsis),
                  ),
                ),
              ]),
            )));
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
