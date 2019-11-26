import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:items_repository/items_repository.dart';

class ItemWidget extends StatelessWidget {
  final Item item;

  ItemWidget({
    Key key,
    @required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('__item_item_${item.name}'),
      child: ListTile(
        title: Hero(
          tag: '${item.name}__heroTag',
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Text(
              item.name,
              style: Theme.of(context).textTheme.title,
            ),
          ),
        ),
      ),
    );
  }
}
