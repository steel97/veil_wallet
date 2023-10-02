import 'package:flutter/foundation.dart';
import 'package:veil_light_plugin/veil_light.dart';

class OwnedAddress {
  final AccountType accountType;
  final String address;

  OwnedAddress(this.accountType, this.address);
}

class WalletState with ChangeNotifier, DiagnosticableTreeMixin {
  int _selectedWallet = -1;
  String _selectedAddress = '';
  List<OwnedAddress> _ownedAddresses = [];

  int get selectedWallet => _selectedWallet;
  String get selectedAddress => _selectedAddress;
  List<OwnedAddress> get ownedAddresses => _ownedAddresses;

  void setSelectedWallet(int wal) {
    _selectedWallet = wal;
    notifyListeners();
  }

  void setSelectedAddress(String addr) {
    _selectedAddress = addr;
    notifyListeners();
  }

  void setOwnedAddresses(List<OwnedAddress> addresses) {
    _ownedAddresses = addresses;
    notifyListeners();
  }

  /// Makes `Counter` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('selectedWallet', _selectedWallet));
  }
}
