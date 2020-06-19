import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:items_repository/items_repository.dart';
import 'package:passline/pages/item/bloc/item_bloc.dart';
import 'package:passline/widgets/widgets.dart';

class ItemPage extends StatelessWidget {
  final String name;

  const ItemPage({Key key, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: BlocProvider<ItemBloc>(
        create: (context) {
          return ItemBloc(
            itemsRepository: FirebaseItemsRepository(),
          )..add(LoadItem(name));
        },
        child: Credentials(name: name),
      ),
    );
  }
}