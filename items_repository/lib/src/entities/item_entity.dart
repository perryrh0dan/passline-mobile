// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:items_repository/src/entities/entities.dart';

class ItemEntity extends Equatable {
  final String name;
  final List<CredentialEntity> credentials;

  const ItemEntity(this.name, this.credentials);

  Map<String, Object> toJson() {
    return {"name": name, "credentials": credentials};
  }

  @override
  List<Object> get props => [name, credentials];

  @override
  String toString() {
    return 'ItemEntity { name: $name, credentials: $credentials}';
  }

  static ItemEntity fromJson(Map<String, Object> json) {
    return ItemEntity(
        json["name"] as String, json["credentials"] as List<CredentialEntity>);
  }

  static ItemEntity fromSnapshot(DocumentSnapshot snap) {
    List<dynamic> list = snap.data['Credentials'];
    List<CredentialEntity> credentials = new List<CredentialEntity>();
    for (var i = 0; i < list.length; i++) {
      Map<dynamic, dynamic> map = list[i];
      CredentialEntity credential = CredentialEntity.fromJson(map);
      credentials.add(credential);
    }

    return ItemEntity(snap.data['Name'], credentials);
  }

  Map<String, Object> toDocument() {
    return {"name": name, "credentials": credentials};
  }
}
