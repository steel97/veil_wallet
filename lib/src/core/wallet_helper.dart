import 'dart:math';
import 'package:veil_wallet/src/core/constants.dart';
import 'package:veil_wallet/src/storage/storage_item.dart';
import 'package:veil_wallet/src/storage/storage_service.dart';

var rng = Random();

class WalletHelper {
  static Future<int> createOrImportWallet(String walletName,
      List<String> mnemonic, String encryptionPassword, bool setActive) async {
    var storageService = StorageService();
    var wallets =
        (await storageService.readSecureData(prefsWalletsStorage) ?? '')
            .split(',');
    var reconstructedWallets = List.empty(growable: true);
    reconstructedWallets.addAll(wallets);
    // 1. save wallet id
    int rndWalletId = 0;
    while (true) {
      rndWalletId = rng.nextInt(2147483648);
      if (wallets.contains(rndWalletId.toString())) {
        continue;
      }

      reconstructedWallets.add(rndWalletId);
      await storageService.writeSecureData(
          StorageItem(prefsWalletsStorage, reconstructedWallets.join(',')));
      break;
    }

    // 2. save wallet name
    await storageService.writeSecureData(
        StorageItem(prefsWalletNames + rndWalletId.toString(), walletName));

    // 3. save mnemonic
    await storageService.writeSecureData(StorageItem(
        prefsWalletMnemonics + rndWalletId.toString(), mnemonic.join(' ')));

    // 4. save encryption password
    await storageService.writeSecureData(StorageItem(
        prefsWalletEncryption + rndWalletId.toString(), encryptionPassword));

    // 5. set active if required
    if (setActive) {
      await storageService.writeSecureData(
          StorageItem(prefsActiveWallet, rndWalletId.toString()));
    }

    return rndWalletId;
  }
}
