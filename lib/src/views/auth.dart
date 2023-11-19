import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:local_auth/local_auth.dart';
import 'package:veil_wallet/src/core/constants.dart';
import 'package:veil_wallet/src/core/screen.dart';
import 'package:veil_wallet/src/core/wallet_helper.dart';
import 'package:veil_wallet/src/helpers/responsive.dart';
import 'package:veil_wallet/src/layouts/mobile/back_layout.dart';
import 'package:veil_wallet/src/states/static/base_static_state.dart';
import 'package:veil_wallet/src/states/static/wallet_static_state.dart';
import 'package:veil_wallet/src/storage/storage_service.dart';
import 'package:veil_wallet/src/views/home.dart';
import 'package:veil_wallet/src/views/make_tx.dart';
import 'package:veil_wallet/src/views/settings.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  bool _authLoading = false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        child: BackLayout(
            title: AppLocalizations.of(context)?.authenticateTitle,
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
                                    ?.authenticateDescription ??
                                stringNotFoundText,
                            style:
                                const TextStyle(fontWeight: FontWeight.normal),
                            textAlign: TextAlign.center)),
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                      child: FilledButton.icon(
                        style: FilledButton.styleFrom(
                            minimumSize: const Size.fromHeight(45)),
                        onPressed: _authLoading
                            ? null
                            : () async {
                                setState(() {
                                  _authLoading = true;
                                });
                                var storageService = StorageService();
                                var biometricsRequired = bool.parse(
                                    await storageService.readSecureData(
                                            prefsBiometricsEnabled) ??
                                        'false');

                                if (biometricsRequired) {
                                  var auth = LocalAuthentication();
                                  WidgetsBinding.instance
                                      .scheduleFrameCallback((_) async {
                                    try {
                                      var didAuthenticate =
                                          await auth.authenticate(
                                              localizedReason:
                                                  AppLocalizations.of(context)
                                                          ?.biometricsReason ??
                                                      stringNotFoundText,
                                              options:
                                                  const AuthenticationOptions(
                                                      useErrorDialogs: true));
                                      if (didAuthenticate) {
                                        // ignore: use_build_context_synchronously
                                        await WalletHelper.prepareHomePage(
                                            context);
                                        BaseStaticState.biometricsTimestamp =
                                            DateTime.now()
                                                .millisecondsSinceEpoch;
                                        BaseStaticState.prevNodeFailSceren =
                                            Screen.notset;
                                        WidgetsBinding.instance
                                            .scheduleFrameCallback((_) {
                                          BaseStaticState
                                              .initialBiometricsPassed = true;
                                          if (WalletStaticState
                                                  .deepLinkTargetAddress !=
                                              null) {
                                            var addr = WalletStaticState
                                                .deepLinkTargetAddress;
                                            var amnt = WalletStaticState
                                                .deepLinkTargetAmount;
                                            WalletStaticState
                                                .deepLinkTargetAddress = null;
                                            WalletStaticState
                                                .deepLinkTargetAmount = null;
                                            Navigator.of(context).push(
                                                _createMakeTxRoute(
                                                    addr!, amnt));
                                          } else {
                                            Navigator.of(context)
                                                .push(_createHomeRoute());
                                          }
                                        });
                                      } else {
                                        setState(() {
                                          _authLoading = false;
                                        });
                                      }
                                      // ignore: empty_catches
                                    } catch (e) {
                                      WidgetsBinding.instance
                                          .scheduleFrameCallback((_) {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                  title: Text(AppLocalizations
                                                              .of(context)
                                                          ?.nodeFailedAlertTitle ??
                                                      stringNotFoundText),
                                                  content: Container(
                                                      constraints:
                                                          const BoxConstraints(
                                                              maxWidth:
                                                                  responsiveMaxDialogWidth),
                                                      child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Text(AppLocalizations.of(
                                                                        context)
                                                                    ?.nodeFailedAlertDescription ??
                                                                stringNotFoundText)
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
                                        _authLoading = false;
                                      });
                                    }
                                  });
                                }
                              },
                        icon: _authLoading
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
                            AppLocalizations.of(context)?.authenticateAction ??
                                stringNotFoundText,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                            minimumSize: const Size.fromHeight(45)),
                        onPressed: _authLoading
                            ? null
                            : () {
                                BaseStaticState.prevNodeFailSceren =
                                    Screen.auth;
                                Navigator.of(context)
                                    .push(_createSettingsRoute());
                              },
                        child: Text(
                            AppLocalizations.of(context)?.settingsButton ??
                                stringNotFoundText,
                            overflow: TextOverflow.ellipsis),
                      ),
                    )
                  ]),
            )));
  }
}

Route _createMakeTxRoute(String address, String? amount) {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
    return MakeTx(address: address, amount: amount);
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
