import 'package:flutter/foundation.dart';

class DialogsState with ChangeNotifier, DiagnosticableTreeMixin {
  bool _sendTxActive = false;
  bool _deleteWalletActive = false;

  bool get sendTxActive => _sendTxActive;
  bool get deleteWalletActive => _deleteWalletActive;

  void setSendTxActive(bool val) {
    _sendTxActive = val;
    notifyListeners();
  }

  void setDeleteWalletActive(bool val) {
    _deleteWalletActive = val;
    notifyListeners();
  }

  /// Makes `Counter` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(FlagProperty('sendTxActive', value: _sendTxActive));
    properties
        .add(FlagProperty('deleteWalletActive', value: _deleteWalletActive));
  }
}
