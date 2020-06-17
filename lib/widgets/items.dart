import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:items_repository/items_repository.dart';
import 'package:passline/blocs/bloc.dart';
import 'package:passline/screens/credential_screen.dart';
import 'package:passline/screens/item_screen.dart';
import 'package:passline/widgets/widgets.dart';

class Items extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemsBloc, ItemsState>(builder: (context, state) {
      if (state is ItemsLoading) {
        return LoadingIndicator();
      } else if (state is ItemsLoaded) {
        return ListView.builder(
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
                            CredentialScreen(credential: item.credentials[0])));
                  } else {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => ItemScreen(name: item.name)));
                  }
                });
          },
        );
      } else {
        return Container();
      }
    });
  }
}
