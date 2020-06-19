import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:items_repository/items_repository.dart';
import 'package:passline/pages/item/bloc/item_bloc.dart';

class AddPage extends StatelessWidget {
  final String name;

  const AddPage({Key key, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add item"),
      ),
      body: BlocProvider<ItemBloc>(
        create: (context) {
          return ItemBloc(
            itemsRepository: FirebaseItemsRepository(),
          );
        },
        child: Container(),
      ),
    );
  }
}
