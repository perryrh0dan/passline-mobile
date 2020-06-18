import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:items_repository/items_repository.dart';
import 'package:passline/blocs/items/items.dart';
import 'package:passline/screens/credential_screen.dart';
import 'package:passline/screens/home/search.dart';
import 'package:passline/screens/item_screen.dart';
import 'package:passline/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final itemsBloc = ItemsBloc(
      itemsRepository: FirebaseItemsRepository(),
    )..add(LoadItems());

    return BlocProvider<ItemsBloc>(
      create: (context) => itemsBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Passline"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                var item = await showSearch(
                    context: context, delegate: ItemSearch(itemsBloc));
                if (item.credentials.length == 1) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) =>
                          CredentialScreen(credential: item.credentials[0])));
                } else {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => ItemScreen(name: item.name)));
                }
              },
            )
          ],
        ),
        drawer: Drawer(),
        body: Items(),
      ),
    );
  }
}
