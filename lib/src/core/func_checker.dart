import 'dart:io';
import 'package:local_auth/local_auth.dart';

var auth = LocalAuthentication();

Future<bool> checkBiometricsSupport()  async{
  if(Platform.isLinux || Platform.isFuchsia) {
    return false;
  }
  
  final bool canAuthenticateWithBiometrics =
    await auth.canCheckBiometrics;
  final bool canAuthenticate = canAuthenticateWithBiometrics ||
    await auth.isDeviceSupported();
  return canAuthenticate;
}