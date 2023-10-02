import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:local_auth/local_auth.dart';
import 'package:veil_wallet/src/core/constants.dart';
import 'package:veil_wallet/src/core/screen.dart';
import 'package:veil_wallet/src/core/wallet_helper.dart';
import 'package:veil_wallet/src/layouts/mobile/back_layout.dart';
import 'package:veil_wallet/src/states/static/base_static_state.dart';
import 'package:veil_wallet/src/storage/storage_item.dart';
import 'package:veil_wallet/src/storage/storage_service.dart';
import 'package:veil_wallet/src/views/home.dart';
import 'package:veil_wallet/src/views/import_seed.dart';
import 'package:veil_wallet/src/views/new_wallet_verify_seed.dart';
import 'package:veil_wallet/src/views/settings.dart';

class SetupBiometrics extends StatelessWidget {
  const SetupBiometrics({super.key});

  @override
  Widget build(BuildContext context) {
    return BackLayout(
        title: AppLocalizations.of(context)?.biometricsTitle,
        back: () {
          if (BaseStaticState.useHomeBack) {
            // return to settings
            Navigator.of(context).push(_createSettingsRoute());
            return;
          }
          Navigator.of(context).push(_createBackRoute());
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
                        AppLocalizations.of(context)?.biometricsDescription ??
                            stringNotFoundText,
                        style: const TextStyle(fontWeight: FontWeight.normal),
                        textAlign: TextAlign.center)),
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: FilledButton.icon(
                    style: FilledButton.styleFrom(
                        minimumSize: const Size.fromHeight(45)),
                    onPressed: () async {
                      var auth = LocalAuthentication();
                      // ···
                      try {
                        var didAuthenticate = await auth.authenticate(
                            localizedReason: AppLocalizations.of(context)
                                    ?.biometricsSetupReason ??
                                stringNotFoundText,
                            options: const AuthenticationOptions(
                                useErrorDialogs: true));
                        if (didAuthenticate) {
                          var storageService = StorageService();
                          await storageService.writeSecureData(StorageItem(
                              prefsBiometricsEnabled, true.toString()));
                          if (BaseStaticState.useHomeBack) {
                            // return to settings
                            WidgetsBinding.instance.addPostFrameCallback((_) {
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
                              BaseStaticState.newWalletWords,
                              BaseStaticState.walletEncryptionPassword,
                              true);

                          // clear mnemonic
                          BaseStaticState.walletMnemonic = [];
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            Navigator.of(context).push(_createHomeRoute());
                          });
                        }
                        // ignore: empty_catches
                      } on PlatformException {}
                    },
                    icon: const Icon(Icons.fingerprint_rounded),
                    label: Text(
                        AppLocalizations.of(context)?.setupBiometricsButton ??
                            stringNotFoundText,
                        overflow: TextOverflow.ellipsis),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: OutlinedButton.icon(
                    style: FilledButton.styleFrom(
                        minimumSize: const Size.fromHeight(45)),
                    onPressed: () async {
                      if (BaseStaticState.useHomeBack) {
                        // return to settings
                        Navigator.of(context).push(_createSettingsRoute());
                        return;
                      }
                      // create and save wallet
                      var valName = BaseStaticState.tempWalletName;
                      if (valName.trim().isEmpty) {
                        valName = defaultWalletName;
                      }
                      await WalletHelper.createOrImportWallet(
                          valName,
                          BaseStaticState.newWalletWords,
                          BaseStaticState.walletEncryptionPassword,
                          true);

                      // clear mnemonic
                      BaseStaticState.walletMnemonic = [];
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Navigator.of(context).push(_createHomeRoute());
                      });
                    },
                    icon: const Icon(Icons.arrow_circle_right),
                    label: Text(
                        AppLocalizations.of(context)?.skipBiometricsButton ??
                            stringNotFoundText,
                        overflow: TextOverflow.ellipsis),
                  ),
                ),
              ]),
        ));
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
