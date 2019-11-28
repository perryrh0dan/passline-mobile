import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:items_repository/items_repository.dart';
import 'package:passline/blocs/bloc.dart';
import 'package:passline/widgets/widgets.dart';

class Credentials extends StatelessWidget {
  final String name;

  const Credentials({Key key, this.name}) : super(key: key);

    @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemsBloc, ItemsState>(builder: (context, state) {
      final item = (state as ItemsLoaded)
        .items
        .firstWhere((item) => item.name == name, orElse: () => null);
        return ListView.builder(
          itemCount: item.credentials.length,
          itemBuilder: (context, index) {
            final credential = item.credentials[index];
            return CredentialWidget(
              credential: credential
            );
          },
        );
    });
  }
  
}