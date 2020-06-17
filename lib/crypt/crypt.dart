import 'dart:convert';

import 'package:crypto/crypto.dart' as cry;
import 'package:cryptography/cryptography.dart';
import 'package:password_hash/password_hash.dart';

class Crypt {
  static List<int> getKey(String password) {
    var generator = new PBKDF2(hashAlgorithm: cry.sha1);
    var hash = generator.generateKey(password, "This is the salt", 4096, 32);

    return hash;
  }

  static Future<List<int>> aesGCMDecrypt(
      List<int> encryptionKey, String text) async {
    final cipher = AesGcm();

    final secretKey = SecretKey(encryptionKey);
    final t2 = base64.decode(text);
    final nonce = Nonce(t2.sublist(0, 12));
    final cipherText = t2.sublist(12);

    var decryptedText =
        await cipher.decrypt(cipherText, secretKey: secretKey, nonce: nonce);

    return decryptedText;
  }

  static Future<String> decryptCredentials(
      List<int> encryptionKey, String encryptedPassword) async {
    var decryptedPassword = await aesGCMDecrypt(encryptionKey, encryptedPassword);
    return String.fromCharCodes(decryptedPassword);
  }
}
