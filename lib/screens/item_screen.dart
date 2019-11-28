import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passline/blocs/items/items_bloc.dart';
import 'package:passline/blocs/items/items_state.dart';
import 'package:passline/widgets/widgets.dart';

class ItemScreen extends StatelessWidget {
  final String name;

  const ItemScreen({Key key, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemsBloc, ItemsState>(
      builder: (context, state) {
        final item = (state as ItemsLoaded)
            .items
            .firstWhere((item) => item.name == name, orElse: () => null);
        return Scaffold(
          appBar: AppBar(
            title: Text(item.name), 
          ),
          body: Credentials(name: item.name),
        );
      },
    );
  }
}
