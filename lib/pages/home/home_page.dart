import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:items_repository/items_repository.dart';
import 'package:passline/authentication/authentication_bloc.dart';
import 'package:passline/pages/add/add_page.dart';
import 'package:passline/pages/credential/credential_page.dart';
import 'package:passline/pages/home/bloc/items/items_bloc.dart';
import 'package:passline/pages/home/drawer.dart';
import 'package:passline/pages/home/items.dart';
import 'package:passline/pages/home/search.dart';
import 'package:passline/pages/item/item_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ItemsBloc>(
      create: (context) => ItemsBloc(
        itemsRepository: FirebaseItemsRepository(),
      )..add(LoadItems()),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Passline"),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () async {
                    var item = await showSearch(
                        context: context,
                        delegate: ItemSearch(
                            itemsBloc: BlocProvider.of<ItemsBloc>(context)));
                    if (item != null && item.credentials.length == 1) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) =>
                              CredentialPage(credential: item.credentials[0])));
                    } else if (item != null) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => ItemPage(name: item.name)));
                    }
                  },
                )
              ],
            ),
            drawer: HomeDrawer(),
            body: Items(),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => AddPage()));
              },
              child: Icon(Icons.add),
              tooltip: 'Add item',
            ),
          );
        },
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
    } else if (state == AppLifecycleState.inactive) {
    } else if (state == AppLifecycleState.paused) {
      context.bloc<AuthenticationBloc>().add(AuthenticationLocked());
      Navigator.popUntil(
          context, ModalRoute.withName(Navigator.defaultRouteName));
    } else if (state == AppLifecycleState.detached) {
      print("detached");
    }
  }
}
