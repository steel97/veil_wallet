import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:veil_wallet/src/core/constants.dart';
import 'package:veil_wallet/src/layouts/mobile/back_layout.dart';
import 'package:veil_wallet/src/states/static/base_static_state.dart';
import 'package:veil_wallet/src/views/new_wallet_save_seed.dart';
import 'package:veil_wallet/src/views/welcome.dart';
import 'package:veil_light_plugin/veil_light.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    var nodeUrl = TextEditingController();
    nodeUrl.text = "https://explorer-api.veil-project.com";

    var explorerUrl = TextEditingController();
    explorerUrl.text = "https://explorer.veil-project.com";

    var txExplorer = TextEditingController();
    txExplorer.text = "https://explorer.veil-project.com/tx/{txid}";

    return BackLayout(
        title: AppLocalizations.of(context)?.settingsTitle,
        back: () {
          Navigator.of(context).push(_createBackRoute());
        },
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: ListView(
              //mainAxisAlignment: MainAxisAlignment.start,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: TextField(
                        enableSuggestions: true,
                        autocorrect: false,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(bottom: 0.0),
                          border: const UnderlineInputBorder(),
                          hintText: AppLocalizations.of(context)
                              ?.nodeUrlInputFieldHint,
                          label: Text(
                              AppLocalizations.of(context)?.nodeUrlInputField ??
                                  stringNotFoundText),
                          suffixIcon: IconButton(
                            onPressed: () => {},
                            icon: const Icon(Icons.restore_rounded),
                          ),
                        ),
                        controller: nodeUrl)),
                Container(
                    margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: TextField(
                      enableSuggestions: true,
                      autocorrect: false,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(bottom: 0.0),
                          border: const UnderlineInputBorder(),
                          hintText: AppLocalizations.of(context)
                              ?.basicAuthInputFieldHint,
                          label: Text(AppLocalizations.of(context)
                                  ?.basicAuthInputField ??
                              stringNotFoundText)),
                    )),
                Container(
                    margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: TextField(
                      enableSuggestions: true,
                      autocorrect: false,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(bottom: 0.0),
                        border: const UnderlineInputBorder(),
                        hintText: AppLocalizations.of(context)
                            ?.explorerUrlInputFieldHint,
                        label: Text(AppLocalizations.of(context)
                                ?.explorerUrlInputField ??
                            stringNotFoundText),
                        suffixIcon: IconButton(
                          onPressed: () => {},
                          icon: const Icon(Icons.restore_rounded),
                        ),
                      ),
                      controller: explorerUrl,
                    )),
                Container(
                    margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: TextField(
                      enableSuggestions: true,
                      autocorrect: false,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(bottom: 0.0),
                        border: const UnderlineInputBorder(),
                        hintText: AppLocalizations.of(context)
                            ?.explorerTxInputFieldHint,
                        label: Text(AppLocalizations.of(context)
                                ?.explorerTxInputField ??
                            stringNotFoundText),
                        suffixIcon: IconButton(
                          onPressed: () => {},
                          icon: const Icon(Icons.restore_rounded),
                        ),
                      ),
                      controller: txExplorer,
                    )),
                Container(
                    margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              AppLocalizations.of(context)?.useMinimumUTXOs ??
                                  stringNotFoundText,
                              style: const TextStyle(fontSize: 16)),
                          Switch(value: false, onChanged: (val) => {}),
                        ])),
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: OutlinedButton.icon(
                    style: FilledButton.styleFrom(
                        minimumSize: const Size.fromHeight(45)),
                    onPressed: () {},
                    icon: const Icon(Icons.fingerprint_rounded),
                    label: Text(
                        AppLocalizations.of(context)?.setupBiometricsButton ??
                            stringNotFoundText),
                  ),
                ),
                /*
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: OutlinedButton.icon(
                    style: FilledButton.styleFrom(
                        minimumSize: Size.fromHeight(45)),
                    onPressed: () {},
                    icon: Icon(Icons.new_label_rounded),
                    label: const Text('Create new wallet'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: OutlinedButton.icon(
                    style: FilledButton.styleFrom(
                        minimumSize: Size.fromHeight(45)),
                    onPressed: () {},
                    icon: Icon(Icons.upload_rounded),
                    label: const Text('Import new wallet'),
                  ),
                ),
                */
                SizedBox(
                    width: double.infinity,
                    child: Row(children: [
                      Flexible(
                          flex: 1,
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(10, 0, 5, 10),
                            child: OutlinedButton.icon(
                              style: FilledButton.styleFrom(
                                  minimumSize: const Size.fromHeight(45)),
                              onPressed: () {
                                var mnemonic = Lightwallet.generateMnemonic();
                                BaseStaticState.newWalletWords = mnemonic;
                                Navigator.of(context).push(_createSaveRoute());
                              },
                              icon: const Icon(Icons.new_label_rounded),
                              label: Text(
                                  AppLocalizations.of(context)
                                          ?.createWalletButton ??
                                      stringNotFoundText,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          )),
                      Flexible(
                          flex: 1,
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(5, 0, 10, 10),
                            child: OutlinedButton.icon(
                              style: FilledButton.styleFrom(
                                  minimumSize: const Size.fromHeight(45)),
                              onPressed: () {},
                              icon: const Icon(Icons.upload_rounded),
                              label: Text(
                                  AppLocalizations.of(context)?.importWallet ??
                                      stringNotFoundText,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ))
                    ])),
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: FilledButton.icon(
                    style: FilledButton.styleFrom(
                        minimumSize: const Size.fromHeight(45)),
                    onPressed: () {},
                    icon: const Icon(Icons.save_rounded),
                    label: Text(
                        AppLocalizations.of(context)?.saveButton ??
                            stringNotFoundText,
                        overflow: TextOverflow.ellipsis),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: FilledButton.icon(
                    style: FilledButton.styleFrom(
                        minimumSize: const Size.fromHeight(45)),
                    onPressed: () {},
                    icon: const Icon(Icons.info_rounded),
                    label: Text(
                        AppLocalizations.of(context)?.aboutButton ??
                            stringNotFoundText,
                        overflow: TextOverflow.ellipsis),
                  ),
                ),
              ]),
        ));
  }
}

Route _createBackRoute() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const Welcome(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(-1.0, 0.0);
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

Route _createSaveRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        const NewWalletSaveSeed(),
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
