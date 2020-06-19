import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passline/common/common.dart';
import 'package:passline/pages/credential/credential_page.dart';
import 'package:passline/pages/home/bloc/items/items_bloc.dart';
import 'package:passline/pages/item/item_page.dart';
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
                            CredentialPage(credential: item.credentials[0])));
                  } else {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => ItemPage(name: item.name)));
                  }
                });
          },
        );
      } 

      return Container();
    });
  }
}
