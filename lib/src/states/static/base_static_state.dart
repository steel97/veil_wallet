import 'package:veil_wallet/src/core/constants.dart';
import 'package:veil_wallet/src/core/screen.dart';

class BaseStaticState {
  static List<String> importWalletWords = [];
  static List<String> newWalletWords = [];
  static Screen prevScreen = Screen.welcome;
  static Screen prevWalAdvancedScreen = Screen.importSeed;
  static Screen prevScanQRScreen = Screen.home;
  static Screen prevNodeFailSceren = Screen.notset;
  static bool useHomeBack = false;
  static bool biometricsActive = false;
  static int biometricsTimestamp = 0;

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

  // wallet settings
  static int walSettingsId = -1;
  static String walSettingsName = '';
  static String walSettingsPassword = '';
}
