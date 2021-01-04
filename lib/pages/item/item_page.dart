import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:items_repository/items_repository.dart';
import 'package:passline_mobile/pages/credential/credentials.dart';

class ItemPage extends StatelessWidget {
  final Item item;

  const ItemPage({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(item.name),
        ),
        body: Credentials(item: item, credentials: item.credentials));
  }
}
