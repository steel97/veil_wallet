import 'package:flutter/material.dart';
import 'package:veil_wallet/src/layouts/mobile/main_layout.dart';
import 'package:veil_wallet/src/layouts/mobile/welcome_layout.dart';

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
              onPressed: () {},
              icon: Icon(Icons.new_label_rounded),
              label: const Text('Create'),
            )),
        Container(
            width: 170,
            child: OutlinedButton.icon(
              style: FilledButton.styleFrom(minimumSize: Size.fromHeight(42)),
              onPressed: () {},
              icon: Icon(Icons.upload_rounded),
              label: const Text('Import'),
            )),
      ]),
    ));
  }
}
