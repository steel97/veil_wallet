// ignore_for_file: use_build_context_synchronously, empty_catches
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:veil_light_plugin/veil_light.dart';
import 'package:veil_wallet/src/core/constants.dart';
import 'package:veil_wallet/src/core/transactions.dart';
import 'package:veil_wallet/src/extensions/encryption/aes_cbc.dart';
import 'package:veil_wallet/src/states/provider/wallet_state.dart';
import 'package:veil_wallet/src/states/states_bridge.dart';
import 'package:veil_wallet/src/states/static/base_static_state.dart';
import 'package:veil_wallet/src/states/static/wallet_static_state.dart';
import 'package:veil_wallet/src/storage/storage_item.dart';
import 'package:veil_wallet/src/storage/storage_service.dart';

var rng = Random();

class WalletHelper {
  static List<String> mempool = List.empty(growable: true);
  static List<LightwalletAddress> _addresses = List.empty(growable: true);

  static Future<void> uiReload() async {
    await uiUpdateBalance();
  }

  static AccountType uiGetActiveAddressType() {
    var addr = StatesBridge.navigatorKey.currentContext
        ?.read<WalletState>()
        .selectedAddress;
    var addrEl = StatesBridge.navigatorKey.currentContext
        ?.read<WalletState>()
        .ownedAddresses
        .firstWhere((element) => element.address == addr);

    return addrEl?.accountType ?? AccountType.DEFAULT;
  }

  static int uiGetActiveAddressIndex() {
    var addr = StatesBridge.navigatorKey.currentContext
        ?.read<WalletState>()
        .selectedAddress;
    var addrEl = StatesBridge.navigatorKey.currentContext
        ?.read<WalletState>()
        .ownedAddresses
        .firstWhere((element) => element.address == addr);

    return addrEl?.index ?? 1;
  }

  static Future<void> uiUpdateBalance() async {
    var index = uiGetActiveAddressIndex();
    var available = await getAvailableBalance(
        accountType: uiGetActiveAddressType(), index: index);
    //var locked = await getLockedBalance(accountType: uiGetActiveAddressType(), index: index);
    var pending = await getPendingBalance(
        accountType: uiGetActiveAddressType(), index: index);

    StatesBridge.navigatorKey.currentContext
        ?.read<WalletState>()
        .setBalance(available + pending);
  }

  static updateConversionRate(double convRate) {
    WalletStaticState.conversionRate = convRate;
    uiUpdateConversionRate(convRate);
  }

  static uiUpdateConversionRate(double convRate) {
    StatesBridge.navigatorKey.currentContext
        ?.read<WalletState>()
        .setConversionRate(convRate);
  }

  static Future<int> createOrImportWallet(
      String walletName,
      List<String> mnemonic,
      String encryptionPassword,
      bool setActive,
      BuildContext context,
      {String transactionsJSON = ''}) async {
    var storageService = StorageService();
    var wallets =
        (await storageService.readSecureData(prefsWalletsStorage) ?? '')
            .split(',');
    if (wallets[0] == '' && wallets.length == 1) {
      wallets = [];
    }

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

    // 5. generate and save tx encryption data
    // IV for both encrypt and decrypt (must ALWAYS be 128 bits for AES)
    var iv = generateRandomBytes(128 ~/ 8)!;
    var key = generateRandomBytes(256 ~/ 8)!; // 256 bit decrypt key

    final ivB64 = base64.encode(iv);
    final keyB64 = base64.encode(key);

    await storageService.writeSecureData(
        StorageItem(prefsWalletTxEncIV + rndWalletId.toString(), ivB64));
    await storageService.writeSecureData(
        StorageItem(prefsWalletTxEncKey + rndWalletId.toString(), keyB64));

    // 6. encrypt and save transactions.json if transactionsJSON != ''
    bool txesImported = false;

    // 7. set active if required
    if (setActive) {
      await setActiveWallet(rndWalletId, context,
          shouldSetInitialTxes: !txesImported);
    }

    return rndWalletId;
  }

  static Future<int?> deleteWallet(int walId, BuildContext context) async {
    var storageService = StorageService();
    var wallets =
        (await storageService.readSecureData(prefsWalletsStorage) ?? '')
            .split(',');
    if (wallets[0] == '' && wallets.length == 1) {
      wallets = [];
    }

    // 1. remove wallet id
    if (!wallets.remove(walId.toString())) {
      return null;
    }

    await storageService
        .writeSecureData(StorageItem(prefsWalletsStorage, wallets.join(',')));

    // 2. remove wallet name
    await storageService.deleteSecureData(prefsWalletNames + walId.toString());

    // 3. remove mnemonic
    await storageService
        .deleteSecureData(prefsWalletMnemonics + walId.toString());

    // 4. remove encryption password
    await storageService
        .deleteSecureData(prefsWalletEncryption + walId.toString());

    // 5. remove encryption keys for tx list
    await storageService
        .deleteSecureData(prefsWalletTxEncIV + walId.toString());
    await storageService
        .deleteSecureData(prefsWalletTxEncKey + walId.toString());

    // TO-DO delete transactions list if exists

    // 6. set active if exists
    int activeWal = -1;
    try {
      if (wallets.isNotEmpty) {
        activeWal = int.parse(wallets[0]);
        await storageService.writeSecureData(
            StorageItem(prefsActiveWallet, activeWal.toString()));
        await prepareHomePage(context);
      } else {
        storageService.deleteSecureData(prefsWalletsStorage);
      }
    } catch (e) {
      storageService.deleteSecureData(prefsWalletsStorage);
    }

    return activeWal;
  }

  static Future setActiveWallet(int activeWallet, BuildContext context,
      {bool shouldSetActiveAddress = true,
      shouldSetInitialTxes = false}) async {
    await reloadWalletsCache();

    var storageService = StorageService();
    await storageService.writeSecureData(
        StorageItem(prefsActiveWallet, activeWallet.toString()));
    WalletStaticState.walletWatching = false;
    WalletStaticState.activeWallet = activeWallet;

    //await storageService.deleteAllSecureData();

    context
        .read<WalletState>()
        .setSelectedWallet(WalletStaticState.activeWallet);

    if (shouldSetActiveAddress) {
      await storageService
          .writeSecureData(StorageItem(prefsActiveAddress, '0'));
    }

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

    // load all addresses
    var lastAddr = int.parse((await storageService.readSecureData(
            prefsWalletAddressIndex +
                WalletStaticState.activeWallet.toString()) ??
        '1'));
    _addresses = [
      WalletStaticState.account!.getAddress(AccountType.STEALTH),
      WalletStaticState.account!.getAddress(AccountType.CHANGE)
    ];

    for (var i = 2; i <= lastAddr; i++) {
      _addresses.add(
          WalletStaticState.account!.getAddress(AccountType.STEALTH, index: i));
    }

    await selectAddress(context);
    //await TransactionCache.loadData(WalletStaticState.activeWallet);

    WalletStaticState.walletWatching = true;

    for (var addr in WalletHelper.getAllAddresses()) {
      await reloadTxes(addr, shouldSetInitialTxes: shouldSetInitialTxes);
    }

    StatesBridge.navigatorKey.currentContext
        ?.read<WalletState>()
        .incrementTxRerender();
    await uiReload();
  }

  static Future selectAddress(BuildContext context) async {
    var storageService = StorageService();
    var selectedAddressIndex = int.parse(
        await storageService.readSecureData(prefsActiveAddress) ??
            '0'); // 0 - stealth, 1 - change, 2+ new stealth addrs

    List<OwnedAddress> retAddrList = List.empty(growable: true);
    for (LightwalletAddress element in _addresses) {
      retAddrList.add(OwnedAddress(element.getAccountType(),
          element.getStringAddress(), element.getIndex()));
    }

    context.read<WalletState>().setOwnedAddresses(retAddrList);
    if (retAddrList.length <= selectedAddressIndex) {
      selectedAddressIndex = 0;
    }

    await setSelectedAddress(
        retAddrList[selectedAddressIndex].address, context);
  }

  static Future setSelectedAddress(String address, BuildContext context,
      {shouldForceReload = true}) async {
    var curAddr = context.read<WalletState>().selectedAddress;
    if (curAddr == address) {
      return;
    }

    /*TransactionCache.currentTxList = [];
    StatesBridge.navigatorKey.currentContext
        ?.read<WalletState>()
        .incrementTxRerender();*/

    var storageService = StorageService();
    var walEntry = context
        .read<WalletState>()
        .ownedAddresses
        .firstWhere((element) => element.address == address);

    context.read<WalletState>().setSelectedAddress(walEntry.address);

    var addr = getAddress(walEntry.accountType, index: walEntry.index);
    if (shouldForceReload) {
      await reloadTxes(addr);
    } else {
      await TransactionCache.updateTxList(
          WalletStaticState.activeWallet, addr.getAllOutputs() ?? []);
    }

    var activeAddressConvertedType = 0;
    if (walEntry.accountType == AccountType.CHANGE) {
      activeAddressConvertedType = 1;
    }

    if (walEntry.index > 1 && walEntry.accountType == AccountType.STEALTH) {
      activeAddressConvertedType = walEntry.index;
    }

    checkScanningState(addr);
    await uiReload();

    await storageService.writeSecureData(
        StorageItem(prefsActiveAddress, activeAddressConvertedType.toString()));
  }

  static Future reloadWalletsCache() async {
    var storageService = StorageService();
    var wallets =
        (await storageService.readSecureData(prefsWalletsStorage) ?? '')
            .split(',');
    if (wallets[0] == '' && wallets.length == 1) {
      wallets = [];
    }

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
  }

  static Future prepareHomePage(BuildContext context) async {
    var storageService = StorageService();
    var wallets =
        (await storageService.readSecureData(prefsWalletsStorage) ?? '')
            .split(',');
    if (wallets[0] == '' && wallets.length == 1) {
      wallets = [];
    }

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

  static bool verifyAddress(String address) {
    try {
      CVeilAddress.parse(
          WalletStaticState.lightwallet?.chainParams ?? mainNetParams, address);
      return true;
    } catch (e) {
      return false;
    }
  }

  static LightwalletAddress getAddress(AccountType type, {index = 1}) =>
      _addresses.firstWhere((element) =>
          element.getAccountType() == type && element.getIndex() == index);

  static Future<double> getPendingBalance(
      {AccountType accountType = AccountType.STEALTH, int index = 1}) async {
    var address = getAddress(accountType, index: index);
    var balance = await address.getBalance(null);
    var balanceAvailable = await address.getBalance(mempool);
    return balance - balanceAvailable;
  }

  static Future<double> getLockedBalance(
      {AccountType accountType = AccountType.STEALTH, int index = 1}) async {
    var address = getAddress(accountType, index: index);
    return await address.getBalanceLocked();
  }

  static Future<double> getAvailableBalance(
      {AccountType accountType = AccountType.STEALTH, int index = 1}) async {
    var address = getAddress(accountType, index: index);
    var balance = await address.getBalance(mempool);
    return balance;
  }

  static String formatAmount(double amount) {
    //return WalletStaticState.account!.formatAmount(amount);
    return amount.toStringAsFixed(
        (WalletStaticState.lightwallet?.chainParams ?? mainNetParams)
            .COIN_DIGITS);
  }

  static double getFee() {
    var params = WalletStaticState.lightwallet?.chainParams ?? mainNetParams;
    return (params.CENT.toDouble() / params.COIN.toDouble());
  }

  static double toDisplayValue(double input) {
    var params = WalletStaticState.lightwallet?.chainParams ?? mainNetParams;
    return (input / params.COIN.toDouble());
  }

  static Future<BuildTransactionResult?> buildTransaction(
      AccountType accountType, int index, double amount, String recipient,
      {bool substractFee = false}) async {
    try {
      var params = WalletStaticState.lightwallet?.chainParams ?? mainNetParams;

      var address = getAddress(accountType, index: index);
      var recipientAddress = CVeilAddress.parse(params, recipient);

      var preparedUtxos = (await address.getUnspentOutputs())
          .where((utxo) => !WalletHelper.mempool.contains(utxo.getId() ?? ''))
          .toList();
      var utxos = preparedUtxos;
      utxos.sort((a, b) => a.getAmount(params).compareTo(b.getAmount(params)));

      List<CWatchOnlyTxWithIndex> targetUtxos = List.empty(growable: true);
      var fee = getFee(); // TO-DO, real fee calculation
      var amountPrepared = substractFee ? amount - fee : amount;
      var targetAmount = substractFee ? amountPrepared + fee : amountPrepared;

      double currentAmount = 0;
      for (var utxo in utxos) {
        currentAmount += utxo.getAmount(params);
        targetUtxos.add(utxo);
        if (currentAmount >= targetAmount) {
          break;
        }
      }

      var rawTx = await address.buildTransaction(
          [CVeilRecipient(recipientAddress!, amountPrepared)],
          targetUtxos,
          BaseStaticState.useMinimumUTXOs);

      return rawTx;
    } catch (e) {
      //print('can\'t build tx ${e}');
      return null;
    }
  }

  static List<LightwalletAddress> getAllAddresses() {
    return _addresses;
  }

  static Future<String?> publishTransaction(
      AccountType accountType, int index, String rawTx) async {
    try {
      var address = getAddress(accountType, index: index);
      var res = await Lightwallet.publishTransaction(rawTx);
      if (res.errorCode != null) {
        return null;
      }

      try {
        await reloadTxes(address);
      } catch (e1) {}

      await uiReload();

      /*TransactionCache.addSentTransaction(WalletStaticState.activeWallet,
          address.getStringAddress(), res.txid ?? '');*/
      return res.txid;
    } catch (e2) {
      return null;
    }
  }

  static reloadTxes(LightwalletAddress addr,
      {shouldSetInitialTxes = false}) async {
    var activeAddr = StatesBridge.navigatorKey.currentContext
        ?.read<WalletState>()
        .selectedAddress;

    var incrementUpdate = false;
    if (addr.getStringAddress() == activeAddr) {
      incrementUpdate = true;
    }
    // fetch txes
    await addr.fetchTxes();
    // fetch mempool
    var responseRes = await RpcRequester.send(
        RpcRequest(jsonrpc: '1.0', method: 'getrawmempool', params: []));
    var result = GetRawMempool.fromJson(responseRes);

    if (result.error == null) {
      WalletHelper.mempool = result.result ?? [];
    }

    /*if (shouldSetInitialTxes) {
      await TransactionCache.setInitialTxes(
          WalletStaticState.activeWallet, txes ?? []);
    } else {
      await TransactionCache.updateTxList(
          WalletStaticState.activeWallet, txes ?? []);
    }*/

    // TO-DO check latest scanned tx
    if (incrementUpdate) {
      checkScanningState(addr);
      await TransactionCache.updateTxList(
          WalletStaticState.activeWallet, addr.getAllOutputs() ?? []);
      // update current txes and save transactions.json

      StatesBridge.navigatorKey.currentContext
          ?.read<WalletState>()
          .incrementTxRerender();
    }
  }

  static String formatFiat(double coins, double conversionRate) {
    var oCcy = NumberFormat('#,##0.00', 'en_US');
    return oCcy.format(coins * conversionRate);
  }

  static void checkScanningState(LightwalletAddress addr) {
    //scanning, synced, failed
    if (addr.getSyncStatus() == 'scanning') {
      StatesBridge.navigatorKey.currentContext
          ?.read<WalletState>()
          .setSyncState(SyncState.scanning);
    } else if (addr.getSyncStatus() == 'synced') {
      StatesBridge.navigatorKey.currentContext
          ?.read<WalletState>()
          .setSyncState(SyncState.synced);
    } else if (addr.getSyncStatus() == 'failed') {
      StatesBridge.navigatorKey.currentContext
          ?.read<WalletState>()
          .setSyncState(SyncState.failed);
    }
  }
}
