// ignore_for_file: empty_catches

import 'package:extended_text/extended_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:veil_wallet/src/generated/i18n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:veil_wallet/src/core/constants.dart';
import 'package:veil_wallet/src/core/wallet_helper.dart';
import 'package:veil_wallet/src/helpers/responsive.dart';
import 'package:veil_wallet/src/states/provider/wallet_state.dart';
import 'package:veil_wallet/src/states/states_bridge.dart';
import 'package:veil_wallet/src/states/static/base_static_state.dart';
import 'package:veil_wallet/src/states/static/wallet_static_state.dart';
import 'package:veil_wallet/src/storage/storage_item.dart';
import 'package:veil_wallet/src/storage/storage_service.dart';
import 'package:veil_wallet/src/views/wallet_settings.dart';

class BalanceWidget extends StatelessWidget {
  const BalanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            height: 195,
            child: AspectRatio(
                aspectRatio: 1.586,
                child: Card(
                  elevation: 0,
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 15, 15),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                                width: double.infinity,
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                margin:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 2, 0, 0),
                                                width: 70 * 1.35,
                                                height: 28 * 1.35,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: AssetImage(context
                                                                .watch<
                                                                    WalletState>()
                                                                .darkMode
                                                            ? './assets/images/logo_full.png'
                                                            : './assets/images/logo_full_light.png'),
                                                        fit: BoxFit.fitWidth))),
                                            /*TextButton(
                                                    onPressed: () {},
                                                    child: Text(
                                                      AppLocalizations.of(
                                                                  context)
                                                              ?.settingsButton ??
                                                          stringNotFoundText,
                                                      style: const TextStyle(
                                                          fontSize: 12),
                                                    ))*/
                                          ]),
                                      Expanded(
                                          child: MouseRegion(
                                              cursor: SystemMouseCursors.click,
                                              child: GestureDetector(
                                                  onTap: () async {
                                                    var curState = !context
                                                        .read<WalletState>()
                                                        .hideBalance;
                                                    context
                                                        .read<WalletState>()
                                                        .setHideBalance(
                                                            curState);

                                                    var storageService =
                                                        StorageService();
                                                    await storageService
                                                        .writeSecureData(StorageItem(
                                                            prefsWalletHiddenBalances,
                                                            curState
                                                                .toString()));
                                                  },
                                                  child: Container(
                                                      margin: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 5),
                                                      child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          children: [
                                                            FittedBox(
                                                                fit: BoxFit
                                                                    .scaleDown,
                                                                child: Text(
                                                                  context
                                                                          .watch<
                                                                              WalletState>()
                                                                          .hideBalance
                                                                      ? hiddenBalanceMask
                                                                      : '${WalletHelper.formatFiat(context.watch<WalletState>().balance, context.watch<WalletState>().conversionRate)} \$',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .end,
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          24),
                                                                )),
                                                            FittedBox(
                                                                fit: BoxFit
                                                                    .scaleDown,
                                                                child: Text(
                                                                  context
                                                                          .watch<
                                                                              WalletState>()
                                                                          .hideBalance
                                                                      ? ' $hiddenBalanceMask'
                                                                      : ' ${WalletHelper.formatAmount(context.watch<WalletState>().balance)}', // show veil?
                                                                  textAlign:
                                                                      TextAlign
                                                                          .end,
                                                                  maxLines: 1,
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal),
                                                                )),
                                                          ])))))
                                    ])),
                            const SizedBox(height: 45),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                      onPressed: () =>
                                          _gotoWalletSettings(context),
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      icon: Icon(
                                        Icons
                                            .settings_rounded, //miscellaneous_services_rounded
                                        size: 18,
                                        semanticLabel:
                                            AppLocalizations.of(context)
                                                ?.walletSettingsTitle,
                                      )),
                                  Expanded(
                                      child: TextButton(
                                    /*icon: const Icon(
                                      Icons.copy_rounded,
                                      size: 18,
                                    ),*/
                                    onPressed: () {
                                      Clipboard.setData(ClipboardData(
                                              text: context
                                                  .read<WalletState>()
                                                  .selectedAddress))
                                          .then((value) => {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                        AppLocalizations.of(
                                                                    context)
                                                                ?.copiedText ??
                                                            stringNotFoundText),
                                                  ),
                                                )
                                              });
                                    },
                                    child: ExtendedText(
                                      context
                                          .watch<WalletState>()
                                          .selectedAddress,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      overflowWidget: const TextOverflowWidget(
                                        position: TextOverflowPosition.middle,
                                        align: TextOverflowAlign.center,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Text(
                                              '\u2026',
                                              style: TextStyle(fontSize: 12),
                                            )
                                          ],
                                        ),
                                      ),
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  )),
                                  PopupMenuButton<String>(
                                    icon: Icon(Icons.expand_more_outlined,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                    onSelected: (value) async {
                                      try {
                                        if (value == 'createaddress') {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                    title: Text(AppLocalizations
                                                                .of(context)
                                                            ?.loadingAddressTitle ??
                                                        stringNotFoundText),
                                                    content: Container(
                                                        constraints:
                                                            const BoxConstraints(
                                                                maxWidth:
                                                                    responsiveMaxDialogWidth),
                                                        child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              Text(AppLocalizations.of(
                                                                          context)
                                                                      ?.loadingAddressDescription ??
                                                                  stringNotFoundText),
                                                              const SizedBox(
                                                                  width: 2,
                                                                  height: 20),
                                                              CircularProgressIndicator(
                                                                semanticsLabel:
                                                                    AppLocalizations.of(
                                                                            context)
                                                                        ?.loadingAddressDescription,
                                                              ),
                                                            ])));
                                              });

                                          var storageService = StorageService();
                                          var lastAddr = int.parse(
                                              (await storageService.readSecureData(
                                                      prefsWalletAddressIndex +
                                                          WalletStaticState
                                                              .activeWallet
                                                              .toString()) ??
                                                  '1'));
                                          lastAddr++;
                                          await storageService.writeSecureData(
                                              StorageItem(
                                                  prefsWalletAddressIndex +
                                                      WalletStaticState
                                                          .activeWallet
                                                          .toString(),
                                                  lastAddr.toString()));
                                          await storageService.writeSecureData(
                                              StorageItem(
                                                  prefsActiveAddress, value));

                                          try {
                                            await WalletHelper.setActiveWallet(
                                                WalletStaticState.activeWallet,
                                                StatesBridge.navigatorKey
                                                        .currentContext ??
                                                    context);
                                          } catch (e) {}

                                          WidgetsBinding.instance
                                              .scheduleFrameCallback((_) {
                                            Navigator.of(context).pop();
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    AppLocalizations.of(context)
                                                            ?.addressCreated ??
                                                        stringNotFoundText),
                                              ),
                                            );
                                          });
                                        } else {
                                          await WalletHelper.setSelectedAddress(
                                              value, context,
                                              shouldForceReload: false);
                                        }
                                      } catch (e) {}

                                      /*WidgetsBinding.instance
                                              .scheduleFrameCallback((_) {
                                            Navigator.of(context).pop();
                                          });*/
                                    },
                                    itemBuilder: (context) {
                                      List<PopupMenuItem<String>> addresses =
                                          List.empty(growable: true);
                                      context
                                          .read<WalletState>()
                                          .ownedAddresses
                                          .forEach((element) {
                                        addresses.add(PopupMenuItem<String>(
                                            value: element.address,
                                            child: ExtendedText(element.address,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                overflowWidget:
                                                    const TextOverflowWidget(
                                                  position: TextOverflowPosition
                                                      .middle,
                                                  align:
                                                      TextOverflowAlign.center,
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: <Widget>[
                                                      Text('\u2026')
                                                    ],
                                                  ),
                                                ))));
                                      });
                                      addresses.add(PopupMenuItem<String>(
                                          value: 'createaddress',
                                          child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                const Icon(
                                                    Icons.add_card_outlined),
                                                Container(
                                                  width: 10,
                                                ),
                                                Text(
                                                    AppLocalizations.of(context)
                                                            ?.createAddress ??
                                                        stringNotFoundText,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1)
                                              ])));
                                      return addresses;
                                    },
                                  ),
                                  /*IconButton(
                                          onPressed: () {},
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          icon: const Icon(Icons
                                              .miscellaneous_services_rounded))*/
                                ])
                          ])),
                ))));
  }

  _gotoWalletSettings(BuildContext context) async {
    BaseStaticState.walSettingsId = context.read<WalletState>().selectedWallet;

    var storageService = StorageService();
    BaseStaticState.walSettingsName = await storageService.readSecureData(
            prefsWalletNames + WalletStaticState.activeWallet.toString()) ??
        '';
    BaseStaticState.walSettingsPassword = await storageService.readSecureData(
            prefsWalletEncryption +
                WalletStaticState.activeWallet.toString()) ??
        '';

    WidgetsBinding.instance.scheduleFrameCallback((_) {
      var useVerticalBar = isBigScreen(context);
      Navigator.of(context).push(_createWalletSettingsRoute(useVerticalBar));
    });
  }
}

Route _createWalletSettingsRoute(bool useVerticalBar) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      return const WalletSettings();
    },
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      if (useVerticalBar) {
        return child;
      }

      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
