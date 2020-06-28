import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:items_repository/items_repository.dart';
import 'package:passline/authentication/authentication_bloc.dart';
import 'package:passline/common/common.dart';
import 'package:passline/pages/about/about_page.dart';
import 'package:passline/pages/addEdit/add_edit_page.dart';
import 'package:passline/pages/credential/credential_page.dart';
import 'package:passline/pages/home/bloc/home_bloc.dart';
import 'package:passline/pages/home/item.dart';
import 'package:passline/pages/home/search.dart';
import 'package:passline/pages/item/item_page.dart';
import 'package:passline/pages/settings/settings_page.dart';

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
    return BlocProvider<HomeBloc>(
      create: (context) => HomeBloc(
        itemsRepository: FirebaseItemsRepository(),
      )..add(LoadItems()),
      child: Builder(
        builder: (context) {
          return BlocBuilder(
            bloc: BlocProvider.of<HomeBloc>(context),
            builder: (context, HomeState state) {
              if (state is HomeLoaded) {
                return Scaffold(
                  appBar: _buildAppBar(context),
                  drawer: _buildDrawer(context),
                  body: _buildBody(),
                  floatingActionButton: FloatingActionButton(
                    backgroundColor: Theme.of(context).primaryColor,
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => AddEditPage(
                            isEditing: true,
                            onSave: (name, username, password) {
                              var credential = Credential(username, password);
                              var credentials = List<Credential>()
                                ..add(credential);
                              var item = Item(name, credentials);
                              BlocProvider.of<HomeBloc>(context)
                                  .add(AddItem(item));
                            },
                          ),
                        ),
                      );
                    },
                    child: Icon(Icons.add),
                    tooltip: 'Add item',
                  ),
                );
              } else {
                return Scaffold(
                  body: LoadingIndicator(),
                );
              }
            },
          );
        },
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text("Passline"),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () async {
            var item = await showSearch(
                context: context,
                delegate:
                    ItemSearch(homeBloc: BlocProvider.of<HomeBloc>(context)));
            if (item != null && item.credentials.length == 1) {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) =>
                      CredentialPage(credential: item.credentials[0])));
            } else if (item != null) {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => ItemPage(name: item.name)));
            }
          },
        )
      ],
    );
  }

  Widget _buildBody() {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      if (state is HomeLoading) {
        return LoadingIndicator();
      } else if (state is HomeLoaded) {
        return ListView.separated(
          padding: EdgeInsets.all(5.0),
          itemCount: state.items.length,
          itemBuilder: (context, index) {
            final item = state.items[index];
            return ItemWidget(
                item: item,
                onTap: () async {
                  if (item.credentials.length == 1) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) =>
                            CredentialPage(credential: item.credentials[0])));
                  } else {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => ItemPage(name: item.name)));
                  }
                });
          },
          separatorBuilder: (context, index) {
            return Divider();
          },
        );
      }

      return Container();
    });
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Passline'),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Settings"),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => SettingsPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              BlocProvider.of<AuthenticationBloc>(context)
                ..add(AuthenticationLoggedOut());
            },
          ),
          ListTile(
              leading: Icon(Icons.info),
              title: Text("About"),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => AboutPage()));
              }),
        ],
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
