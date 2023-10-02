import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:veil_wallet/src/layouts/mobile/loading_layout.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return LoadingLayout(
        child: Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 100),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 30),
            width: 70 * 1.8,
            height: 28 * 1.8,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('./assets/images/logo_full_light.png'),
                    fit: BoxFit.fitWidth))),
        CircularProgressIndicator(
          semanticsLabel: AppLocalizations.of(context)?.loadingAppSemantics,
        ),
      ]),
    ));
  }
}
