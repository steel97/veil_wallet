import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> writeTxCache(int walId, Uint8List encryptedTxList) async {
  final path = await _localPath;
  final file = File('$path/$walId.veil');

  return file.writeAsBytes(encryptedTxList);
}

Future<Uint8List?> readTxCache(int walId) async {
  try {
    final path = await _localPath;
    final file = File('$path/$walId.veil');

    final contents = await file.readAsBytes();
    return contents;
  } catch (e) {
    // If encountering an error, return 0
    return null;
  }
}
