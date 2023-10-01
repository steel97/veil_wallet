import 'package:extended_text/extended_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:veil_wallet/src/core/constants.dart';
import 'package:veil_wallet/src/layouts/mobile/back_layout.dart';
import 'package:veil_wallet/src/views/settings.dart';

const donationsAddress =
    "sv1qqp3twtj249e226mvg55jm0ec36y99xsh5ytnm6hcgvetthuptj2kugpqwcnw6tpnvwrrvutsltnghkg46ayqpw40g6p3knppy3kwgvhr34mkqqqeedkfp";

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return BackLayout(
        title: AppLocalizations.of(context)?.aboutTitle,
        back: () {
          Navigator.of(context).push(_createBackRoute());
        },
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: Text(
                        AppLocalizations.of(context)?.aboutText ??
                            stringNotFoundText,
                        style: const TextStyle(fontWeight: FontWeight.normal),
                        textAlign: TextAlign.center)),
                TextButton.icon(
                    onPressed: () {
                      Clipboard.setData(
                              const ClipboardData(text: donationsAddress))
                          .then((value) => {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(AppLocalizations.of(context)
                                            ?.copiedText ??
                                        stringNotFoundText),
                                  ),
                                )
                              });
                    },
                    icon: const Icon(Icons.copy_rounded),
                    label: const ExtendedText(
                      donationsAddress,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      overflowWidget: TextOverflowWidget(
                        position: TextOverflowPosition.middle,
                        align: TextOverflowAlign.center,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              '\u2026',
                              style: TextStyle(fontSize: 14),
                            )
                          ],
                        ),
                      ),
                      style: TextStyle(fontSize: 14),
                    ))
              ]),
        ));
  }
}

Route _createBackRoute() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
    return const Settings();
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
