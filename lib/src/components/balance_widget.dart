// ignore_for_file: empty_catches

import 'package:extended_text/extended_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:veil_wallet/src/core/constants.dart';
import 'package:veil_wallet/src/core/wallet_helper.dart';
import 'package:veil_wallet/src/states/provider/wallet_state.dart';
import 'package:veil_wallet/src/states/static/base_static_state.dart';
import 'package:veil_wallet/src/states/static/wallet_static_state.dart';
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
                child: GestureDetector(
                    onTap: () async {
                      BaseStaticState.walSettingsId =
                          context.read<WalletState>().selectedWallet;

                      var storageService = StorageService();
                      BaseStaticState.walSettingsName =
                          await storageService.readSecureData(prefsWalletNames +
                                  WalletStaticState.activeWallet.toString()) ??
                              '';
                      BaseStaticState.walSettingsPassword = await storageService
                              .readSecureData(prefsWalletEncryption +
                                  WalletStaticState.activeWallet.toString()) ??
                          '';

                      WidgetsBinding.instance.scheduleFrameCallback((_) {
                        Navigator.of(context)
                            .push(_createWalletSettingsRoute());
                      });
                    },
                    child: Card(
                      elevation: 0,
                      child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
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
                                          Container(
                                              margin: const EdgeInsets.fromLTRB(
                                                  0, 0, 0, 0),
                                              width: 70 * 1.5,
                                              height: 28 * 1.5,
                                              decoration: const BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          './assets/images/logo_full_light.png'),
                                                      fit: BoxFit.fitWidth))),
                                          Expanded(
                                              child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                Container(
                                                  width: double.infinity,
                                                  margin: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 12),
                                                  child: Text(
                                                    '${WalletHelper.formatFiat(context.watch<WalletState>().balance, context.watch<WalletState>().conversionRate)} \$',
                                                    textAlign: TextAlign.end,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 24),
                                                  ),
                                                ),
                                                Container(
                                                  width: double.infinity,
                                                  margin: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 12),
                                                  child: Text(
                                                    ' ${WalletHelper.formatAmount(context.watch<WalletState>().balance)}', // show veil?
                                                    textAlign: TextAlign.end,
                                                    maxLines: 1,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  ),
                                                )
                                              ]))
                                        ])),
                                const SizedBox(height: 45),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                          child: TextButton.icon(
                                        icon: const Icon(
                                          Icons.copy_rounded,
                                          size: 18,
                                        ),
                                        onPressed: () {
                                          Clipboard.setData(ClipboardData(
                                                  text: context
                                                      .read<WalletState>()
                                                      .selectedAddress))
                                              .then((value) => {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(AppLocalizations
                                                                    .of(context)
                                                                ?.copiedText ??
                                                            stringNotFoundText),
                                                      ),
                                                    )
                                                  });
                                        },
                                        label: ExtendedText(
                                          context
                                              .watch<WalletState>()
                                              .selectedAddress,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          overflowWidget:
                                              const TextOverflowWidget(
                                            position:
                                                TextOverflowPosition.middle,
                                            align: TextOverflowAlign.center,
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Text(
                                                  '\u2026',
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                )
                                              ],
                                            ),
                                          ),
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      )),
                                      PopupMenuButton<String>(
                                        icon: Icon(Icons.expand_more_outlined,
                                            color:
                                                Theme.of(context).primaryColor),
                                        onSelected: (value) async {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                    title: Text(AppLocalizations
                                                                .of(context)
                                                            ?.loadingAddressTitle ??
                                                        stringNotFoundText),
                                                    content: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Text(AppLocalizations
                                                                      .of(context)
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
                                                        ]));
                                              });

                                          try {
                                            await WalletHelper
                                                .setSelectedAddress(
                                                    value, context);
                                          } catch (e) {}

                                          WidgetsBinding.instance
                                              .scheduleFrameCallback((_) {
                                            Navigator.of(context).pop();
                                          });
                                        },
                                        itemBuilder: (context) {
                                          List<PopupMenuItem<String>>
                                              addresses =
                                              List.empty(growable: true);
                                          context
                                              .read<WalletState>()
                                              .ownedAddresses
                                              .forEach((element) {
                                            addresses.add(PopupMenuItem<String>(
                                                value: element.address,
                                                child: ExtendedText(
                                                    element.address,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    overflowWidget:
                                                        const TextOverflowWidget(
                                                      position:
                                                          TextOverflowPosition
                                                              .middle,
                                                      align: TextOverflowAlign
                                                          .center,
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: <Widget>[
                                                          Text('\u2026')
                                                        ],
                                                      ),
                                                    ))));
                                          });
                                          return addresses;
                                        },
                                      )
                                    ])
                              ])),
                    )))));
  }
}

Route _createWalletSettingsRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      return const WalletSettings();
    },
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
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
