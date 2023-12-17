// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veil_wallet/src/components/addressbook_address.dart';
import 'package:veil_wallet/src/core/constants.dart';
import 'package:veil_wallet/src/core/screen.dart';
import 'package:veil_wallet/src/core/wallet_helper.dart';
import 'package:veil_wallet/src/helpers/functions_check.dart';
import 'package:veil_wallet/src/helpers/responsive.dart';
import 'package:veil_wallet/src/layouts/mobile/back_layout.dart';
import 'package:veil_wallet/src/layouts/mobile/main_layout.dart';
import 'package:veil_wallet/src/models/address_model.dart';
import 'package:veil_wallet/src/states/provider/wallet_state.dart';
import 'package:veil_wallet/src/states/static/base_static_state.dart';
import 'package:veil_wallet/src/states/static/wallet_static_state.dart';
import 'package:veil_wallet/src/views/make_tx.dart';
import 'package:veil_wallet/src/views/scan_qr.dart';

Random random = Random();

class AddressBook extends StatefulWidget {
  const AddressBook({super.key});

  @override
  State<AddressBook> createState() => _AddressBookState();
}

class _AddressBookState extends State<AddressBook> {
  final _formKey = GlobalKey<FormState>();

  final _searchController = TextEditingController();
  final _labelController = TextEditingController();
  final _valueController = TextEditingController();

  bool _addressBookLoaded = false;
  List<AddressModel> _addressBook = [];
  List<AddressModel> _addressBookFiltered = [];

  void filterAddressBook() {
    var copy = _addressBook;
    List<AddressModel> addrs = List.empty(growable: true);
    var searchTerm = _searchController.text.toLowerCase();
    for (var addr in copy) {
      if (addr.label.toLowerCase().contains(searchTerm) ||
          addr.address.toLowerCase().contains(searchTerm)) {
        addrs.add(addr);
      }
    }

    _addressBookFiltered = addrs;
  }

  Future<void> updateAddressBook(String wallet) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var addresses =
        prefs.getStringList(prefsAddressBook + wallet.toString()) ?? [];
    List<AddressModel> addrs = List.empty(growable: true);
    for (var addr in addresses) {
      final addressMap = jsonDecode(addr) as Map<String, dynamic>;
      var model = AddressModel.fromJson(addressMap);
      addrs.add(model);
    }

    setState(() {
      _addressBook = addrs;
      filterAddressBook();
      _addressBookLoaded = true;
    });
  }

  @override
  void initState() {
    super.initState();

    var wallet = context.read<WalletState>().selectedWallet;
    updateAddressBook(wallet.toString());

    if (WalletStaticState.addressBookOpenedFromQR) {
      WalletStaticState.addressBookOpenedFromQR = false;
      var wallet = context.read<WalletState>().selectedWallet;
      showNewAddressDialog(wallet.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    var useVerticalBar = isBigScreen(context);
    var wallet = context.read<WalletState>().selectedWallet;

    var container = Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: TextFormField(
                    enableSuggestions: true,
                    autocorrect: true,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(bottom: 0.0),
                      border: const UnderlineInputBorder(),
                      hintText:
                          AppLocalizations.of(context)?.addressBookSearchHint,
                      label: Text(AppLocalizations.of(context)
                              ?.addressBookSearchLabel ??
                          stringNotFoundText),
                      suffixIcon:
                          Row(mainAxisSize: MainAxisSize.min, children: [
                        const Icon(Icons.search_rounded),
                        const SizedBox(width: 3, height: 1),
                        IconButton(
                            onPressed: () {
                              showNewAddressDialog(wallet.toString());
                            },
                            icon: Icon(
                              Icons.add_rounded,
                              semanticLabel: AppLocalizations.of(context)
                                  ?.addressBookNewAddress,
                            ))
                      ]),
                    ),
                    onChanged: (val) {
                      setState(() {
                        filterAddressBook();
                      });
                    },
                    controller: _searchController)),
            // address list
            Container(
                margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)
                                ?.addressBookSavedAddresses ??
                            stringNotFoundText,
                        style: const TextStyle(fontSize: 24),
                      ),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            getAddressBookStatusWidget(context),
                            const SizedBox(
                              width: 6,
                              height: 1,
                            ),
                            IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                            title: Text(AppLocalizations.of(
                                                        context)
                                                    ?.addressBookClearConfirmationTitle ??
                                                stringNotFoundText),
                                            content: Container(
                                                constraints: const BoxConstraints(
                                                    maxWidth:
                                                        responsiveMaxDialogWidth),
                                                child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text(AppLocalizations.of(
                                                                  context)
                                                              ?.addressBookClearConfirmation ??
                                                          stringNotFoundText)
                                                    ])),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text(
                                                      AppLocalizations.of(
                                                                  context)
                                                              ?.noAction ??
                                                          stringNotFoundText)),
                                              TextButton(
                                                  onPressed: () async {
                                                    Navigator.of(context).pop();

                                                    final SharedPreferences
                                                        prefs =
                                                        await SharedPreferences
                                                            .getInstance();
                                                    prefs.remove(
                                                        prefsAddressBook +
                                                            wallet.toString());

                                                    setState(() {
                                                      _addressBook = [];
                                                      filterAddressBook();
                                                    });

                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(AppLocalizations
                                                                    .of(context)
                                                                ?.addressBookCleared ??
                                                            stringNotFoundText),
                                                      ),
                                                    );
                                                  },
                                                  child: Text(
                                                      AppLocalizations.of(
                                                                  context)
                                                              ?.yesAction ??
                                                          stringNotFoundText))
                                            ]);
                                      });
                                },
                                icon: Icon(
                                  Icons.delete_forever_rounded,
                                  color: Theme.of(context).colorScheme.primary,
                                  semanticLabel: AppLocalizations.of(context)
                                      ?.addressBookClearConfirmationTitle,
                                ))
                          ])
                    ])),
            Expanded(
                child: Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Column(mainAxisSize: MainAxisSize.max, children: [
                Expanded(child: ListView(children: getAddressWidgets())),
              ]),
            )),
          ]),
    );

    return PopScope(
        canPop: false,
        child: useVerticalBar
            ? MainLayout(
                overrideTitle: AppLocalizations.of(context)?.addressBookTitle,
                child: container)
            : BackLayout(
                title: AppLocalizations.of(context)?.addressBookTitle,
                back: () {
                  Navigator.of(context).push(_createBackRoute(useVerticalBar));
                },
                child: container));
  }

  void showNewAddressDialog(String wallet) {
    _labelController.text = WalletStaticState.prevAddressBookLabel;
    _valueController.text = WalletStaticState.tmpAddressBookAddress;
    WalletStaticState.prevAddressBookLabel = '';
    WalletStaticState.tmpAddressBookAddress = '';

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text(AppLocalizations.of(context)?.addressBookNewAddress ??
                  stringNotFoundText),
              content: Form(
                  key: _formKey,
                  child: Container(
                      width: double.infinity,
                      constraints: const BoxConstraints(
                          maxWidth: responsiveMaxDialogExtendedWidth),
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        Container(
                            margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: TextFormField(
                                enableSuggestions: true,
                                autocorrect: true,
                                decoration: InputDecoration(
                                  contentPadding:
                                      const EdgeInsets.only(bottom: 0.0),
                                  border: const UnderlineInputBorder(),
                                  hintText: AppLocalizations.of(context)
                                      ?.addressBookNewAddressLabelHint,
                                  label: Text(AppLocalizations.of(context)
                                          ?.addressBookNewAddressLabel ??
                                      stringNotFoundText),
                                  suffixIcon: IconButton(
                                    onPressed: checkScanQROS()
                                        ? () {
                                            WalletStaticState
                                                    .prevAddressBookLabel =
                                                _labelController.text;
                                            // save currently entered label
                                            BaseStaticState.prevScanQRScreen =
                                                Screen.addressBook;
                                            Navigator.of(context)
                                                .pushReplacement(
                                                    _createScanQRRoute());
                                          }
                                        : null,
                                    icon: Icon(
                                      Icons.qr_code_scanner_rounded,
                                      semanticLabel:
                                          AppLocalizations.of(context)
                                              ?.scanQRTitle,
                                    ),
                                  ),
                                ),
                                controller: _labelController)),
                        Container(
                            margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: TextFormField(
                                validator: (value) {
                                  return WalletHelper.verifyAddress(value ?? '')
                                      ? null
                                      : AppLocalizations.of(context)
                                          ?.makeTxVerifyInvalidAddress;
                                },
                                enableSuggestions: true,
                                autocorrect: true,
                                decoration: InputDecoration(
                                  contentPadding:
                                      const EdgeInsets.only(bottom: 0.0),
                                  border: const UnderlineInputBorder(),
                                  hintText: AppLocalizations.of(context)
                                      ?.addressBookNewAddressValueHint,
                                  label: Text(AppLocalizations.of(context)
                                          ?.addressBookNewAddressValue ??
                                      stringNotFoundText),
                                ),
                                controller: _valueController)),
                      ]))),
              actions: [
                TextButton(
                    onPressed: () {
                      WalletStaticState.prevAddressBookLabel = '';
                      Navigator.of(context).pop();
                    },
                    child: Text(AppLocalizations.of(context)
                            ?.addressBookNewAddressCancelButton ??
                        stringNotFoundText)),
                TextButton(
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }

                      WalletStaticState.prevAddressBookLabel = '';
                      Navigator.of(context).pop();

                      // serialize data
                      var address = AddressModel(random.nextInt(2147483647),
                          _labelController.text, _valueController.text);
                      String json = jsonEncode(address);

                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      var addresses =
                          prefs.getStringList(prefsAddressBook + wallet) ?? [];
                      addresses.add(json);
                      prefs.setStringList(
                          prefsAddressBook + wallet.toString(), addresses);

                      updateAddressBook(wallet);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(AppLocalizations.of(context)
                                  ?.addressBookNewAddressSavedNotification ??
                              stringNotFoundText),
                        ),
                      );
                    },
                    child: Text(AppLocalizations.of(context)
                            ?.addressBookNewAddressSaveButton ??
                        stringNotFoundText))
              ]);
        });
  }

  List<Widget> getAddressWidgets() {
    List<Widget> addressWidgets = [];
    var wallet = context.read<WalletState>().selectedWallet;
    for (var el in _addressBookFiltered.reversed) {
      addressWidgets.add(AddressBookAddress(
          onRefresh: () {
            updateAddressBook(wallet.toString());
          },
          id: el.id,
          label: el.label,
          address: el.address));
    }

    if (addressWidgets.isEmpty) {
      addressWidgets.add(Center(
          child: Text(
        AppLocalizations.of(context)?.noAddressBookAddresses ??
            stringNotFoundText,
        style: const TextStyle(fontSize: 16.0),
      )));
    }
    return addressWidgets;
  }

  Widget getAddressBookStatusWidget(BuildContext context) {
    return _addressBookLoaded
        ? const SizedBox(height: 24.0, width: 24.0)
        : SizedBox(
            height: 24.0,
            width: 24.0,
            child: Center(
                child: CircularProgressIndicator(
              semanticsLabel:
                  AppLocalizations.of(context)?.addressBookLoadingSemantics,
            )));
  }
}

Route _createBackRoute(bool useVerticalBar) {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
    return const MakeTx();
  }, transitionsBuilder: (context, animation, secondaryAnimation, child) {
    if (useVerticalBar) {
      return child;
    }

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
