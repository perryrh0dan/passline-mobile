import 'dart:convert';

import 'dart:math' as math;
import 'package:crypto/crypto.dart' as cry;
import 'package:cryptography/cryptography.dart';
import 'package:password_hash/password_hash.dart';

class Crypt {
  static List<int> passwordToKey(String password) {
    var generator = new PBKDF2(hashAlgorithm: cry.sha1);
    var hash = generator.generateKey(password, "This is the salt", 4096, 32);

    return hash;
  }

  static Future<List<int>> aesGCMDecrypt(
      List<int> encryptionKey, String text) async {
    final cipher = AesGcm();

    // create secret with the encryption key
    final secretKey = SecretKey(encryptionKey);

    // base64 decode the text
    final t2 = base64.decode(text);

    // create none of first 12 bytes
    final nonce = Nonce(t2.sublist(0, 12));

    // create ciphertext of the rest of bytes
    final cipherText = t2.sublist(12);

    // decrypt ciphertext
    var decryptedText =
        await cipher.decrypt(cipherText, secretKey: secretKey, nonce: nonce);

    return decryptedText;
  }

  static Future<String> aesGCMEncrypt(
      List<int> encryptionKey, String text) async {
    final cipher = AesGcm();

    // create the ciphertext
    var cipherText = utf8.encode(text);

    // create the secret with the encryption key
    final secretKey = SecretKey(encryptionKey);

    // create a random nonce
    math.Random rnd = new math.Random();
    List<int> values = new List<int>.generate(12, (i) => rnd.nextInt(256));
    final nonce = Nonce(values);

    // encrypt ciphertext
    var encryptedText =
        await cipher.encrypt(cipherText, secretKey: secretKey, nonce: nonce);

    // base64 encode encryptedText
    return base64.encode(encryptedText);
  }

  static Future<String> decryptCredentials(
      List<int> encryptionKey, String encryptedPassword) async {
    var decryptedPassword =
        await aesGCMDecrypt(encryptionKey, encryptedPassword);
    return String.fromCharCodes(decryptedPassword);
  }

  static Future<List<int>> decryptKey(
      List<int> password, String encryptedEncryptionKey) {
    return aesGCMDecrypt(password, encryptedEncryptionKey);
  }
}
