// ignore_for_file: use_build_context_synchronously

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:veil_light_plugin/veil_light.dart';
import 'package:veil_wallet/src/core/constants.dart';
import 'package:veil_wallet/src/states/provider/wallet_state.dart';
import 'package:veil_wallet/src/states/static/wallet_static_state.dart';
import 'package:veil_wallet/src/storage/storage_item.dart';
import 'package:veil_wallet/src/storage/storage_service.dart';

var rng = Random();

class WalletHelper {
  static Future<int> createOrImportWallet(
      String walletName,
      List<String> mnemonic,
      String encryptionPassword,
      bool setActive,
      BuildContext context) async {
    var storageService = StorageService();
    var wallets =
        (await storageService.readSecureData(prefsWalletsStorage) ?? '')
            .split(',');
    List<String> reconstructedWallets = List.empty(growable: true);
    reconstructedWallets.addAll(wallets);
    // 1. save wallet id
    int rndWalletId = 0;
    while (true) {
      rndWalletId = rng.nextInt(2147483648);
      if (wallets.contains(rndWalletId.toString())) {
        continue;
      }

      reconstructedWallets.add(rndWalletId.toString());
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
      await setActiveWallet(rndWalletId, context);
    }

    return rndWalletId;
  }

  static Future setActiveWallet(int activeWallet, BuildContext context,
      {bool shouldSetActiveAddress = true}) async {
    var storageService = StorageService();
    await storageService.writeSecureData(
        StorageItem(prefsActiveWallet, activeWallet.toString()));
    WalletStaticState.activeWallet = activeWallet;

    //await storageService.deleteAllSecureData();

    context
        .read<WalletState>()
        .setSelectedWallet(WalletStaticState.activeWallet);

    if (shouldSetActiveAddress) {
      await storageService
          .writeSecureData(StorageItem(prefsActiveAddress, '0'));
    }
    await selectAddress(context);
  }

  static Future selectAddress(BuildContext context) async {
    var storageService = StorageService();
    var selectedAddressIndex = int.parse(
        await storageService.readSecureData(prefsActiveAddress) ??
            '0'); // 0 - stealth, 1 - change

    var mnemonic = await storageService.readSecureData(
        prefsWalletMnemonics + WalletStaticState.activeWallet.toString());
    var encPassword = await storageService.readSecureData(
        prefsWalletEncryption + WalletStaticState.activeWallet.toString());

    if (mnemonic == null || encPassword == null) {
      throw Exception('Mnemonic or password is missing');
    }

    WalletStaticState.lightwallet = Lightwallet.fromMnemonic(
        mainNetParams, mnemonic.split(' '),
        password: encPassword);

    WalletStaticState.account =
        LightwalletAccount(WalletStaticState.lightwallet!);

    List<OwnedAddress> addresses = List.empty(growable: true);
    // for now only stealth and change addresses
    addresses.add(OwnedAddress(
        AccountType.STEALTH,
        WalletStaticState.account!
            .getAddress(AccountType.STEALTH)
            .getStringAddress()));
    addresses.add(OwnedAddress(
        AccountType.CHANGE,
        WalletStaticState.account!
            .getAddress(AccountType.CHANGE)
            .getStringAddress()));

    context.read<WalletState>().setOwnedAddresses(addresses);

    await setSelectedAddress(addresses[selectedAddressIndex].address, context);
  }

  static Future setSelectedAddress(String address, BuildContext context) async {
    var storageService = StorageService();
    var walEntry = context
        .read<WalletState>()
        .ownedAddresses
        .firstWhere((element) => element.address == address);

    context.read<WalletState>().setSelectedAddress(walEntry.address);

    var activeAddressConvertedType = 0;
    if (walEntry.accountType == AccountType.CHANGE) {
      activeAddressConvertedType = 1;
    }

    await storageService.writeSecureData(
        StorageItem(prefsActiveAddress, activeAddressConvertedType.toString()));
  }

  static Future prepareHomePage(BuildContext context) async {
    var storageService = StorageService();
    var wallets =
        (await storageService.readSecureData(prefsWalletsStorage) ?? '')
            .split(',');
    var activeWallet =
        (await storageService.readSecureData(prefsActiveWallet) ?? '');

    if (activeWallet == '') {
      throw Exception('active wallet not yet set!');
    }

    if (!wallets.contains(activeWallet)) {
      throw Exception('wallet doesnt exists!');
    }

    var activeWal = int.parse(activeWallet);
    List<WalletEntry> walletObjs = List.empty(growable: true);

    for (var walletId in wallets) {
      if (walletId == '') {
        continue;
      }

      var name =
          await storageService.readSecureData(prefsWalletNames + walletId);
      walletObjs
          .add(WalletEntry(name ?? defaultWalletName, int.parse(walletId)));
    }
    WalletStaticState.wallets = walletObjs;

    await setActiveWallet(activeWal, context, shouldSetActiveAddress: false);
  }
}
