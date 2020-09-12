import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:user_repository/src/entities/entities.dart';
import 'package:user_repository/src/models/models.dart';
import 'package:user_repository/user_repository.dart';

class FirebaseUserRepository implements UserRepository {
  final FirebaseAuth firebaseAuth;
  final configCollection = Firestore.instance.collection('config');
  final FlutterSecureStorage storage = new FlutterSecureStorage();

  FirebaseUserRepository({FirebaseAuth firebaseAuth})
      : firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<bool> isAuthenticated() async {
    final currentUser = await firebaseAuth.currentUser();
    return currentUser != null;
  }

  Future<bool> authenticate(String password) async {
    await firebaseAuth.signInAnonymously();
    try {
      var hash = await this.storage.read(key: "password");
      if (hash == password) {
        return true;
      } else {
        return false;
      } 
    } catch (e) {
      return false;
    }
  }

  Future<void> authenticateWithoutPW() async {
    return firebaseAuth.signInAnonymously();
  }

  Future<bool> isRegistered() async {
    try {
      if (await this.storage.read(key: "password") != null) {
        return true;
      } else {
        return false;
      } 
    } catch (e) {
      return false;
    }
  }

  Future<void> register(String password) async {
    await storage.write(key: "password", value: password);
    return this.authenticateWithoutPW();
  }

  Future<String> loadKey() async {
    /// Load encrypted encryption key from firestore
    var config = await configCollection.document('config').get();
    return Config.fromEntity(ConfigEntity.fromSnapshot(config)).key;
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
    try {
      var encryptionKey = await storage.read(key: "encryptionKey");
      if (encryptionKey == null) {
        return null;
      }
      return Base64Decoder().convert(encryptionKey);
    } catch (e) {
      return null;
    }
  }

  Future<bool> hasKey() async {
    /// read from keystore/keychain
    try {
      var encryptionKey = await storage.read(key: "encryptionKey"); 
      if (encryptionKey != null) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
