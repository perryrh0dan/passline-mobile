import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passline/blocs/bloc.dart';
import 'package:passline/pages/credential_screen.dart';
import 'package:passline/widgets/widgets.dart';

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
        return ListView.builder(
          itemCount: item.credentials.length,
          itemBuilder: (context, index) {
            final credential = item.credentials[index];
            return CredentialWidget(
                credential: credential,
                onTap: () async {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => CredentialScreen(
                            credential: credential,
                          )));
                });
          },
        );
      } else {
        return Container();
      }
    });
  }
}
