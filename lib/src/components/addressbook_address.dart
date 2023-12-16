// ignore_for_file: empty_catches
import 'dart:convert';
import 'dart:ffi';
import 'package:extended_text/extended_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veil_wallet/src/core/constants.dart';
import 'package:veil_wallet/src/core/wallet_helper.dart';
import 'package:veil_wallet/src/helpers/responsive.dart';
import 'package:veil_wallet/src/models/address_model.dart';
import 'package:veil_wallet/src/states/provider/wallet_state.dart';
import 'package:veil_wallet/src/views/address_book.dart';
import 'package:veil_wallet/src/views/make_tx.dart';

class AddressBookAddress extends StatefulWidget {
  final VoidCallback onRefresh;
  final int id;
  final String label;
  final String address;

  const AddressBookAddress(
      {super.key,
      required this.onRefresh,
      required this.id,
      required this.label,
      required this.address});

  @override
  State<AddressBookAddress> createState() => _AddressBookAddressState();
}

class _AddressBookAddressState extends State<AddressBookAddress> {
  final _formKey = GlobalKey<FormState>();

  final _labelController = TextEditingController();
  final _valueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var wallet = context.read<WalletState>().selectedWallet;
    return SizedBox(
        width: double.infinity,
        child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
                onTap: () async {
                  // move to maketx with this address
                  Navigator.of(context)
                      .push(_createMakeTxRoute(widget.address, ''));
                },
                child: Card(
                    elevation: 0,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Row(children: [
                        const SizedBox(width: 4),
                        // all data
                        Expanded(
                            child: Column(
                          children: [
                            Row(children: [
                              Expanded(
                                  child: ExtendedText(
                                widget.label,
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
                                        style: TextStyle(fontSize: 18),
                                      )
                                    ],
                                  ),
                                ),
                                style: const TextStyle(fontSize: 18),
                              )),
                            ]),
                            const SizedBox(width: 1, height: 5),
                            Row(children: [
                              Expanded(
                                  child: ExtendedText(
                                widget.address,
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
                              )),
                            ])
                          ],
                        )),
                        // spacing between icon and data
                        const SizedBox(width: 15),
                        // icon
                        IconButton(
                          icon: Icon(
                              size: 24,
                              Icons.delete_rounded,
                              semanticLabel: AppLocalizations.of(context)
                                  ?.addressBookRemoveSemantics),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                      title: Text(AppLocalizations.of(context)
                                              ?.addressBookDeleteAddressConfirmationTitle ??
                                          stringNotFoundText),
                                      content: Container(
                                          constraints: const BoxConstraints(
                                              maxWidth:
                                                  responsiveMaxDialogWidth),
                                          child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(AppLocalizations.of(
                                                            context)
                                                        ?.addressBookDeleteAddressConfirmation ??
                                                    stringNotFoundText)
                                              ])),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                                AppLocalizations.of(context)
                                                        ?.noAction ??
                                                    stringNotFoundText)),
                                        TextButton(
                                            onPressed: () async {
                                              Navigator.of(context).pop();

                                              final SharedPreferences prefs =
                                                  await SharedPreferences
                                                      .getInstance();
                                              var wallets = prefs.getStringList(
                                                      prefsAddressBook +
                                                          wallet.toString()) ??
                                                  [];
                                              var index = 0;
                                              var indexFound = false;
                                              for (var wal in wallets) {
                                                final addressMap =
                                                    jsonDecode(wal)
                                                        as Map<String, dynamic>;
                                                var model =
                                                    AddressModel.fromJson(
                                                        addressMap);
                                                if (model.id == widget.id) {
                                                  indexFound = true;
                                                  break;
                                                }
                                                index++;
                                              }

                                              if (!indexFound) {
                                                return;
                                              }

                                              wallets.removeAt(index);
                                              prefs.setStringList(
                                                  prefsAddressBook +
                                                      wallet.toString(),
                                                  wallets);

                                              WidgetsBinding.instance
                                                  .scheduleFrameCallback((_) {
                                                widget.onRefresh();
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(AppLocalizations
                                                                .of(context)
                                                            ?.addressBookAddressDeleted ??
                                                        stringNotFoundText),
                                                  ),
                                                );
                                              });
                                            },
                                            child: Text(
                                                AppLocalizations.of(context)
                                                        ?.yesAction ??
                                                    stringNotFoundText))
                                      ]);
                                });
                          },
                        ),
                        const SizedBox(width: 3),
                        IconButton(
                          icon: Icon(
                              size: 24,
                              Icons.edit_rounded,
                              semanticLabel: AppLocalizations.of(context)
                                  ?.addressBookEditSemantics),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  _labelController.text = widget.label;
                                  _valueController.text = widget.address;
                                  return AlertDialog(
                                      title: Text(AppLocalizations.of(context)
                                              ?.addressBookEditAddress ??
                                          stringNotFoundText),
                                      content: Form(
                                          key: _formKey,
                                          child: Container(
                                              width: double.infinity,
                                              constraints: const BoxConstraints(
                                                  maxWidth:
                                                      responsiveMaxDialogExtendedWidth),
                                              child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Container(
                                                        margin: const EdgeInsets
                                                            .fromLTRB(
                                                            10, 10, 10, 10),
                                                        child: TextFormField(
                                                            enableSuggestions:
                                                                true,
                                                            autocorrect: true,
                                                            decoration:
                                                                InputDecoration(
                                                              contentPadding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      bottom:
                                                                          0.0),
                                                              border:
                                                                  const UnderlineInputBorder(),
                                                              hintText: AppLocalizations
                                                                      .of(context)
                                                                  ?.addressBookNewAddressLabelHint,
                                                              label: Text(AppLocalizations.of(
                                                                          context)
                                                                      ?.addressBookNewAddressLabel ??
                                                                  stringNotFoundText),
                                                            ),
                                                            controller:
                                                                _labelController)),
                                                    Container(
                                                        margin: const EdgeInsets
                                                            .fromLTRB(
                                                            10, 10, 10, 10),
                                                        child: TextFormField(
                                                            validator: (value) {
                                                              return WalletHelper
                                                                      .verifyAddress(
                                                                          value ??
                                                                              '')
                                                                  ? null
                                                                  : AppLocalizations.of(
                                                                          context)
                                                                      ?.makeTxVerifyInvalidAddress;
                                                            },
                                                            enableSuggestions:
                                                                true,
                                                            autocorrect: true,
                                                            decoration:
                                                                InputDecoration(
                                                              contentPadding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      bottom:
                                                                          0.0),
                                                              border:
                                                                  const UnderlineInputBorder(),
                                                              hintText: AppLocalizations
                                                                      .of(context)
                                                                  ?.addressBookNewAddressValueHint,
                                                              label: Text(AppLocalizations.of(
                                                                          context)
                                                                      ?.addressBookNewAddressValue ??
                                                                  stringNotFoundText),
                                                            ),
                                                            controller:
                                                                _valueController)),
                                                  ]))),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(AppLocalizations.of(
                                                        context)
                                                    ?.addressBookNewAddressCancelButton ??
                                                stringNotFoundText)),
                                        TextButton(
                                            onPressed: () async {
                                              if (!_formKey.currentState!
                                                  .validate()) {
                                                return;
                                              }

                                              Navigator.of(context).pop();

                                              // serialize data
                                              var address = AddressModel(
                                                  random
                                                      .nextInt(sizeOf<Int32>()),
                                                  _labelController.text,
                                                  _valueController.text);
                                              String json = jsonEncode(address);

                                              final SharedPreferences prefs =
                                                  await SharedPreferences
                                                      .getInstance();
                                              var wallets = prefs.getStringList(
                                                      prefsAddressBook +
                                                          wallet.toString()) ??
                                                  [];
                                              var index = 0;
                                              var indexFound = false;
                                              for (var wal in wallets) {
                                                final addressMap =
                                                    jsonDecode(wal)
                                                        as Map<String, dynamic>;
                                                var model =
                                                    AddressModel.fromJson(
                                                        addressMap);
                                                if (model.id == widget.id) {
                                                  indexFound = true;
                                                  break;
                                                }
                                                index++;
                                              }
                                              if (!indexFound) {
                                                return;
                                              }

                                              wallets.removeAt(index);
                                              wallets.insert(index, json);
                                              prefs.setStringList(
                                                  prefsAddressBook +
                                                      wallet.toString(),
                                                  wallets);

                                              WidgetsBinding.instance
                                                  .scheduleFrameCallback((_) {
                                                widget.onRefresh();

                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(AppLocalizations
                                                                .of(context)
                                                            ?.addressBookNewAddressSavedNotification ??
                                                        stringNotFoundText),
                                                  ),
                                                );
                                              });
                                            },
                                            child: Text(AppLocalizations.of(
                                                        context)
                                                    ?.addressBookNewAddressSaveButton ??
                                                stringNotFoundText))
                                      ]);
                                });
                          },
                        ),
                      ]),
                    )))));
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
