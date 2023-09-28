import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:veil_wallet/src/layouts/mobile/back_layout.dart';
import 'package:veil_wallet/src/layouts/mobile/main_layout.dart';

class SetupBiometrics extends StatelessWidget {
  const SetupBiometrics({super.key});

  @override
  Widget build(BuildContext context) {
    return BackLayout(
        title: "Secure your wallet",
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 20),
                    child: Text(
                        "To secure your wallet we strongly recommend to setup biometrics authentication for this app",
                        style: TextStyle(fontWeight: FontWeight.normal),
                        textAlign: TextAlign.center)),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: FilledButton.icon(
                    style: FilledButton.styleFrom(
                        minimumSize: Size.fromHeight(45)),
                    onPressed: () {},
                    icon: Icon(Icons.fingerprint_rounded),
                    label: const Text('Setup biometrics'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: OutlinedButton.icon(
                    style: FilledButton.styleFrom(
                        minimumSize: Size.fromHeight(45)),
                    onPressed: () {},
                    icon: Icon(Icons.arrow_circle_right),
                    label: const Text('Skip (not recommended)'),
                  ),
                ),
              ]),
        ));
  }
}
