import 'package:veil_wallet/src/core/constants.dart';
import 'package:veil_wallet/src/core/screen.dart';

class BaseStaticState {
  static List<String> newWalletWords = [];
  static Screen prevScreen = Screen.welcome;
  static Screen prevWalAdvancedScreen = Screen.importSeed;
  static bool useHomeBack = false;
  static bool biometricsActive = false;

  // advanced wallet settings
  static List<String> walletMnemonic = [];
  static String walletEncryptionPassword = '';
  static String tempWalletName = '';

  // settings
  static String nodeAddress = defaultNodeAddress;
  static String nodeAuth = '';
  static String explorerAddress = defaultExplorerAddress;
  static String txExplorerAddress = defaultTxExplorerAddress;
  static bool useMinimumUTXOs = false;
}
