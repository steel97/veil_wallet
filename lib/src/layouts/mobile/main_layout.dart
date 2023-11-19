// ignore_for_file: empty_catches
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:veil_wallet/src/components/balance_widget.dart';
import 'package:veil_wallet/src/components/coin_control_widget.dart';
import 'package:veil_wallet/src/core/constants.dart';
import 'package:veil_wallet/src/core/screen.dart';
import 'package:veil_wallet/src/core/wallet_helper.dart';
import 'package:veil_wallet/src/helpers/functions_check.dart';
import 'package:veil_wallet/src/helpers/responsive.dart';
import 'package:veil_wallet/src/states/provider/wallet_state.dart';
import 'package:veil_wallet/src/states/static/base_static_state.dart';
import 'package:veil_wallet/src/states/static/wallet_static_state.dart';
import 'package:veil_wallet/src/storage/storage_service.dart';
import 'package:veil_wallet/src/views/home.dart';
import 'package:veil_wallet/src/views/scan_qr.dart';
import 'package:veil_wallet/src/views/settings.dart';

class MainLayout extends StatefulWidget {
  const MainLayout(
      {super.key, @required this.child, this.overrideTitle, this.noWidthLimit});

  final Widget? child;
  final String? overrideTitle;
  final bool? noWidthLimit;

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int? _selectedIndex;

  Future<bool> _checkBiometrics() async {
    var storageService = StorageService();
    var biometricsRequired = bool.parse(
        await storageService.readSecureData(prefsBiometricsEnabled) ?? 'false');
    return biometricsRequired;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var title = WalletStaticState.wallets?.firstWhere(
        (element) => element.id == context.watch<WalletState>().selectedWallet);
    return Directionality(
        textDirection: TextDirection.ltr,
        child:
            Semantics(label: _getTitle(title), child: _buildScaffold(title)));
  }

  Scaffold _buildScaffold(WalletEntry? title) {
    var useVerticalBar = isBigScreen(context);
    return Scaffold(
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          //backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          backgroundColor:
              useVerticalBar ? Theme.of(context).colorScheme.surface : null,
          forceMaterialTransparency: useVerticalBar ? false : true,
          centerTitle: true,
          leadingWidth: 61,
          leading: Row(children: [
            const SizedBox(width: 5),
            /*IconButton(
                      icon: const Icon(Icons.notifications_rounded),
                      color: Theme.of(context).colorScheme.primary,
                      onPressed: null,
                      tooltip:
                          AppLocalizations.of(context)?.notificationsAction,
                    ),*/
            IconButton(
              icon: const Icon(Icons.qr_code_scanner_rounded),
              color: Theme.of(context).colorScheme.primary,
              onPressed: checkScanQROS()
                  ? () {
                      _scanQRRoute();
                    }
                  : null,
              tooltip: AppLocalizations.of(context)?.homeNavScanQR,
            ),
            /*Container(
                width: 70,
                height: 28,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image:
                            AssetImage(context
                                                              .watch<
                                                                  WalletState>()
                                                              .darkMode
                                                          ? './assets/images/logo_full.png'
                                                          : './assets/images/logo_full_light.png'),
                        fit: BoxFit.fitWidth))),*/
          ]),
          automaticallyImplyLeading: false,
          title: Text(
            _getTitle(title),
            overflow: TextOverflow.ellipsis,
          ),
          /*title: Container(
              child: Theme(
                  data: Theme.of(context).copyWith(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                  ),
                  child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                    focusColor: Colors.transparent,
                    icon: Icon(Icons.expand_more_outlined),
                    style: TextStyle(
                        fontWeight: FontWeight.normal, color: Colors.black),
                    value: 'main wallet',
                    items: <DropdownMenuItem<String>>[
                      DropdownMenuItem(
                        child: new Text('main wallet'),
                        value: 'main wallet',
                      ),
                      DropdownMenuItem(child: new Text('two'), value: 'two'),
                    ],
                    onChanged: (String? value) {
                      //setState(() => _value = value);
                    },
                  )))),*/
          actions: [
            /*IconButton(
              icon: const Icon(Icons.notifications_rounded),
              color: Theme.of(context).colorScheme.primary,
              onPressed: () {},
              tooltip: 'Notifications',
            ),*/
            /*IconButton(
              icon: const Icon(Icons.qr_code_scanner_rounded),
              color: Theme.of(context).colorScheme.primary,
              onPressed: () {}, //null = disabled
              tooltip: 'Scan QR',
            ),*/
            /*IconButton(
              icon: const Icon(Icons.settings_rounded),
              color: Theme.of(context).colorScheme.primary,
              onPressed: () {},
              tooltip: 'Settings',
            ),*/
            PopupMenuButton<int>(
              icon: Icon(Icons.wallet_rounded,
                  color: Theme.of(context).colorScheme.primary),
              onSelected: (value) async {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                          title: Text(AppLocalizations.of(context)
                                  ?.loadingWalletTitle ??
                              stringNotFoundText),
                          content: Container(
                              constraints: const BoxConstraints(
                                  maxWidth: responsiveMaxDialogWidth),
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(AppLocalizations.of(context)
                                            ?.loadingWalletDescription ??
                                        stringNotFoundText),
                                    const SizedBox(width: 2, height: 20),
                                    CircularProgressIndicator(
                                      semanticsLabel:
                                          AppLocalizations.of(context)
                                              ?.loadingWalletDescription,
                                    ),
                                  ])));
                    });

                try {
                  await WalletHelper.setActiveWallet(value, context);
                } catch (e) {}

                WidgetsBinding.instance.scheduleFrameCallback((_) {
                  Navigator.of(context).pop();
                });
              },
              itemBuilder: (context) {
                List<PopupMenuItem<int>> items = List.empty(growable: true);

                for (WalletEntry element in WalletStaticState.wallets ?? []) {
                  items.add(PopupMenuItem<int>(
                      value: element.id,
                      child:
                          Text(element.name, overflow: TextOverflow.ellipsis)));
                }

                return items;
              },
            ),
            const SizedBox(width: 10)
          ],
        ),
        extendBody: true,
        resizeToAvoidBottomInset: true,
        bottomNavigationBar: useVerticalBar
            ? null
            : Focus(
                autofocus: true,
                child: NavigationBar(
                  selectedIndex: kDebugMode ? (_selectedIndex ?? 0) : 123,
                  destinations: [
                    /*NavigationDestination(
                  icon: const Icon(Icons.home_rounded),
                  label: AppLocalizations.of(context)?.homeNavHome ??
                      stringNotFoundText,
                ),*/
                    NavigationDestination(
                      icon: const Icon(Icons.web_rounded),
                      label: AppLocalizations.of(context)?.homeNavWebsite ??
                          stringNotFoundText,
                    ),
                    NavigationDestination(
                      icon: const Icon(Icons.explore_rounded),
                      label: AppLocalizations.of(context)?.homeNavExplorer ??
                          stringNotFoundText,
                    ),
                    /*NavigationDestination(
                          icon: const Icon(Icons.qr_code_scanner_rounded),
                          label: AppLocalizations.of(context)?.homeNavScanQR ??
                              stringNotFoundText,
                        ),*/
                    NavigationDestination(
                      icon: const Icon(Icons.settings_rounded),
                      label: AppLocalizations.of(context)?.homeNavSettings ??
                          stringNotFoundText,
                    ),
                  ],
                  onDestinationSelected: _destinationSelected,
                )),
        body: SafeArea(
          child: useVerticalBar
              ? Row(
                  children: [
                    Focus(
                        autofocus: true,
                        child: NavigationRail(
                          selectedIndex: _selectedIndex,
                          labelType: NavigationRailLabelType.all,
                          destinations: [
                            NavigationRailDestination(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 10),
                              icon: const Icon(Icons.home_rounded),
                              label: Text(
                                  AppLocalizations.of(context)?.homeNavHome ??
                                      stringNotFoundText),
                            ),
                            NavigationRailDestination(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 10),
                              icon: const Icon(Icons.web_rounded),
                              label: Text(AppLocalizations.of(context)
                                      ?.homeNavWebsite ??
                                  stringNotFoundText),
                            ),
                            NavigationRailDestination(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 10),
                              icon: const Icon(Icons.explore_rounded),
                              label: Text(AppLocalizations.of(context)
                                      ?.homeNavExplorer ??
                                  stringNotFoundText),
                            ),
                            /*NavigationRailDestination(
                              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                          icon: const Icon(Icons.qr_code_scanner_rounded),
                          label: Text(AppLocalizations.of(context)?.homeNavScanQR ??
                              stringNotFoundText),
                        ),*/
                            NavigationRailDestination(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 10),
                              icon: const Icon(Icons.settings_rounded),
                              label: Text(AppLocalizations.of(context)
                                      ?.homeNavSettings ??
                                  stringNotFoundText),
                            ),
                          ],
                          onDestinationSelected: _destinationSelected,
                        )),
                    Container(
                        margin: const EdgeInsets.fromLTRB(25, 25, 0, 25),
                        constraints:
                            const BoxConstraints(minWidth: 350, maxWidth: 350),
                        child: Column(children: [
                          Container(
                              padding: const EdgeInsets.fromLTRB(25, 0, 0, 10),
                              width: double.infinity,
                              child: Text(
                                title?.name ??
                                    (AppLocalizations.of(context)
                                            ?.walletTitle ??
                                        stringNotFoundText),
                                style: const TextStyle(fontSize: 24),
                                textAlign: TextAlign.left,
                              )),
                          const BalanceWidget(),
                          const SizedBox(height: 10),
                          const CoinControlWidget(),
                          const SizedBox(height: 10),
                        ])),
                    Expanded(
                        child: Center(
                            child: Container(
                                constraints: BoxConstraints(
                                    minWidth: 100,
                                    maxWidth: (widget.noWidthLimit ?? false)
                                        ? double.infinity
                                        : responsiveMaxMainWidth),
                                margin: const EdgeInsets.fromLTRB(0, 25, 0, 10),
                                child: widget.child != null
                                    ? widget.child!
                                    : const SizedBox(height: 1))))
                  ],
                )
              : ListView(
                  children: [
                    const BalanceWidget(),
                    const SizedBox(height: 10),
                    const CoinControlWidget(),
                    const SizedBox(height: 10),
                    widget.child != null
                        ? widget.child!
                        : const SizedBox(height: 1)
                  ],
                ), //widget.child
        ));
  }

  _destinationSelected(index) async {
    var useVerticalBar = isBigScreen(context);
    var baseActionsOffset = useVerticalBar ? 1 : 0;
    //_selectedIndex = index;
    BaseStaticState.useHomeBack = true;
    if (index == 0 && useVerticalBar) {
      // navigate to home
      Navigator.of(context).pushReplacement(_createHomeRoute());
    } else if (index - baseActionsOffset == 1) {
      try {
        var url = Uri.parse(BaseStaticState.explorerAddress);
        if (await canLaunchUrl(url)) {
          await launchUrl(url);
        }
      } catch (e) {}
    } else if (index - baseActionsOffset == 0) {
      //_scanQRRoute();
      try {
        var url = Uri.parse(websiteAddress);
        if (await canLaunchUrl(url)) {
          await launchUrl(url);
        }
      } catch (e) {}
    } else if (index - baseActionsOffset == 2) {
      BaseStaticState.prevScreen = Screen.home;
      BaseStaticState.biometricsActive = await _checkBiometrics();

      WidgetsBinding.instance.scheduleFrameCallback((_) {
        Navigator.of(context).push(_createSettingsRoute());
      });
    }
  }

  String _getTitle(WalletEntry? entry) {
    var bigScreen = isBigScreen(context);
    if (widget.overrideTitle != null) {
      return widget.overrideTitle!;
    }

    return bigScreen
        ? AppLocalizations.of(context)?.walletTitle ?? stringNotFoundText
        : entry?.name ??
            (AppLocalizations.of(context)?.walletTitle ?? stringNotFoundText);
  }

  _scanQRRoute() {
    BaseStaticState.prevScreen = Screen.home;
    BaseStaticState.prevScanQRScreen = Screen.home;
    Navigator.of(context).pushReplacement(_createScanQRRoute());
  }
}

Route _createHomeRoute() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const Home(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      });
}

Route _createScanQRRoute() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const ScanQR(),
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
