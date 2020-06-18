import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:config_repository/config_repository.dart';
import 'entities/entities.dart';

class FirebaseConfigRepository extends ConfigRepository {
  final configCollection = Firestore.instance.collection('config');

  Future<String> key() async {
    var config = await configCollection.document('config').get();
    return Config.fromEntity(ConfigEntity.fromSnapshot(config)).key;
  }
}