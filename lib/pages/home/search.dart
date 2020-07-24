import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:items_repository/items_repository.dart';
import 'package:passline_mobile/common/common.dart';
import 'package:passline_mobile/pages/home/bloc/home_bloc.dart';

class ItemSearch extends SearchDelegate<Item> {
  final Bloc<HomeEvent, HomeState> homeBloc;

  ItemSearch({@required this.homeBloc});

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
    return BlocBuilder<HomeBloc, HomeState>(
      cubit: this.homeBloc,
      builder: (context, state) {
        if (state is HomeLoading) {
          return LoadingIndicator();
        }
        if (state is HomeLoaded) {
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
    return BlocBuilder<HomeBloc, HomeState>(
        cubit: this.homeBloc,
        builder: (context, state) {
          if (state is HomeLoading) {
            return Container();
          }
          if (state is HomeLoaded) {
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
