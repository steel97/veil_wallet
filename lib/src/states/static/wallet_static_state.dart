import 'package:veil_light_plugin/veil_light.dart';

class WalletEntry {
  final String name;
  final int id;

  WalletEntry(this.name, this.id);
}

class WalletStaticState {
  static List<WalletEntry>? wallets;
  static int activeWallet = -1;
  static Lightwallet? lightwallet;
  static LightwalletAccount? account;
}
