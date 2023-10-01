// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:local_auth/local_auth.dart';
import 'package:veil_light_plugin/veil_light.dart';
import 'package:veil_wallet/src/core/constants.dart';
import 'package:veil_wallet/src/states/static/wallet_static_state.dart';
import 'package:veil_wallet/src/storage/storage_service.dart';
import 'package:veil_wallet/src/views/auth_retry.dart';
import 'package:veil_wallet/src/views/home.dart';
import 'package:veil_wallet/src/views/welcome.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  runApp(const WalletApp());
}

class WalletApp extends StatefulWidget {
  const WalletApp({super.key});

  @override
  WalletAppState createState() {
    return WalletAppState();
  }
}

class WalletAppState extends State<WalletApp> with WidgetsBindingObserver {
  bool _isInForeground = true;

  Future<void> checkWalletAccess(bool moveToScreen) async {
    var storageService = StorageService();
    var wallets =
        (await storageService.readSecureData(prefsWalletsStorage) ?? '')
            .split(',');
    var activeWallet =
        (await storageService.readSecureData(prefsActiveWallet) ?? '');
    if (wallets.contains(activeWallet)) {
      // look for name, mnemonic, password
      var name =
          await storageService.readSecureData(prefsWalletNames + activeWallet);
      var mnemonic = await storageService
          .readSecureData(prefsWalletMnemonics + activeWallet);
      var encPassword = await storageService
          .readSecureData(prefsWalletEncryption + activeWallet);

      if (name == null || mnemonic == null || encPassword == null) {
        // can't get required information
      } else {
        var biometricsRequired = bool.parse(
            await storageService.readSecureData(prefsBiometricsEnabled) ??
                'false');

        if (biometricsRequired) {
          var auth = LocalAuthentication();
          // ···
          try {
            var didAuthenticate = await auth.authenticate(
                localizedReason:
                    AppLocalizations.of(context)?.biometricsReason ??
                        stringNotFoundText,
                options: const AuthenticationOptions(useErrorDialogs: true));
            if (didAuthenticate) {
              // go to home
              if (moveToScreen) {
                WalletStaticState.lightwallet = Lightwallet.fromMnemonic(
                    mainNetParams, mnemonic.split(' '),
                    password: encPassword);
                Navigator.of(context).push(_createHomeRoute());
              }
            } else {
              // go to auth retry screen
              Navigator.of(context).push(_createAuthRetryRoute());
            }
          } on PlatformException catch (e) {
            // go to auth retry screen
            if (e.code == auth_error.notEnrolled) {
              // Add handling of no hardware here.
            } else if (e.code == auth_error.lockedOut ||
                e.code == auth_error.permanentlyLockedOut) {
              // ...
            } else {
              // ...
            }
            Navigator.of(context).push(_createAuthRetryRoute());
          }
        } else {
          // go to home
          if (moveToScreen) {
            WalletStaticState.lightwallet = Lightwallet.fromMnemonic(
                mainNetParams, mnemonic.split(' '),
                password: encPassword);
            Navigator.of(context).push(_createHomeRoute());
          }
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    checkWalletAccess(true);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    _isInForeground = state == AppLifecycleState.resumed;
    if (_isInForeground) {
      checkWalletAccess(false);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var lightColorScheme = ColorScheme.fromSeed(
      seedColor: Colors.blue,
      primary: const Color.fromARGB(255, 35, 89, 247),
      surface: const Color.fromARGB(255, 233, 239, 247),
      //Color.fromARGB(233, 247, 247, 247), // color of cards, dropdowns etc
      //
      //secondaryContainer: const Color.fromARGB(255, 249, 249, 249),
      //onSecondaryContainer: const Color.fromARGB(255, 35, 89, 247),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) => AppLocalizations.of(context)!.title,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        colorScheme: lightColorScheme,
        useMaterial3: true,
      ),
      home: const Welcome(),
    );
  }
}

Route _createHomeRoute() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
    return const Home();
  }, transitionsBuilder: (context, animation, secondaryAnimation, child) {
    const begin = Offset(1.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.ease;

    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  });
}

Route _createAuthRetryRoute() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
    return const AuthRetry();
  }, transitionsBuilder: (context, animation, secondaryAnimation, child) {
    const begin = Offset(1.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.ease;

    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  });
}
