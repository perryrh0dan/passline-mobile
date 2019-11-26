import 'package:flutter/material.dart';
import 'package:passline/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passline/blocs/bloc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemsBloc, ItemsState>(builder: (context, state) {
      if (state is ItemsLoading) {
        return LoadingIndicator();
      } else if (state is ItemsLoaded) {
        final items = state.items;
        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return ItemWidget(
              item: item
            );
          },
        );
      } else {
        return Container();
      }
    });
  }
}
