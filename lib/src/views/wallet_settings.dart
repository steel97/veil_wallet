// ignore_for_file: empty_catches

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:veil_wallet/src/core/constants.dart';
import 'package:veil_wallet/src/core/wallet_helper.dart';
import 'package:veil_wallet/src/layouts/mobile/back_layout.dart';
import 'package:veil_wallet/src/states/states_bridge.dart';
import 'package:veil_wallet/src/states/static/base_static_state.dart';
import 'package:veil_wallet/src/states/static/wallet_static_state.dart';
import 'package:veil_wallet/src/storage/storage_item.dart';
import 'package:veil_wallet/src/storage/storage_service.dart';
import 'package:veil_wallet/src/views/home.dart';
import 'package:veil_wallet/src/views/new_wallet_save_seed.dart';

// Create a Form widget.
class WalletSettings extends StatefulWidget {
  const WalletSettings({super.key});

  @override
  State<WalletSettings> createState() => _WalletSettingsState();
}

class _WalletSettingsState extends State<WalletSettings> {
  final _formKey = GlobalKey<FormState>();

  final _walletNameInput = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();

  bool _actionBusy = false;
  bool _saveBusy = false;
  bool _deleteWalletBusy = false;

  @override
  void initState() {
    super.initState();
    // Fetch user data from API using BuildContext
    _walletNameInput.text = BaseStaticState.walSettingsName;
    _passwordController.text = BaseStaticState.walSettingsPassword;
    _passwordConfirmController.text = BaseStaticState.walSettingsPassword;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> settingsAdvanced = [
      Container(
          margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: TextField(
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(bottom: 0.0),
                border: const UnderlineInputBorder(),
                hintText:
                    AppLocalizations.of(context)?.walletNameInputFieldHint,
                label: Text(
                    AppLocalizations.of(context)?.walletNameInputField ??
                        stringNotFoundText)),
            controller: _walletNameInput,
          )),
      Container(
          margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: TextFormField(
            controller: _passwordController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return null;
              }
              return _passwordController.text != _passwordConfirmController.text
                  ? AppLocalizations.of(context)?.passwordsNotMatch
                  : null;
            },
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(bottom: 0.0),
                border: const UnderlineInputBorder(),
                hintText: AppLocalizations.of(context)
                    ?.walletEncryptionPasswordInputFieldHint,
                label: Text(AppLocalizations.of(context)
                        ?.walletEncryptionPasswordInputField ??
                    stringNotFoundText)),
          )),
      Container(
          margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: TextFormField(
            controller: _passwordConfirmController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return null;
              }
              return _passwordController.text != _passwordConfirmController.text
                  ? AppLocalizations.of(context)?.passwordsNotMatch
                  : null;
            },
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(bottom: 0.0),
                border: const UnderlineInputBorder(),
                hintText: AppLocalizations.of(context)
                    ?.walletEncryptionPasswordRepeatInputFieldHint,
                label: Text(AppLocalizations.of(context)
                        ?.walletEncryptionPasswordRepeatInputField ??
                    stringNotFoundText)),
          )),
    ];

    settingsAdvanced.add(Container(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: FilledButton.icon(
        style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(45)),
        onPressed: _actionBusy
            ? null
            : () async {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    _saveBusy = true;
                    _actionBusy = true;
                  });
                  try {
                    var reloadWallet = false;
                    if (BaseStaticState.walSettingsPassword !=
                        _passwordController.text) {
                      reloadWallet = true;
                    }

                    // save name
                    var newWalName = _walletNameInput.text;
                    var newPassword = _passwordController.text;

                    var storageService = StorageService();
                    var curWal = WalletStaticState.wallets?.firstWhere(
                        (element) =>
                            element.id == BaseStaticState.walSettingsId);

                    if (curWal != null) {
                      curWal.name = newWalName;
                    }

                    await storageService.writeSecureData(StorageItem(
                        prefsWalletNames +
                            BaseStaticState.walSettingsId.toString(),
                        newWalName));

                    if (reloadWallet) {
                      // update password
                      await storageService.writeSecureData(StorageItem(
                          prefsWalletEncryption +
                              BaseStaticState.walSettingsId.toString(),
                          newPassword));

                      // reload wallet
                      await WalletHelper.setActiveWallet(
                          BaseStaticState.walSettingsId,
                          StatesBridge.navigatorKey.currentContext!,
                          shouldSetActiveAddress: true);
                    }

                    _resetState();

                    WidgetsBinding.instance.scheduleFrameCallback((_) {
                      Navigator.of(context).push(_createBackRoute());
                    });
                  } catch (e) {}

                  setState(() {
                    _saveBusy = false;
                    _actionBusy = false;
                  });
                }
              },
        icon: _saveBusy
            ? Container(
                width: 24,
                height: 24,
                padding: const EdgeInsets.all(2.0),
                child: const CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 3,
                ),
              )
            : const Icon(Icons.save_rounded),
        label: Text(
            AppLocalizations.of(context)?.saveButton ?? stringNotFoundText,
            overflow: TextOverflow.ellipsis),
      ),
    ));

    settingsAdvanced.add(Container(
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: OutlinedButton.icon(
        style: FilledButton.styleFrom(
            minimumSize: const Size.fromHeight(45),
            foregroundColor: Theme.of(context).colorScheme.error),
        onPressed: _actionBusy
            ? null
            : () async {
                setState(() {
                  _actionBusy = true;
                });

                try {
                  // show confirmation window
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            title: Text(AppLocalizations.of(context)
                                    ?.deleteWalletConfirmationTitle ??
                                stringNotFoundText),
                            content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(AppLocalizations.of(context)
                                          ?.deleteWalletConfirmation ??
                                      stringNotFoundText)
                                ]),
                            actions: [
                              TextButton(
                                  onPressed: _deleteWalletBusy
                                      ? null
                                      : () {
                                          Navigator.of(context).pop();
                                        },
                                  child: Text(
                                      AppLocalizations.of(context)?.noAction ??
                                          stringNotFoundText)),
                              TextButton(
                                  onPressed: _deleteWalletBusy
                                      ? null
                                      : () {
                                          setState(() {
                                            _deleteWalletBusy = true;
                                          });

                                          try {} catch (e) {
                                            setState(() {
                                              _deleteWalletBusy = false;
                                            });
                                          }
                                        },
                                  child: Text(
                                      AppLocalizations.of(context)?.yesAction ??
                                          stringNotFoundText))
                            ]);
                      });
                } catch (e) {}

                setState(() {
                  _actionBusy = false;
                });
              },
        icon: const Icon(Icons.fingerprint_rounded),
        label: Text(AppLocalizations.of(context)?.deleteWalletAction ??
            stringNotFoundText),
      ),
    ));

    return BackLayout(
        title: AppLocalizations.of(context)?.walletSettingsTitle,
        back: () {
          _resetState();
          Navigator.of(context).push(_createBackRoute());
        },
        child: Form(
            key: _formKey,
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: settingsAdvanced),
            )));
  }
}

Route _createBackRoute() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
    if (false) {
      // check if we have wallets, if no - move to welcome
      return const NewWalletSaveSeed();
    }
    return const Home();
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

void _resetState() {
  BaseStaticState.walSettingsId = -1;
  BaseStaticState.walSettingsName = '';
  BaseStaticState.walSettingsPassword = '';
}
