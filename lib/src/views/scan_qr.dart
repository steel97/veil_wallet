// ignore_for_file: empty_catches
//import 'dart:developer';
import 'dart:io';
import 'package:veil_wallet/src/generated/i18n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:veil_wallet/src/core/constants.dart';
import 'package:veil_wallet/src/core/screen.dart';
import 'package:veil_wallet/src/core/wallet_helper.dart';
import 'package:veil_wallet/src/layouts/mobile/back_layout.dart';
import 'package:veil_wallet/src/states/static/base_static_state.dart';
import 'package:veil_wallet/src/states/static/wallet_static_state.dart';
import 'package:veil_wallet/src/views/address_book.dart';
import 'package:veil_wallet/src/views/home.dart';
import 'package:veil_wallet/src/views/make_tx.dart';

class ScanQR extends StatefulWidget {
  const ScanQR({super.key});

  @override
  State<StatefulWidget> createState() => _ScanQRState();
}

class _ScanQRState extends State<ScanQR> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool _navBusy = false;
  bool _prmActive = true;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvoked: (invoked) {
          _backAction();
        },
        child: BackLayout(
          title: AppLocalizations.of(context)?.scanQRTitle,
          back: () {
            _backAction();
          },
          child: Stack(
            children: <Widget>[
              _buildQrView(context),
              Align(
                alignment: Alignment.bottomCenter,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.all(15),
                            child: IconButton.filled(
                                onPressed: () async {
                                  await controller?.toggleFlash();
                                  setState(() {});
                                },
                                style: IconButton.styleFrom(
                                    minimumSize: const Size.square(64)),
                                tooltip: AppLocalizations.of(context)
                                    ?.flashlightToolip,
                                icon: const Icon(Icons.flashlight_on_rounded)),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }

  _backAction() {
    if (BaseStaticState.prevScanQRScreen == Screen.home) {
      Navigator.of(context).push(_createHomeRoute());
    } else if (BaseStaticState.prevScanQRScreen == Screen.addressBook) {
      WalletStaticState.addressBookOpenedFromQR = true;
      Navigator.of(context).push(_createAddressBookRoute());
    } else {
      Navigator.of(context).push(_createMakeTxRoute('', null));
    }
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea =
        MediaQuery.of(context).size.width < MediaQuery.of(context).size.height
            ? MediaQuery.of(context).size.width * 0.6
            : MediaQuery.of(context).size.height * 0.6;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return _prmActive
        ? QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            formatsAllowed: const [BarcodeFormat.qrcode],
            overlay: QrScannerOverlayShape(
                borderColor: Theme.of(context).colorScheme.primary,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: scanArea),
            onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
          )
        : const SizedBox(
            width: 5,
            height: 5,
          );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
      controller.resumeCamera();
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;

        var decodedString = result?.code;
        // check veil:<> address
        var target = '';
        if (decodedString?.contains(':') ?? false) {
          var dstr = decodedString!.split(':');
          if (dstr[0].toLowerCase() == 'veil') {
            target = dstr[1];
          } else {
            return;
          }
        } else {
          target = decodedString ?? '';
        }

        // check amounts
        var uri = Uri.parse(target);
        String? localAmount =
            uri.queryParameters['amount']; // TO-DO message, label?

        target = target.split('?')[0];
        if (target.endsWith('/')) {
          target = target.substring(0, target.length - 1);
        }

        // verify address
        if (!WalletHelper.verifyAddress(target)) {
          return;
        }

        String? formattedAmount;
        try {
          if (localAmount != null) {
            var amountNum = double.parse(localAmount.replaceAll(',', '.'));
            if (amountNum > 0 && amountNum.isFinite && !amountNum.isNaN) {
              formattedAmount = WalletHelper.formatAmount(amountNum);
            }
          }
        } catch (e) {}

        if (!_navBusy) {
          _navBusy = true;
          if (BaseStaticState.prevScanQRScreen == Screen.addressBook) {
            WalletStaticState.addressBookOpenedFromQR = true;
            WalletStaticState.tmpAddressBookAddress = target;
            Navigator.of(context).push(_createAddressBookRoute());
          } else {
            Navigator.of(context)
                .pushReplacement(_createMakeTxRoute(target, formattedAmount));
          }
        }
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    //log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      _prmActive = false;
      try {
        controller?.stopCamera();
      } catch (e) {}
      controller?.dispose();
      //WidgetsBinding.instance.scheduleFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(AppLocalizations.of(context)?.cameraNoPermissions ??
                stringNotFoundText)),
      );
      Navigator.of(context).pushReplacement(_createHomeRoute());
      //});
    }
  }

  @override
  void dispose() {
    try {
      controller?.stopCamera();
    } catch (e) {}
    controller?.dispose();
    super.dispose();
  }
}

Route _createAddressBookRoute() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
    return const AddressBook();
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

Route _createMakeTxRoute(String address, String? amount) {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
    return MakeTx(address: address, amount: amount);
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

Route _createHomeRoute() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
    return const Home();
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
