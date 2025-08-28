// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:veil_wallet/src/generated/i18n/app_localizations.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:provider/provider.dart';
import 'package:veil_wallet/src/core/constants.dart';
import 'package:veil_wallet/src/helpers/responsive.dart';
import 'package:veil_wallet/src/layouts/mobile/back_layout.dart';
import 'package:veil_wallet/src/layouts/mobile/main_layout.dart';
import 'package:veil_wallet/src/states/provider/wallet_state.dart';
import 'package:veil_wallet/src/views/home.dart';

class ReceiveCoins extends StatefulWidget {
  const ReceiveCoins({super.key});

  @override
  State<ReceiveCoins> createState() => _ReceiveCoinsState();
}

class _ReceiveCoinsState extends State<ReceiveCoins> {
  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    var useVerticalBar = isBigScreen(context);
    double qrMaxSize = 300;

    var container = Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Text(
                    AppLocalizations.of(context)?.shareDescriptionText ??
                        stringNotFoundText,
                    style: const TextStyle(fontWeight: FontWeight.normal),
                    textAlign: TextAlign.center)),
            Screenshot(
              controller: screenshotController,
              child: Container(
                  constraints:
                      BoxConstraints(maxWidth: qrMaxSize, maxHeight: qrMaxSize),
                  color: Theme.of(context).colorScheme.background,
                  padding: const EdgeInsets.all(30),
                  child: PrettyQrView.data(
                      data:
                          'veil:${context.watch<WalletState>().selectedAddress}',
                      errorCorrectLevel: QrErrorCorrectLevel.M,
                      decoration: PrettyQrDecoration(
                        shape: PrettyQrSmoothSymbol(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        /*image: const PrettyQrDecorationImage(
                      image: AssetImage('assets/images/logo.png'),
                    ),*/
                      ))),
            ),
            TextButton.icon(
                onPressed: () async {
                  var image = await screenshotController.capture();

                  Share.shareXFiles([
                    XFile.fromData(image!,
                        name: 'veil_qr.png', mimeType: 'image/png')
                  ],
                      subject: AppLocalizations.of(context)?.shareSubject,
                      text: AppLocalizations.of(context)?.shareText(
                          context.read<WalletState>().selectedAddress));
                },
                icon: const Icon(Icons.share_rounded),
                label: Text(AppLocalizations.of(context)?.shareAction ??
                    stringNotFoundText))
          ]),
    );

    return PopScope(
        canPop: false,
        onPopInvoked: (invoked) {
          if (useVerticalBar) return;

          Navigator.of(context).push(_createBackRoute(useVerticalBar));
        },
        child: useVerticalBar
            ? MainLayout(
                overrideTitle: AppLocalizations.of(context)?.shareTitle,
                child: container)
            : BackLayout(
                title: AppLocalizations.of(context)?.shareTitle,
                back: () {
                  Navigator.of(context).push(_createBackRoute(useVerticalBar));
                },
                child: container));
  }
}

Route _createBackRoute(bool useVerticalBar) {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
    return const Home();
  }, transitionsBuilder: (context, animation, secondaryAnimation, child) {
    if (useVerticalBar) {
      return child;
    }

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
