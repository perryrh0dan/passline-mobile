import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passline/blocs/bloc.dart';
import 'package:passline/screens/item_screen.dart';
import 'package:passline/widgets/widgets.dart';

class Items extends StatelessWidget {

    @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemsBloc, ItemsState>(builder: (context, state) {
      if (state is ItemsLoading) {
        return Container();
        // return LoadingIndicator();
      } else if (state is ItemsLoaded) {
        final items = state.items;
        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return ItemWidget(
              item: item,
              onTap: ()async {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => 
                    ItemScreen(name: item.name)
                  )
                );
              }
            );
          },
        );
      } else {
        return Container();
      }
    });
  }
  
}