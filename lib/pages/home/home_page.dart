import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:items_repository/items_repository.dart';
import 'package:passline/authentication/authentication_bloc.dart';
import 'package:passline/pages/credential/credential_page.dart';
import 'package:passline/pages/home/bloc/items/items_bloc.dart';
import 'package:passline/pages/home/search.dart';
import 'package:passline/pages/item/item_page.dart';
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
                          CredentialPage(credential: item.credentials[0])));
                } else {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => ItemPage(name: item.name)));
                }
              },
            )
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text('Passline'),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              ListTile(
                title: Text('Logout'),
                onTap: () {
                  BlocProvider.of<AuthenticationBloc>(context)..add(AuthenticationLoggedOut());
                },
              ),
            ],
          ),
        ),
        body: Items(),
      ),
    );
  }
}
