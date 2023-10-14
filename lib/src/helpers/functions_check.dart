import 'dart:io';

bool checkScanQROS() {
  return Platform.isIOS || Platform.isAndroid;
}
