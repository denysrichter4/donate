import 'dart:convert';

import 'package:cryptography/cryptography.dart';

class Crypto{
  static final algorithm = AesCtr.with128bits(macAlgorithm: Hmac.sha256());
  static var secretKey = SecretKey(utf8.encode('D0n4t3D0n4t3D0n4'));
  static SecretBox secretBox = SecretBox([0], nonce: [0], mac: Mac([0]));

  static Future<String> decrypt(String pass) async {
    final message = _fromHex(pass);
    secretBox = SecretBox.fromConcatenation(message, nonceLength: 16, macLength: 32);
    final clearText = await algorithm.decrypt(
      secretBox,
      secretKey: secretKey,
    );
    return utf8.decode(clearText);
  }

  static Future<String> encrypt(String pass) async {
    final message = utf8.encode(pass);
    final encrypted = await algorithm.encrypt(message, secretKey: secretKey);
    secretBox = encrypted;
    return _toHex(encrypted.concatenation());
  }

  static List<int> _fromHex(String s) {
    s = s.replaceAll(' ', '').replaceAll('\n', '');
    return List<int>.generate(s.length ~/ 2, (i) {
      var byteInHex = s.substring(2 * i, 2 * i + 2);
      if (byteInHex.startsWith('0')) {
        byteInHex = byteInHex.substring(1);
      }
      final result = int.tryParse(byteInHex, radix: 16);
      if (result == null) {
        throw StateError('Not valid hexadecimal bytes: $s');
      }
      return result;
    });
  }

  static String _toHex(List<int> bytes) {
    return bytes.map((e) => e.toRadixString(16).padLeft(2, '0')).join('');
  }
}