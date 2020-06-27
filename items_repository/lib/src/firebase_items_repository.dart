import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:items_repository/items_repository.dart';
import 'entities/entities.dart';

class FirebaseItemsRepository implements ItemsRepository {
  final itemCollection = Firestore.instance.collection('passline');

  Future<void> addItem(Item item) async {
    var snapshot = await itemCollection.document(item.name).get();
    if (snapshot.exists) {
      var existingItem = Item.fromEntity(ItemEntity.fromSnapshot(snapshot));
      existingItem.credentials.add(item.credentials[0]);
      return itemCollection
          .document(item.name)
          .setData(existingItem.toEntity().toDocument());
    } else {
      return itemCollection
          .document(item.name)
          .setData(item.toEntity().toDocument());
    }
  }

  @override
  Stream<List<Item>> items() {
    return itemCollection.snapshots().map((snapshot) {
      return snapshot.documents
          .map((doc) => Item.fromEntity(ItemEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  @override
  Stream<Item> item(String name) {
    return itemCollection.document(name).snapshots().map((snapshot) {
      return Item.fromEntity(ItemEntity.fromSnapshot(snapshot));
    });
  }
}
