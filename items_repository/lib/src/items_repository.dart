// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';

import 'package:items_repository/items_repository.dart';

abstract class ItemsRepository {
  Stream<List<Item>> items();

  Stream<Item> item(String name);
}

