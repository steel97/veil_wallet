import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:veil_wallet/src/core/constants.dart';
import 'package:veil_wallet/src/core/screen.dart';
import 'package:veil_wallet/src/core/wallet_helper.dart';
import 'package:veil_wallet/src/states/provider/wallet_state.dart';
import 'package:veil_wallet/src/states/static/base_static_state.dart';
import 'package:veil_wallet/src/states/static/wallet_static_state.dart';
import 'package:veil_wallet/src/storage/storage_service.dart';
import 'package:veil_wallet/src/views/scan_qr.dart';
import 'package:veil_wallet/src/views/settings.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key, @required this.child});

  final Widget? child;

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  late int selectedIndex;

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
    return Scaffold(
        appBar: AppBar(
          //backgroundColor: Colors.transparent,
          forceMaterialTransparency: true,
          centerTitle: true,
          leadingWidth: 61,
          leading: Row(children: [
            const SizedBox(width: 5),
            IconButton(
              icon: const Icon(Icons.notifications_rounded),
              color: Theme.of(context).colorScheme.primary,
              onPressed: () {},
              tooltip: AppLocalizations.of(context)?.notificationsAction,
            ),
            /*Container(
                width: 70,
                height: 28,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image:
                            AssetImage('./assets/images/logo_full_light.png'),
                        fit: BoxFit.fitWidth))),*/
          ]),
          title: Text(
            title?.name ??
                (AppLocalizations.of(context)?.walletTitle ??
                    stringNotFoundText),
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
                    value: "main wallet",
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
              tooltip: "Notifications",
            ),*/
            /*IconButton(
              icon: const Icon(Icons.qr_code_scanner_rounded),
              color: Theme.of(context).colorScheme.primary,
              onPressed: () {}, //null = disabled
              tooltip: "Scan QR",
            ),*/
            /*IconButton(
              icon: const Icon(Icons.settings_rounded),
              color: Theme.of(context).colorScheme.primary,
              onPressed: () {},
              tooltip: "Settings",
            ),*/
            PopupMenuButton<int>(
              icon: Icon(Icons.wallet_rounded,
                  color: Theme.of(context).primaryColor),
              onSelected: (value) async {
                WalletHelper.setActiveWallet(value, context);
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
        bottomNavigationBar: Focus(
            autofocus: true,
            child: NavigationBar(
              destinations: [
                /*NavigationDestination(
                  icon: const Icon(Icons.home_rounded),
                  label: AppLocalizations.of(context)?.homeNavHome ??
                      stringNotFoundText,
                ),*/
                NavigationDestination(
                  icon: const Icon(Icons.explore_rounded),
                  label: AppLocalizations.of(context)?.homeNavExplorer ??
                      stringNotFoundText,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.qr_code_scanner_rounded),
                  label: AppLocalizations.of(context)?.homeNavScanQR ??
                      stringNotFoundText,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.settings_rounded),
                  label: AppLocalizations.of(context)?.homeNavSettings ??
                      stringNotFoundText,
                ),
              ],
              onDestinationSelected: (index) async {
                BaseStaticState.useHomeBack = true;
                if (index == 0) {
                  try {
                    var url = Uri.parse(BaseStaticState.explorerAddress);
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    }
                    // ignore: empty_catches
                  } catch (e) {}
                } else if (index == 1) {
                  BaseStaticState.prevScreen = Screen.home;
                  Navigator.of(context).push(_createScanQRRoute());
                } else if (index == 2) {
                  BaseStaticState.prevScreen = Screen.home;
                  BaseStaticState.biometricsActive = await _checkBiometrics();

                  WidgetsBinding.instance.scheduleFrameCallback((_) {
                    Navigator.of(context).push(_createSettingsRoute());
                  });
                }
              },
            )),
        body: SafeArea(
          child: Container(child: widget.child),
        ));
  }
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
