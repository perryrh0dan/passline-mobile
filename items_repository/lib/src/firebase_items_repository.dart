import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:items_repository/items_repository.dart';
import 'entities/entities.dart';

class FirebaseItemsRepository implements ItemsRepository {
  final itemCollection = Firestore.instance.collection('passline');

  @override
  Stream<List<Item>> items() {
    return itemCollection.snapshots().map((snapshot) {
      return snapshot.documents
          .map((doc) => Item.fromEntity(ItemEntity.fromSnapshot(doc)))
          .toList();
    });
  }
}
