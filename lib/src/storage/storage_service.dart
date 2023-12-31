import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:veil_wallet/src/storage/storage_item.dart';

class StorageService {
  final _secureStorage = const FlutterSecureStorage(
      aOptions: AndroidOptions(
    encryptedSharedPreferences: true,
  ));

  Future<void> writeSecureData(StorageItem newItem) async {
    await _secureStorage.write(key: newItem.key, value: newItem.value);
  }

  Future<String?> readSecureData(String key) async {
    var readData = await _secureStorage.read(key: key);
    if(await _secureStorage.containsKey(key: key) && readData == null) {
      return '';
    }
    return readData;
  }

  Future<void> deleteSecureData(String key) async {
    await _secureStorage.delete(key: key);
  }

  Future<void> deleteAllSecureData() async {
    await _secureStorage.deleteAll();
  }
}
