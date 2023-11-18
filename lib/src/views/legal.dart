import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:veil_wallet/src/layouts/mobile/back_layout.dart';
import 'package:veil_wallet/src/views/about.dart';

class Legal extends StatelessWidget {
  const Legal({super.key});

  @override
  Widget build(BuildContext context) {
    var legalFeature = rootBundle.loadString('assets/res/legal.txt');
    return PopScope(
        child: BackLayout(
            title: AppLocalizations.of(context)?.legalTitle,
            back: () {
              Navigator.of(context).push(_createBackRoute());
            },
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(5, 10, 5, 10),
              child: ListView(children: [
                FutureBuilder(
                    future: legalFeature,
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      return SelectableText(
                        snapshot.data ?? '',
                      );
                    })
              ]),
            )));
  }
}

Route _createBackRoute() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
    return const About();
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
