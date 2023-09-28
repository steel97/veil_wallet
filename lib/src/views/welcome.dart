import 'package:flutter/material.dart';
import 'package:veil_wallet/src/layouts/main_layout.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
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
            margin: EdgeInsets.fromLTRB(0, 15, 0, 4),
            child: FilledButton(
              onPressed: () {},
              child: const Text('Create'),
            )),
        Container(
            width: 170,
            child: FilledButton(
              onPressed: () {},
              child: const Text('Import'),
            )),
      ]),
    ));
  }
}
