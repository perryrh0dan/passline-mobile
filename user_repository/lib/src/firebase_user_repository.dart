import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:user_repository/user_repository.dart';

class FirebaseUserRepository implements UserRepository {
  final FirebaseAuth firebaseAuth;
  final FlutterSecureStorage storage;

  FirebaseUserRepository({FirebaseAuth firebaseAuth})
      : firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        this.storage = new FlutterSecureStorage();

  Future<bool> isAuthenticated() async {
    final currentUser = await firebaseAuth.currentUser();
    return currentUser != null;
  }

  Future<void> authenticate() {
    return firebaseAuth.signInAnonymously();
  }

  Future<void> deleteKey() async {
    /// delete from keystore/keychain
    await storage.delete(key: "encryptionKey");
    return;
  }

  Future<void> persistKey(List<int> encryptionKey) async {
    /// write to keystore/keychain
    var key = Base64Encoder().convert(encryptionKey);
    await storage.write(key: "encryptionKey", value: key);
    return;
  }

  Future<List<int>> getKey() async {
    var encryptionKey = await storage.read(key: "encryptionKey");
    if (encryptionKey == null) {
      return null;
    }
    return Base64Decoder().convert(encryptionKey);
  }

  Future<bool> hasKey() async {
    /// read from keystore/keychain
    var encryptionKey = await storage.read(key: "encryptionKey");
    if (encryptionKey != null) {
      return true;
    }
    return false;
  }
}
