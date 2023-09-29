import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:veil_wallet/src/layouts/mobile/back_layout.dart';
import 'package:veil_wallet/src/layouts/mobile/main_layout.dart';
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
        title: "Settings",
        back: () {
          Navigator.of(context).push(_createBackRoute());
        },
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: TextField(
                        enableSuggestions: true,
                        autocorrect: false,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 0.0),
                          border: UnderlineInputBorder(),
                          hintText:
                              'Veil lightwallet node url (starts with http(s)://)',
                          label: Text("Node url:"),
                          suffixIcon: IconButton(
                            onPressed: () => {},
                            icon: Icon(Icons.restore_rounded),
                          ),
                        ),
                        controller: nodeUrl)),
                Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: TextField(
                      enableSuggestions: true,
                      autocorrect: false,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 0.0),
                          border: UnderlineInputBorder(),
                          hintText: 'Empty for explorer\'s node',
                          label: Text("Node basic auth:")),
                    )),
                Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: TextField(
                      enableSuggestions: true,
                      autocorrect: false,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 0.0),
                        border: UnderlineInputBorder(),
                        hintText: 'Explorer url',
                        label: Text("Explorer url:"),
                        suffixIcon: IconButton(
                          onPressed: () => {},
                          icon: Icon(Icons.restore_rounded),
                        ),
                      ),
                      controller: explorerUrl,
                    )),
                Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: TextField(
                      enableSuggestions: true,
                      autocorrect: false,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 0.0),
                        border: UnderlineInputBorder(),
                        hintText: 'Transactions explorer url',
                        label: Text("Tx explorer url:"),
                        suffixIcon: IconButton(
                          onPressed: () => {},
                          icon: Icon(Icons.restore_rounded),
                        ),
                      ),
                      controller: txExplorer,
                    )),
                Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Use minimum UTXOs",
                              style: TextStyle(fontSize: 16)),
                          Switch(value: false, onChanged: (val) => {}),
                        ])),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: OutlinedButton.icon(
                    style: FilledButton.styleFrom(
                        minimumSize: Size.fromHeight(45)),
                    onPressed: () {},
                    icon: Icon(Icons.fingerprint_rounded),
                    label: const Text('Setup biometrics'),
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
                Container(
                    width: double.infinity,
                    child: Row(children: [
                      Flexible(
                          flex: 1,
                          child: Container(
                            margin: EdgeInsets.fromLTRB(10, 0, 5, 10),
                            child: OutlinedButton.icon(
                              style: FilledButton.styleFrom(
                                  minimumSize: Size.fromHeight(45)),
                              onPressed: () {
                                var mnemonic = Lightwallet.generateMnemonic();
                                BaseStaticState.newWalletWords = mnemonic;
                                Navigator.of(context).push(_createSaveRoute());
                              },
                              icon: Icon(Icons.new_label_rounded),
                              label: const Text('Create wallet'),
                            ),
                          )),
                      Flexible(
                          flex: 1,
                          child: Container(
                            margin: EdgeInsets.fromLTRB(5, 0, 10, 10),
                            child: OutlinedButton.icon(
                              style: FilledButton.styleFrom(
                                  minimumSize: Size.fromHeight(45)),
                              onPressed: () {},
                              icon: Icon(Icons.upload_rounded),
                              label: const Text('Import wallet'),
                            ),
                          ))
                    ])),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: FilledButton.icon(
                    style: FilledButton.styleFrom(
                        minimumSize: Size.fromHeight(45)),
                    onPressed: () {},
                    icon: Icon(Icons.save_rounded),
                    label: const Text('Save'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: FilledButton.icon(
                    style: FilledButton.styleFrom(
                        minimumSize: Size.fromHeight(45)),
                    onPressed: () {},
                    icon: Icon(Icons.info_rounded),
                    label: const Text('About'),
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
