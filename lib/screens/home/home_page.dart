import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:items_repository/items_repository.dart';
import 'package:passline/blocs/items/items.dart';
import 'package:passline/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Passline"),
      ),
      body: BlocProvider(
        create: (context) {
          return ItemsBloc(
            itemsRepository: FirebaseItemsRepository(),
          )..add(LoadItems());
        },
        child: Items(),
      ),
    );
  }
}
