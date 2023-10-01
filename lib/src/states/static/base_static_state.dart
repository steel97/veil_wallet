import 'package:veil_wallet/src/core/constants.dart';
import 'package:veil_wallet/src/core/screen.dart';

class BaseStaticState {
  static List<String> newWalletWords = [];
  static Screen prevScreen = Screen.welcome;

  // advanced wallet settings
  static String walletEncryptionPassword = '';

  // settings
  static String nodeAddress = defaultNodeAddress;
  static String nodeAuth = '';
  static String explorerAddress = defaultExplorerAddress;
  static String txExplorerAddress = defaultTxExplorerAddress;
  static bool useMinimumUTXOs = false;
}
