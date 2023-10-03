// ignore_for_file: use_build_context_synchronously, empty_catches
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:veil_light_plugin/veil_light.dart';
import 'package:veil_wallet/src/core/constants.dart';
import 'package:veil_wallet/src/states/provider/wallet_state.dart';
import 'package:veil_wallet/src/states/states_bridge.dart';
import 'package:veil_wallet/src/states/static/base_static_state.dart';
import 'package:veil_wallet/src/states/static/wallet_static_state.dart';
import 'package:veil_wallet/src/storage/storage_item.dart';
import 'package:veil_wallet/src/storage/storage_service.dart';

var rng = Random();

class WalletHelper {
  static List<String> mempool = List.empty(growable: true);
  static List<LightwalletAddress> _addresses = [];

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

  static Future<void> uiUpdateBalance() async {
    var available =
        await getAvailableBalance(accountType: uiGetActiveAddressType());
    //var locked = await getLockedBalance(accountType: uiGetActiveAddressType());
    var pending =
        await getPendingBalance(accountType: uiGetActiveAddressType());

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
    _addresses = [
      WalletStaticState.account!.getAddress(AccountType.STEALTH),
      WalletStaticState.account!.getAddress(AccountType.CHANGE)
    ];

    await selectAddress(context);

    WalletStaticState.walletWatching = true;
    for (var addr in WalletHelper.getAllAddresses()) {
      await reloadTxes(addr);
    }

    await uiReload();
  }

  static Future selectAddress(BuildContext context) async {
    var storageService = StorageService();
    var selectedAddressIndex = int.parse(
        await storageService.readSecureData(prefsActiveAddress) ??
            '0'); // 0 - stealth, 1 - change

    List<OwnedAddress> retAddrList = List.empty(growable: true);
    for (LightwalletAddress element in _addresses) {
      retAddrList.add(
          OwnedAddress(element.getAccountType(), element.getStringAddress()));
    }

    context.read<WalletState>().setOwnedAddresses(retAddrList);

    await setSelectedAddress(
        retAddrList[selectedAddressIndex].address, context);
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

    await uiReload();
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

  static bool verifyAddress(String address) {
    try {
      CVeilAddress.parse(
          WalletStaticState.lightwallet?.chainParams ?? mainNetParams, address);
      return true;
    } catch (e) {
      return false;
    }
  }

  static LightwalletAddress getAddress(AccountType type) =>
      _addresses.firstWhere((element) => element.getAccountType() == type);

  static Future<double> getPendingBalance(
      {AccountType accountType = AccountType.STEALTH}) async {
    var address = getAddress(accountType);
    var balance = await address.getBalance(null);
    var balanceAvailable = await address.getBalance(mempool);
    return balance - balanceAvailable;
  }

  static Future<double> getLockedBalance(
      {AccountType accountType = AccountType.STEALTH}) async {
    var address = getAddress(accountType);
    return await address.getBalanceLocked();
  }

  static Future<double> getAvailableBalance(
      {AccountType accountType = AccountType.STEALTH}) async {
    var address = getAddress(accountType);
    var balance = await address.getBalance(mempool);
    return balance;
  }

  static String formatAmount(double amount) {
    return WalletStaticState.account!.formatAmount(amount);
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
      AccountType accountType, double amount, String recipient,
      {bool substractFee = false}) async {
    try {
      var params = WalletStaticState.lightwallet?.chainParams ?? mainNetParams;

      var address = getAddress(accountType);
      var recipientAddress = CVeilAddress.parse(params, recipient);

      var preparedUtxos = (await address.getUnspentOutputs())
          .where((utxo) => !WalletHelper.mempool.contains(utxo.getId() ?? ""))
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
      AccountType accountType, String rawTx) async {
    try {
      var address = getAddress(accountType);
      var res = await Lightwallet.publishTransaction(rawTx);
      if (res.errorCode != null) {
        return null;
      }

      try {
        await reloadTxes(address);
      } catch (e1) {}

      await uiReload();

      return res.txid;
    } catch (e2) {
      return null;
    }
  }

  static reloadTxes(LightwalletAddress addr) async {
    // fetch txes
    await addr.fetchTxes();
    // fetch mempool
    var responseRes = await RpcRequester.send(
        RpcRequest(jsonrpc: "1.0", method: "getrawmempool", params: []));
    var result = GetRawMempool.fromJson(responseRes);

    if (result.error == null) {
      WalletHelper.mempool = result.result ?? [];
    }
  }

  static String formatFiat(double coins, double conversionRate) {
    var oCcy = NumberFormat("#,##0.00", "en_US");
    return oCcy.format(coins * conversionRate);
  }
}
