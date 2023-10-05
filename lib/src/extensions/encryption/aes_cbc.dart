// source: https://github.com/bcgit/pc-dart/blob/master/tutorials/examples/aes-cbc-direct.dart
/// Encrypt and decrypt using AES

/// Note: this example use Pointy Castle WITH the registry.

import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:pointycastle/pointycastle.dart';
import 'package:pointycastle/random/fortuna_random.dart';

// Code convention: variable names starting with underscores are examples only,
// and should be implemented according to the needs of the program.

//----------------------------------------------------------------

Uint8List aesCbcEncrypt(
    Uint8List key, Uint8List iv, Uint8List paddedPlaintext) {
  if (![128, 192, 256].contains(key.length * 8)) {
    throw ArgumentError.value(key, 'key', 'invalid key length for AES');
  }
  if (iv.length * 8 != 128) {
    throw ArgumentError.value(iv, 'iv', 'invalid IV length for AES');
  }
  if (paddedPlaintext.length * 8 % 128 != 0) {
    throw ArgumentError.value(
        paddedPlaintext, 'paddedPlaintext', 'invalid length for AES');
  }

  // Create a CBC block cipher with AES, and initialize with key and IV

  final cbc = BlockCipher('AES/CBC')
    ..init(true, ParametersWithIV(KeyParameter(key), iv)); // true=encrypt

  // Encrypt the plaintext block-by-block

  final cipherText = Uint8List(paddedPlaintext.length); // allocate space

  var offset = 0;
  while (offset < paddedPlaintext.length) {
    offset += cbc.processBlock(paddedPlaintext, offset, cipherText, offset);
  }
  assert(offset == paddedPlaintext.length);

  return cipherText;
}

//----------------------------------------------------------------

Uint8List aesCbcDecrypt(Uint8List key, Uint8List iv, Uint8List cipherText) {
  if (![128, 192, 256].contains(key.length * 8)) {
    throw ArgumentError.value(key, 'key', 'invalid key length for AES');
  }
  if (iv.length * 8 != 128) {
    throw ArgumentError.value(iv, 'iv', 'invalid IV length for AES');
  }
  if (cipherText.length * 8 % 128 != 0) {
    throw ArgumentError.value(
        cipherText, 'cipherText', 'invalid length for AES');
  }

  // Create a CBC block cipher with AES, and initialize with key and IV

  final cbc = BlockCipher('AES/CBC')
    ..init(false, ParametersWithIV(KeyParameter(key), iv)); // false=decrypt

  // Decrypt the cipherText block-by-block

  final paddedPlainText = Uint8List(cipherText.length); // allocate space

  var offset = 0;
  while (offset < cipherText.length) {
    offset += cbc.processBlock(cipherText, offset, paddedPlainText, offset);
  }
  assert(offset == cipherText.length);

  return paddedPlainText;
}

//================================================================
// Supporting functions
//
// These are not a part of AES, so different standards may do these
// things differently.

//----------------------------------------------------------------
/// Represent bytes in hexadecimal
///
/// If a [separator] is provided, it is placed the hexadecimal characters
/// representing each byte. Otherwise, all the hexadecimal characters are
/// simply concatenated together.

String bin2hex(Uint8List bytes, {String? separator, int? wrap}) {
  var len = 0;
  final buf = StringBuffer();
  for (final b in bytes) {
    final s = b.toRadixString(16);
    if (buf.isNotEmpty && separator != null) {
      buf.write(separator);
      len += separator.length;
    }

    if (wrap != null && wrap < len + 2) {
      buf.write('\n');
      len = 0;
    }

    buf.write('${(s.length == 1) ? '0' : ''}$s');
    len += 2;
  }
  return buf.toString();
}

//----------------------------------------------------------------
// Decode a hexadecimal string into a sequence of bytes.

Uint8List hex2bin(String hexStr) {
  if (hexStr.length % 2 != 0) {
    throw const FormatException('not an even number of hexadecimal characters');
  }
  final result = Uint8List(hexStr.length ~/ 2);
  for (var i = 0; i < result.length; i++) {
    result[i] = int.parse(hexStr.substring(2 * i, 2 * (i + 1)), radix: 16);
  }
  return result;
}

//----------------------------------------------------------------
/// Added padding

Uint8List pad(Uint8List bytes, int blockSizeBytes) {
  // The PKCS #7 padding just fills the extra bytes with the same value.
  // That value is the number of bytes of padding there is.
  //
  // For example, something that requires 3 bytes of padding with append
  // [0x03, 0x03, 0x03] to the bytes. If the bytes is already a multiple of the
  // block size, a full block of padding is added.

  final padLength = blockSizeBytes - (bytes.length % blockSizeBytes);

  final padded = Uint8List(bytes.length + padLength)..setAll(0, bytes);
  Padding('PKCS7').addPadding(padded, bytes.length);

  return padded;
}

//----------------------------------------------------------------
/// Remove padding

Uint8List unpad(Uint8List padded) =>
    padded.sublist(0, padded.length - Padding('PKCS7').padCount(padded));

//----------------------------------------------------------------
/// Derive a key from a passphrase.
///
/// The [passPhrase] is an arbitrary length secret string.
///
/// The [bitLength] is the length of key produced. It determines whether
/// AES-128, AES-192, or AES-256 will be used. It must be one of those values.

Uint8List passphraseToKey(String passPhrase,
    {String salt = '', int iterations = 30000, required int bitLength}) {
  if (![128, 192, 256].contains(bitLength)) {
    throw ArgumentError.value(bitLength, 'bitLength', 'invalid for AES');
  }
  final numBytes = bitLength ~/ 8;

  final kd = KeyDerivator('SHA-256/HMAC/PBKDF2')
    ..init(
        Pbkdf2Parameters(utf8.encode(salt) as Uint8List, iterations, numBytes));

  return kd.process(utf8.encode(passPhrase) as Uint8List);
}

//----------------------------------------------------------------
/// Generate random bytes to use as the Initialization Vector (IV).

Uint8List? generateRandomBytes(int numBytes) {
  if (_secureRandom == null) {
    // First invocation: create _secureRandom and seed it

    _secureRandom = FortunaRandom();
    // TO-DO better seed generation
    //_secureRandom!.seed(
    //    KeyParameter(Platform.instance.platformEntropySource().getBytes(32)));
    _secureRandom!.seed(KeyParameter(
        Uint8List.fromList(List.generate(32, (_) => _sGen.nextInt(255)))));
  }

  // Use it to generate the random bytes

  final iv = _secureRandom!.nextBytes(numBytes);
  return iv;
}

FortunaRandom? _secureRandom;
var _sGen = Random.secure();
