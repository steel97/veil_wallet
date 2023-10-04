import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:local_auth/local_auth.dart';
import 'package:veil_wallet/src/core/constants.dart';
import 'package:veil_wallet/src/core/wallet_helper.dart';
import 'package:veil_wallet/src/layouts/mobile/back_layout.dart';
import 'package:veil_wallet/src/storage/storage_service.dart';
import 'package:veil_wallet/src/views/home.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  bool _authLoading = false;

  @override
  Widget build(BuildContext context) {
    return BackLayout(
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
                        AppLocalizations.of(context)?.authenticateDescription ??
                            stringNotFoundText,
                        style: const TextStyle(fontWeight: FontWeight.normal),
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
                                  var didAuthenticate = await auth.authenticate(
                                      localizedReason:
                                          AppLocalizations.of(context)
                                                  ?.biometricsReason ??
                                              stringNotFoundText,
                                      options: const AuthenticationOptions(
                                          useErrorDialogs: true));
                                  if (didAuthenticate) {
                                    // ignore: use_build_context_synchronously
                                    await WalletHelper.prepareHomePage(context);
                                    WidgetsBinding.instance
                                        .scheduleFrameCallback((_) {
                                      Navigator.of(context)
                                          .push(_createHomeRoute());
                                    });
                                  } else {
                                    setState(() {
                                      _authLoading = false;
                                    });
                                  }
                                  // ignore: empty_catches
                                } catch (e) {
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
                )
              ]),
        ));
  }
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
