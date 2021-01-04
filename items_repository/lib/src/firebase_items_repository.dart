import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:items_repository/items_repository.dart';
import 'entities/entities.dart';

class FirebaseItemsRepository implements ItemsRepository {
  final itemCollection = FirebaseFirestore.instance.collection('passline');

  Future<void> addItem(Item item) async {
    var snapshot = await itemCollection.doc(item.name).get();
    if (snapshot.exists) {
      var existingItem = Item.fromEntity(ItemEntity.fromSnapshot(snapshot));
      existingItem.credentials.add(item.credentials[0]);
      return itemCollection
          .doc(item.name)
          .set(existingItem.toEntity().toDocument());
    } else {
      return itemCollection.doc(item.name).set(item.toEntity().toDocument());
    }
  }

  @override
  Stream<List<Item>> items() {
    return itemCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Item.fromEntity(ItemEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  @override
  Stream<Item> item(String name) {
    return itemCollection.doc(name).snapshots().map((snapshot) {
      return Item.fromEntity(ItemEntity.fromSnapshot(snapshot));
    });
  }
}
