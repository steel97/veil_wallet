import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:veil_wallet/src/layouts/mobile/back_layout.dart';
import 'package:veil_wallet/src/layouts/mobile/main_layout.dart';
import 'package:veil_wallet/src/views/import_seed.dart';

class ImportSeedAdvanced extends StatelessWidget {
  const ImportSeedAdvanced({super.key});

  @override
  Widget build(BuildContext context) {
    return BackLayout(
        title: "Advanced settings",
        back: () => {Navigator.of(context).push(_createBackRoute())},
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
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 0.0),
                          border: UnderlineInputBorder(),
                          hintText: 'Wallet encryption password',
                          label: Text("Encryption password (if exists):")),
                    )),
                Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: TextField(
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 0.0),
                          border: UnderlineInputBorder(),
                          hintText: 'Repeat wallet encryption password',
                          label: Text("Repeat encryption password:")),
                    )),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: OutlinedButton.icon(
                    style: FilledButton.styleFrom(
                        minimumSize: Size.fromHeight(45)),
                    onPressed: () {},
                    icon: Icon(Icons.file_open_rounded),
                    label: const Text('Import transactions.json'),
                  ),
                ),
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
              ]),
        ));
  }
}

Route _createBackRoute() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const ImportSeed(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, -1.0);
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
