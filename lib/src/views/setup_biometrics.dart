// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:local_auth/local_auth.dart';
import 'package:veil_wallet/src/core/constants.dart';
import 'package:veil_wallet/src/core/screen.dart';
import 'package:veil_wallet/src/core/wallet_helper.dart';
import 'package:veil_wallet/src/helpers/responsive.dart';
import 'package:veil_wallet/src/layouts/mobile/back_layout.dart';
import 'package:veil_wallet/src/states/static/base_static_state.dart';
import 'package:veil_wallet/src/storage/storage_item.dart';
import 'package:veil_wallet/src/storage/storage_service.dart';
import 'package:veil_wallet/src/views/home.dart';
import 'package:veil_wallet/src/views/import_seed.dart';
import 'package:veil_wallet/src/views/new_wallet_verify_seed.dart';
import 'package:veil_wallet/src/views/settings.dart';

class SetupBiometrics extends StatefulWidget {
  const SetupBiometrics({super.key});

  @override
  State<SetupBiometrics> createState() => _SetupBiometricsState();
}

class _SetupBiometricsState extends State<SetupBiometrics> {
  bool _biometricsBusy = false;
  int _busyIndicatorIndex = 0;

  Future<bool> _checkBiometrics() async {
    var storageService = StorageService();
    var biometricsRequired = bool.parse(
        await storageService.readSecureData(prefsBiometricsEnabled) ?? 'false');
    return biometricsRequired;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvoked: (invoked) {
          _backAction();
        },
        child: BackLayout(
            title: AppLocalizations.of(context)?.biometricsTitle,
            back: () async {
              await _backAction();
            },
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        margin: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                        child: Text(
                            AppLocalizations.of(context)
                                    ?.biometricsDescription ??
                                stringNotFoundText,
                            style:
                                const TextStyle(fontWeight: FontWeight.normal),
                            textAlign: TextAlign.center)),
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                      child: FilledButton.icon(
                        style: FilledButton.styleFrom(
                            minimumSize: const Size.fromHeight(45)),
                        onPressed: _biometricsBusy
                            ? null
                            : () async {
                                var auth = LocalAuthentication();
                                try {
                                  setState(() {
                                    _busyIndicatorIndex = 0;
                                    _biometricsBusy = true;
                                  });

                                  var didAuthenticate = await auth.authenticate(
                                      localizedReason:
                                          AppLocalizations.of(context)
                                                  ?.biometricsSetupReason ??
                                              stringNotFoundText,
                                      options: const AuthenticationOptions(
                                          useErrorDialogs: true));
                                  if (didAuthenticate) {
                                    BaseStaticState.biometricsTimestamp =
                                        DateTime.now().millisecondsSinceEpoch;
                                    var storageService = StorageService();
                                    await storageService.writeSecureData(
                                        StorageItem(prefsBiometricsEnabled,
                                            true.toString()));
                                    if (BaseStaticState.useHomeBack) {
                                      // return to settings
                                      BaseStaticState.biometricsActive =
                                          await _checkBiometrics();

                                      WidgetsBinding.instance
                                          .scheduleFrameCallback((_) {
                                        Navigator.of(context)
                                            .push(_createSettingsRoute());
                                      });
                                      return;
                                    }
                                    // create and save wallet
                                    var valName =
                                        BaseStaticState.tempWalletName;
                                    if (valName.trim().isEmpty) {
                                      valName = defaultWalletName;
                                    }
                                    await WalletHelper.createOrImportWallet(
                                        valName,
                                        BaseStaticState.walletMnemonic,
                                        BaseStaticState
                                            .walletEncryptionPassword,
                                        true,
                                        context);

                                    // clear mnemonic
                                    BaseStaticState.walletMnemonic = [];
                                    BaseStaticState.importWalletWords = [];
                                    BaseStaticState.tempWalletName = '';

                                    await WalletHelper.prepareHomePage(context);
                                    WidgetsBinding.instance
                                        .scheduleFrameCallback((_) {
                                      Navigator.of(context)
                                          .push(_createHomeRoute());
                                    });
                                  }
                                  // ignore: empty_catches
                                } catch (e) {
                                  setState(() {
                                    _biometricsBusy = false;
                                  });
                                }
                              },
                        icon: _biometricsBusy && _busyIndicatorIndex == 0
                            ? Container(
                                width: 24,
                                height: 24,
                                padding: const EdgeInsets.all(2.0),
                                child: const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 3,
                                ),
                              )
                            : const Icon(Icons.fingerprint_rounded),
                        label: Text(
                            AppLocalizations.of(context)
                                    ?.setupBiometricsButton ??
                                stringNotFoundText,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                      child: OutlinedButton.icon(
                        style: FilledButton.styleFrom(
                            minimumSize: const Size.fromHeight(45)),
                        onPressed: _biometricsBusy
                            ? null
                            : () async {
                                try {
                                  setState(() {
                                    _busyIndicatorIndex = 1;
                                    _biometricsBusy = true;
                                  });

                                  if (BaseStaticState.useHomeBack) {
                                    // return to settings
                                    BaseStaticState.biometricsActive =
                                        await _checkBiometrics();

                                    WidgetsBinding.instance
                                        .scheduleFrameCallback((_) {
                                      Navigator.of(context)
                                          .push(_createSettingsRoute());
                                    });
                                    return;
                                  }
                                  // create and save wallet
                                  var valName = BaseStaticState.tempWalletName;
                                  if (valName.trim().isEmpty) {
                                    valName = defaultWalletName;
                                  }
                                  await WalletHelper.createOrImportWallet(
                                      valName,
                                      BaseStaticState.walletMnemonic,
                                      BaseStaticState.walletEncryptionPassword,
                                      true,
                                      context);

                                  // clear mnemonic
                                  BaseStaticState.walletMnemonic = [];
                                  BaseStaticState.importWalletWords = [];
                                  BaseStaticState.tempWalletName = '';

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
                                              content: Container(
                                                  constraints: const BoxConstraints(
                                                      maxWidth:
                                                          responsiveMaxDialogWidth),
                                                  child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Text(
                                                            '${AppLocalizations.of(context)?.nodeFailedAlertDescription ?? stringNotFoundText} $e')
                                                      ])),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text(AppLocalizations
                                                                .of(context)
                                                            ?.alertOkAction ??
                                                        stringNotFoundText))
                                              ]);
                                        });
                                  });

                                  setState(() {
                                    _biometricsBusy = false;
                                  });
                                }
                              },
                        icon: _biometricsBusy && _busyIndicatorIndex == 1
                            ? Container(
                                width: 24,
                                height: 24,
                                padding: const EdgeInsets.all(2.0),
                                child: CircularProgressIndicator(
                                  color: Theme.of(context).colorScheme.primary,
                                  strokeWidth: 3,
                                ),
                              )
                            : const Icon(Icons.arrow_circle_right),
                        label: Text(
                            AppLocalizations.of(context)
                                    ?.skipBiometricsButton ??
                                stringNotFoundText,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                  ]),
            )));
  }

  _backAction() async {
    if (BaseStaticState.useHomeBack) {
      // return to settings
      BaseStaticState.prevScreen = Screen.home;
      BaseStaticState.biometricsActive = await _checkBiometrics();

      WidgetsBinding.instance.scheduleFrameCallback((_) {
        Navigator.of(context).push(_createSettingsRoute());
      });
      return;
    }
    Navigator.of(context).push(_createBackRoute());
  }
}

Route _createBackRoute() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
    if (BaseStaticState.prevScreen == Screen.settings) {
      return const Settings();
    }
    if (BaseStaticState.prevScreen == Screen.importSeed) {
      return const ImportSeed();
    }
    return const NewWalletVerifySeed();
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

Route _createSettingsRoute() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const Settings(),
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
