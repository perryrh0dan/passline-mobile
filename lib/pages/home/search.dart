import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:items_repository/items_repository.dart';
import 'package:passline/blocs/items/items.dart';
import 'package:passline/common/common.dart';

class ItemSearch extends SearchDelegate<Item> {
  final Bloc<ItemsEvent, ItemsState> itemsBloc;

  ItemSearch(this.itemsBloc);

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
      bloc: itemsBloc,
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
        bloc: itemsBloc,
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
