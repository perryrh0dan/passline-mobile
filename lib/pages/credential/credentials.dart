import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passline/pages/credential/credential.dart';
import 'package:passline/pages/credential/credential_page.dart';
import 'package:passline/pages/item/bloc/item_bloc.dart';

class Credentials extends StatelessWidget {
  final String name;

  const Credentials({Key key, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemBloc, ItemState>(builder: (context, state) {
      if (state is ItemLoading) {
        return Container();
      } else if (state is ItemLoaded) {
        final item = state.item;
        return ListView.separated(
          padding: EdgeInsets.all(5.0),
          itemCount: item.credentials.length,
          itemBuilder: (context, index) {
            final credential = item.credentials[index];
            return CredentialWidget(
                credential: credential,
                onTap: () async {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => CredentialPage(
                            credential: credential,
                          )));
                });
          },
          separatorBuilder: (context, index) {
            return Divider();
          },
        );
      } else {
        return Container();
      }
    });
  }
}
