import 'dart:convert';
import 'dart:typed_data';
import 'package:veil_light_plugin/veil_light.dart';
import 'package:veil_wallet/src/core/constants.dart';
import 'package:veil_wallet/src/extensions/encryption/aes_cbc.dart';
import 'package:veil_wallet/src/extensions/file_storage.dart';
import 'package:veil_wallet/src/states/static/wallet_static_state.dart';
import 'package:veil_wallet/src/storage/storage_service.dart';

enum TxType { unknown, received, sent }

class TransactionModel {
  final TxType type;
  final String txId;
  final String target; // used for send transactions
  final double amount;
  final int timestamp;

  TransactionModel(
      this.type, this.txId, this.target, this.amount, this.timestamp);
}

class TransactionCache {
  static List<TransactionModel> currentTxList = [];
  // below lines is TO-DO, currently not used
  static List<String> unknownTransactions = List.empty(growable: true);
  static List<String> sentTransactions = List.empty(growable: true);

  static TransactionModel lwTxToTx(CWatchOnlyTxWithIndex tx) {
    return TransactionModel(
        TxType.unknown,
        tx.getId() ?? '',
        '',
        tx.getAmount(
            WalletStaticState.lightwallet?.chainParams ?? mainNetParams),
        0);
  }

  // set initial transactions cache on wallet import and mark txes as unknown type
  static Future setInitialTxes(
      int walletId, List<CWatchOnlyTxWithIndex> txes) async {
    List<TransactionModel> txList = List.empty(growable: true);
    for (CWatchOnlyTxWithIndex tx in txes) {
      txList.add(lwTxToTx(tx));
      if (!sentTransactions.contains(tx.getId())) {
        unknownTransactions.add(tx.getId() ?? '');
      }
    }
    currentTxList = txList;
    // save json file to secure storage
    await saveData(walletId);
  }

  // updates transactions list with new values
  static Future updateTxList(
      int walletId, List<CWatchOnlyTxWithIndex> txes) async {
    List<TransactionModel> txList = List.empty(growable: true);
    for (CWatchOnlyTxWithIndex tx in txes) {
      txList.add(lwTxToTx(tx));
    }
    currentTxList = txList;
    // save json file to secure storage
    await saveData(walletId);
  }

  static Future addSentTransaction(
      int walletId, String fromAddress, String txId) async {
    sentTransactions.add("$fromAddress:$txId");
    // save json file to secure storage
    await saveData(walletId);
  }

  // serialization not currently used here
  static Future saveData(int walletId) async {
    /*
    {
      "unknownTransactions": [
        "<txid>"
      ],
      "sentTransactions": {
        "<txid>": {
          ... tx data
        }
      }
    }
    */

    var storageService = StorageService();
    var ivB64 = await storageService
        .readSecureData(prefsWalletTxEncIV + walletId.toString());
    var keyB64 = await storageService
        .readSecureData(prefsWalletTxEncKey + walletId.toString());

    var iv = base64.decode(ivB64 ?? '');
    var key = base64.decode(keyB64 ?? '');

    var model = {
      'unknownTransactions': unknownTransactions,
      'sentTransactions': sentTransactions
    };

    var jsonText = jsonEncode(model);
    final cipherText = aesCbcEncrypt(
        key, iv, pad(Uint8List.fromList(utf8.encode(jsonText)), 16));
    await writeTxCache(walletId, cipherText);
  }

  static Future loadData(int walletId) async {
    var cipherText = await readTxCache(walletId);
    if (cipherText == null) {
      return;
    }

    var storageService = StorageService();
    var ivB64 = await storageService
        .readSecureData(prefsWalletTxEncIV + walletId.toString());
    var keyB64 = await storageService
        .readSecureData(prefsWalletTxEncKey + walletId.toString());

    var iv = base64.decode(ivB64 ?? '');
    var key = base64.decode(keyB64 ?? '');

    final paddedDecryptedBytes = aesCbcDecrypt(key, iv, cipherText);
    final decryptedBytes = unpad(paddedDecryptedBytes);
    var jsonText =
        json.decode(utf8.decode(decryptedBytes)) as Map<String, dynamic>;

    unknownTransactions = List.empty(growable: true);
    for (dynamic val in (jsonText["unknownTransactions"] as List<dynamic>)) {
      unknownTransactions.add(val.toString());
    }

    sentTransactions = List.empty(growable: true);
    for (dynamic val in (jsonText["sentTransactions"] as List<dynamic>)) {
      sentTransactions.add(val.toString());
    }
  }
}
