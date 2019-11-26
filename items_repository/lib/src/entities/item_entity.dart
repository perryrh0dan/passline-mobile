// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ItemEntity extends Equatable {
  final String name;

  const ItemEntity(this.name);

  Map<String, Object> toJson() {
    return {
      "name": name
    };
  }

  @override
  List<Object> get props => [name];

  @override
  String toString() {
    return 'ItemEntity { name: $name}';
  }

  static ItemEntity fromJson(Map<String, Object> json) {
    return ItemEntity(
      json["name"] as String
    );
  }

  static ItemEntity fromSnapshot(DocumentSnapshot snap) {
    return ItemEntity(
      snap.data['name']
    );
  }

  Map<String, Object> toDocument() {
    return {
      "name": name
    };
  }
}
