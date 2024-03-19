// ignore_for_file: empty_catches

import 'package:extended_text/extended_text.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:veil_wallet/src/core/constants.dart';
import 'package:veil_wallet/src/core/core.dart';
import 'package:veil_wallet/src/layouts/mobile/back_layout.dart';
import 'package:veil_wallet/src/views/legal.dart';
import 'package:veil_wallet/src/views/settings.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    var packageInfo = PackageInfo.fromPlatform();
    return PopScope(
        onPopInvoked: (invoked) {
          Navigator.of(context).push(_createBackRoute());
        },
        child: BackLayout(
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
                            style:
                                const TextStyle(fontWeight: FontWeight.normal),
                            textAlign: TextAlign.center)),
                    TextButton(
                        onPressed: () async {
                          try {
                            var url = Uri.parse(sourceCodeUrl);
                            await launchUrlWrapped(url);
                          } catch (e) {}
                        },
                        child: const Text(
                          sourceCodeUrl,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14),
                        )),
                    Container(
                        margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: Text(
                            AppLocalizations.of(context)?.aboutText2 ??
                                stringNotFoundText,
                            style:
                                const TextStyle(fontWeight: FontWeight.normal),
                            textAlign: TextAlign.center)),
                    TextButton.icon(
                        onPressed: () {
                          Clipboard.setData(
                                  const ClipboardData(text: donationsAddress))
                              .then((value) => {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            AppLocalizations.of(context)
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
                        )),
                    Container(
                        margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: Text(
                            AppLocalizations.of(context)?.discordInfo ??
                                stringNotFoundText,
                            style:
                                const TextStyle(fontWeight: FontWeight.normal),
                            textAlign: TextAlign.center)),
                    TextButton.icon(
                        onPressed: () async {
                          try {
                            var url = Uri.parse(discordAddress);
                            await launchUrlWrapped(url);
                          } catch (e) {}
                        },
                        icon: const Icon(Icons.discord_outlined),
                        label: const Text(discordLabel)),
                    Container(
                        margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                        child: Text(
                            AppLocalizations.of(context)?.discordFaucetInfo ??
                                stringNotFoundText,
                            style: const TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 12),
                            textAlign: TextAlign.center)),
                    FilledButton.icon(
                        onPressed: () {
                          Navigator.of(context).push(_createLegalRoute());
                        },
                        icon: const Icon(Icons.info_outline),
                        label: Text(AppLocalizations.of(context)?.legalInfo ??
                            stringNotFoundText)),
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FutureBuilder(
                            future: packageInfo,
                            builder: (BuildContext context,
                                AsyncSnapshot<PackageInfo> snapshot) {
                              return Text('ver. ${snapshot.data?.version}');
                            })
                      ],
                    ))
                  ]),
            )));
  }
}

Route _createLegalRoute() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
    return const Legal();
  }, transitionsBuilder: (context, animation, secondaryAnimation, child) {
    const begin = Offset(1.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.ease;

    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  });
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
