import 'package:flutter/material.dart';
import 'package:veil_wallet/src/layouts/mobile/main_layout.dart';
import 'package:veil_wallet/src/layouts/mobile/welcome_layout.dart';
import 'package:veil_wallet/src/states/static/base_static_state.dart';
import 'package:veil_wallet/src/views/import_seed.dart';
import 'package:veil_wallet/src/views/new_wallet_save_seed.dart';
import 'package:veil_light_plugin/veil_light.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return WelcomeLayout(
        child: Container(
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(0, 0, 0, 100),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          "Welcome to Veil!",
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        Text(
          "Import existing wallet or create new",
          style: TextStyle(fontSize: 14),
          textAlign: TextAlign.center,
        ),
        Container(
            width: 170,
            margin: EdgeInsets.fromLTRB(0, 15, 0, 6),
            child: FilledButton.icon(
              style: FilledButton.styleFrom(minimumSize: Size.fromHeight(42)),
              onPressed: () {
                var mnemonic = Lightwallet.generateMnemonic();
                BaseStaticState.newWalletWords = mnemonic;
                Navigator.of(context).push(_createSaveRoute());
              },
              icon: Icon(Icons.new_label_rounded),
              label: const Text('Create'),
            )),
        Container(
            width: 170,
            child: OutlinedButton.icon(
              style: FilledButton.styleFrom(minimumSize: Size.fromHeight(42)),
              onPressed: () {
                Navigator.of(context).push(_createImportRoute());
              },
              icon: Icon(Icons.upload_rounded),
              label: const Text('Import'),
            )),
      ]),
    ));
  }
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

Route _createImportRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const ImportSeed(),
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
