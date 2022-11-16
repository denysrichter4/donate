import 'dart:convert';

import 'package:crypto/crypto.dart';

class Crypto{
  static var secretKey = utf8.encode('D0n4t3D0n4t3D0n4');

  static String encrypt(String pass){
    var bytes = utf8.encode(pass);
    var hmacSha256 = Hmac(sha256, secretKey); // HMAC-SHA256
    var digest = hmacSha256.convert(bytes);
    return digest.toString();
  }
}