// ignore_for_file: empty_catches

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:veil_wallet/src/generated/i18n/app_localizations.dart';
import 'package:l10n_esperanto/l10n_esperanto.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veil_light_plugin/veil_light.dart';
import 'package:veil_wallet/src/core/constants.dart';
import 'package:veil_wallet/src/core/wallet_bg_tasks.dart';
import 'package:veil_wallet/src/core/wallet_helper.dart';
import 'package:veil_wallet/src/extensions/misc.dart';
import 'package:veil_wallet/src/states/provider/dialogs_state.dart';
import 'package:veil_wallet/src/states/provider/wallet_state.dart';
import 'package:veil_wallet/src/states/states_bridge.dart';
import 'package:veil_wallet/src/states/static/base_static_state.dart';
import 'package:veil_wallet/src/states/static/wallet_static_state.dart';
import 'package:veil_wallet/src/storage/storage_item.dart';
import 'package:veil_wallet/src/storage/storage_service.dart';
import 'package:veil_wallet/src/views/auth.dart';
import 'package:veil_wallet/src/views/home.dart';
import 'package:veil_wallet/src/views/loading.dart';
import 'package:veil_wallet/src/views/make_tx.dart';
import 'package:veil_wallet/src/views/node_fail.dart';
import 'package:veil_wallet/src/views/welcome.dart';
import 'package:window_size/window_size.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('Veil Wallet');
    //double width = 720;
    //double height = 1280;
    double width = 1100;
    getCurrentScreen().then((screen) {
      var screenSize = (screen?.frame.width ?? 1920);
      if (screenSize > 4096) {
        screenSize = 2500;
      }

      width = screenSize / 2;
      double height = width / 1.47;

      if (screenSize < 1280) {
        width = 350;
        height = 700;
      }

      setWindowFrame(Rect.fromCenter(
        center: screen!.frame.center,
        width: width,
        height: height,
      ));
    });
  }

  VeilLightBase.initialize();

  Timer.periodic(
      const Duration(seconds: walletWatchDelay), WalletBgTasks.runScanTask);

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => WalletState()),
    ChangeNotifierProvider(create: (_) => DialogsState()),
  ], child: const WalletAppWrap()));
}

class WalletAppWrap extends StatelessWidget {
  const WalletAppWrap({super.key});

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    var isDarkMode = brightness == Brightness.dark;

    SystemChrome.setSystemUIOverlayStyle(
        isDarkMode ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    var lightColorScheme = ColorScheme.fromSeed(
      seedColor: Colors.blue,
      primary: const Color.fromARGB(255, 35, 89, 247),
      surface: const Color.fromARGB(255, 233, 239, 247),
      //Color.fromARGB(233, 247, 247, 247), // color of cards, dropdowns etc
      //
      //secondaryContainer: const Color.fromARGB(255, 249, 249, 249),
      //onSecondaryContainer: const Color.fromARGB(255, 35, 89, 247),
    );
    var darkColorScheme = ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: const Color.fromARGB(255, 1, 139, 247),
      background: const Color.fromARGB(255, 18, 18, 18),
      primary: const Color.fromARGB(255, 1, 139, 247),
      onPrimary: const Color.fromARGB(255, 227, 226, 230),
      surface: const Color.fromARGB(255, 28, 28, 28),
      //Color.fromARGB(233, 247, 247, 247), // color of cards, dropdowns etc
      //
      //secondaryContainer: const Color.fromARGB(255, 249, 249, 249),
      //onSecondaryContainer: const Color.fromARGB(255, 35, 89, 247),
    );
    return MaterialApp(
        locale: context.watch<WalletState>().locale,
        debugShowCheckedModeBanner: false,
        showSemanticsDebugger: false,
        onGenerateTitle: (context) => AppLocalizations.of(context)!.title,
        localizationsDelegates: AppLocalizations.localizationsDelegates +
            [MaterialLocalizationsEo.delegate],
        supportedLocales: AppLocalizations.supportedLocales,
        themeMode: context.watch<WalletState>().darkMode
            ? ThemeMode.dark
            : ThemeMode.light,
        theme: ThemeData(
          colorScheme: context.watch<WalletState>().darkMode
              ? darkColorScheme
              : lightColorScheme,
          useMaterial3: true,
        ),
        navigatorKey: StatesBridge.navigatorKey,
        home: const WalletApp(),
        onGenerateRoute: (settings) {
          var customContext =
              StatesBridge.navigatorKey.currentContext ?? context;
          var uriRaw = settings.name ?? '';
          if (uriRaw.contains(':')) {
            var dstr = uriRaw.split(':');
            if (dstr[0].toLowerCase() == 'veil') {
              uriRaw = dstr[1];
            } else {
              return;
            }
          }
          var uri = Uri.parse(uriRaw);
          var localAmount =
              uri.queryParameters['amount']; // TO-DO message, label?
          var target = uriRaw.split('?')[0];
          if (target.endsWith('/')) {
            target = target.substring(0, target.length - 1);
          }

          if (WalletHelper.verifyAddress(target)) {
            // parse amount
            String? formattedAmount;
            try {
              if (localAmount != null) {
                var amountNum = double.parse(localAmount.replaceAll(',', '.'));
                if (amountNum > 0 && amountNum.isFinite && !amountNum.isNaN) {
                  formattedAmount = WalletHelper.formatAmount(amountNum);
                }
              }
            } catch (e) {}

            // decide move to biometrics or to maketx
            WalletStaticState.deepLinkTargetAddress = target;
            WalletStaticState.deepLinkTargetAmount = formattedAmount;
            BaseStaticState.isStartedWithDeepLink = true;
            if (!BaseStaticState.initialBiometricsPassed ||
                BaseStaticState.biometricsTimestamp + biometricsAuthTimeout <
                    DateTime.now().millisecondsSinceEpoch) {
              _checkWalletAccess(customContext, true);
            } else {
              WidgetsBinding.instance.scheduleFrameCallback((_) {
                var addr = WalletStaticState.deepLinkTargetAddress;
                var amnt = WalletStaticState.deepLinkTargetAmount;
                WalletStaticState.deepLinkTargetAddress = null;
                WalletStaticState.deepLinkTargetAmount = null;
                Navigator.of(customContext)
                    .push(_createMakeTxRoute(addr!, amnt));
              });
            }
          }

          return null;
        });
  }
}

Future<void> _checkWalletAccess(BuildContext context, bool moveToScreen) async {
  var storageService = StorageService();
  var wallets = (await storageService.readSecureData(prefsWalletsStorage) ?? '')
      .split(',');
  if (wallets[0] == '' && wallets.length == 1) {
    wallets = [];
  }
  var activeWallet =
      (await storageService.readSecureData(prefsActiveWallet) ?? '');

  if (!wallets.contains(activeWallet) && wallets.isNotEmpty) {
    for (String wal in wallets) {
      if (wal.isNotEmpty) {
        await storageService
            .writeSecureData(StorageItem(prefsActiveWallet, wal));
        activeWallet = wal;
        break;
      }
    }
  }

  if (wallets.contains(activeWallet)) {
    // look for name, mnemonic, password
    var name =
        await storageService.readSecureData(prefsWalletNames + activeWallet);
    var mnemonic = await storageService
        .readSecureData(prefsWalletMnemonics + activeWallet);
    var encPassword = await storageService
        .readSecureData(prefsWalletEncryption + activeWallet);

    if (name == null || mnemonic == null || encPassword == null) {
      // can't get required information, move to welcome screen
      if (moveToScreen) {
        WidgetsBinding.instance.scheduleFrameCallback((_) {
          Navigator.of(context).push(_createWelcomeRoute());
        });
      }
    } else {
      var biometricsRequired = bool.parse(
          await storageService.readSecureData(prefsBiometricsEnabled) ??
              'false');

      if (biometricsRequired) {
        // go to auth screen
        WidgetsBinding.instance.scheduleFrameCallback((_) {
          Navigator.of(context).push(_createAuthRetryRoute());
        });
      } else {
        // go to home
        WidgetsBinding.instance.scheduleFrameCallback((_) async {
          if (moveToScreen) {
            // ignore: use_build_context_synchronously
            try {
              await WalletHelper.prepareHomePage(context);
              WidgetsBinding.instance.scheduleFrameCallback((_) {
                if (WalletStaticState.deepLinkTargetAddress != null) {
                  var addr = WalletStaticState.deepLinkTargetAddress;
                  var amnt = WalletStaticState.deepLinkTargetAmount;
                  Navigator.of(context).push(_createMakeTxRoute(addr!, amnt));
                } else {
                  BaseStaticState.initialBiometricsPassed = true;
                  Navigator.of(context).push(_createHomeRoute());
                }
              });
            } catch (e) {
              // move to retry screen
              BaseStaticState.initialBiometricsPassed = true;
              WidgetsBinding.instance.scheduleFrameCallback((_) async {
                WidgetsBinding.instance.scheduleFrameCallback((_) {
                  Navigator.of(context).push(_createNodeFailRoute());
                });
              });
            }
          }
        });
      }
    }
  } else {
    // move to welcome (or try to select other wallet?)
    if (moveToScreen) {
      WidgetsBinding.instance.scheduleFrameCallback((_) {
        Navigator.of(context).push(_createWelcomeRoute());
      });
    }
  }
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

  Future<void> loadState() async {
    var storageService = StorageService();
    BaseStaticState.nodeAddress =
        await storageService.readSecureData(prefsSettingsNodeUrl) ??
            defaultNodeAddress;
    BaseStaticState.nodeAuth =
        await storageService.readSecureData(prefsSettingsNodeAuth) ?? '';
    BaseStaticState.explorerAddress =
        await storageService.readSecureData(prefsSettingsExplorerUrl) ??
            defaultExplorerAddress;
    BaseStaticState.txExplorerAddress =
        await storageService.readSecureData(prefsSettingsExplorerTxUrl) ??
            defaultTxExplorerAddress;
    BaseStaticState.setConversionRateManually = bool.parse(
        await storageService.readSecureData(prefsSettingsConversionManually) ??
            'false');
    BaseStaticState.conversionCustomRate =
        await storageService.readSecureData(prefsSettingsConversionRate) ??
            '0.00';
    BaseStaticState.conversionApiAddress =
        await storageService.readSecureData(prefsSettingsConversionApiUrl) ??
            defaultConversionApiUrl;
    BaseStaticState.useMinimumUTXOs = bool.parse(
        await storageService.readSecureData(prefsSettingsUseMinimumUTXOs) ??
            'false');

    RpcRequester.NODE_URL = BaseStaticState.nodeAddress;
    RpcRequester.NODE_PASSWORD = BaseStaticState.nodeAuth;
  }

  Future<void> loadBalanceHidden() async {
    try {
      var storageService = StorageService();
      var curState =
          await storageService.readSecureData(prefsWalletHiddenBalances) ??
              defaultNodeAddress;
      WidgetsBinding.instance.scheduleFrameCallback((_) {
        try {
          context.read<WalletState>().setHideBalance(bool.parse(curState));
        } catch (e) {}
      });
    } catch (e) {}
  }

  Future<void> loadTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var res = prefs.getBool(prefsDarkMode);
    if (res != null) {
      WidgetsBinding.instance.scheduleFrameCallback((_) {
        context.read<WalletState>().setDarkMode(res);
      });
    }
  }

  Future<void> loadLocale() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var locale = prefs.getString(prefsLocaleStorage);
    if (locale == null) {
      return;
    }
    var localeObj = knownLanguages.firstWhere(
        (element) => element.code == locale,
        orElse: () => knownLanguages.first);

    WidgetsBinding.instance.scheduleFrameCallback((_) {
      context
          .read<WalletState>()
          .setLocale(Locale.fromSubtags(languageCode: localeObj.code));
    });
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
    BaseStaticState.biometricsTimestamp = DateTime.now().millisecondsSinceEpoch;

    loadBalanceHidden();
    loadTheme();
    loadLocale();
    loadState().then((value) {
      makePeriodicTimer(const Duration(seconds: conversionWatchDelay),
          WalletBgTasks.runConversionTask,
          fireNow: true);
      WalletHelper.loadConversionRate();
    });

    Timer(const Duration(milliseconds: 100), () {
      if (!BaseStaticState.isStartedWithDeepLink) {
        _checkWalletAccess(context, true);
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    var curState = state == AppLifecycleState.resumed ||
        state == AppLifecycleState.inactive;

    try {
      if (curState && _isInForeground != curState) {
        if (BaseStaticState.biometricsTimestamp + biometricsAuthTimeout <
            DateTime.now().millisecondsSinceEpoch) {
          _checkWalletAccess(context, false);
        }
      } /* else if (!curState && _isInForeground != curState) {
        BaseStaticState.biometricsTimestamp =
            DateTime.now().millisecondsSinceEpoch;
      }*/
    } catch (e) {}
    _isInForeground = curState;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const Loading();
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
    return const Auth();
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

Route _createWelcomeRoute() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
    return const Welcome();
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

Route _createNodeFailRoute() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
    return const NodeFail();
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
