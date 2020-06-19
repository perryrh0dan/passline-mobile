import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:items_repository/items_repository.dart';
import 'package:passline/common/common.dart';
import 'package:passline/pages/home/bloc/items/items_bloc.dart';

class ItemSearch extends SearchDelegate<Item> {
  @override
  List<Widget> buildActions(BuildContext context) => null;

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: BackButtonIcon(),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return BlocBuilder<ItemsBloc, ItemsState>(
      bloc: BlocProvider.of<ItemsBloc>(context),
      builder: (context, state) {
        if (state is ItemsLoading) {
          return LoadingIndicator();
        }
        if (state is ItemsLoaded) {
          final suggestions = query.isEmpty
              ? []
              : state.items
                  .where((element) =>
                      element.name.toLowerCase().contains(query.toLowerCase()))
                  .toList();

          return ListView.builder(
            itemBuilder: (context, index) => ListTile(
              title: Text(suggestions[index].name),
              onTap: () => close(context, suggestions[index]),
            ),
            itemCount: suggestions.length,
          );
        }

        return Container();
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return BlocBuilder<ItemsBloc, ItemsState>(
        bloc: BlocProvider.of<ItemsBloc>(context),
        builder: (context, state) {
          if (state is ItemsLoading) {
            return LoadingIndicator();
          }
          if (state is ItemsLoaded) {
            final suggestions = query.isEmpty
                ? []
                : state.items
                    .where((element) => element.name
                        .toLowerCase()
                        .contains(query.toLowerCase()))
                    .toList();

            return ListView.builder(
              itemBuilder: (context, index) => ListTile(
                title: Text(suggestions[index].name),
                onTap: () => close(context, suggestions[index]),
              ),
              itemCount: suggestions.length,
            );
          }

          return Container();
        });
  }
}
