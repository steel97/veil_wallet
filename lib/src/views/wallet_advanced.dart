import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:veil_wallet/src/core/constants.dart';
import 'package:veil_wallet/src/core/screen.dart';
import 'package:veil_wallet/src/layouts/mobile/back_layout.dart';
import 'package:veil_wallet/src/states/static/base_static_state.dart';
import 'package:veil_wallet/src/views/import_seed.dart';
import 'package:veil_wallet/src/views/new_wallet_save_seed.dart';

// Create a Form widget.
class WalletAdvanced extends StatefulWidget {
  const WalletAdvanced({super.key});

  @override
  State<WalletAdvanced> createState() => _WalletAdvancedState();
}

class _WalletAdvancedState extends State<WalletAdvanced> {
  final _formKey = GlobalKey<FormState>();

  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch user data from API using BuildContext
    _passwordController.text = BaseStaticState.walletEncryptionPassword;
    _passwordConfirmController.text = BaseStaticState.walletEncryptionPassword;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> settingsAdvanced = [
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

    // TO-DO create transactions.json logic
    /*if (BaseStaticState.prevWalAdvancedScreen != Screen.newWallet) {
      settingsAdvanced.add(Container(
        margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: OutlinedButton.icon(
          style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(45)),
          onPressed: () async {
            FilePickerResult? result = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: ['json'],
                withData: true);

            if (result != null) {
              File file = File(result.files.single.path!);
              // TO-DO validate file and store it's content to storage
            } else {
              // User canceled the picker
            }
          },
          icon: const Icon(Icons.file_open_rounded),
          label: Text(
              AppLocalizations.of(context)!
                  .walletImportTransactionsData('transactions.json'),
              overflow: TextOverflow.ellipsis),
        ),
      ));
    }*/

    settingsAdvanced.add(Container(
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: FilledButton.icon(
        style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(45)),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            // done
            BaseStaticState.walletEncryptionPassword = _passwordController.text;
            Navigator.of(context).push(_createBackRoute());
          }
        },
        icon: const Icon(Icons.save_rounded),
        label: Text(
            AppLocalizations.of(context)?.saveButton ?? stringNotFoundText,
            overflow: TextOverflow.ellipsis),
      ),
    ));

    return BackLayout(
        title: AppLocalizations.of(context)?.walletAdvancedTitle,
        back: () {
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
    if (BaseStaticState.prevWalAdvancedScreen == Screen.newWallet) {
      return const NewWalletSaveSeed();
    }
    return const ImportSeed();
  }, transitionsBuilder: (context, animation, secondaryAnimation, child) {
    const begin = Offset(0.0, -1.0);
    const end = Offset.zero;
    const curve = Curves.ease;

    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  });
}
