import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passline_mobile/common/common.dart';
import 'package:passline_mobile/pages/contributers/bloc/contributers_bloc.dart';

class ContributersForm extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContributersBloc, ContributersState>(
      cubit: BlocProvider.of<ContributersBloc>(context),
      builder: (context, state) {
        if (state is ContributersLoaded) {
          return ListView.separated(
            padding: EdgeInsets.all(5.0),
            itemCount: state.contributers.length,
            itemBuilder: (context, index) {
              final contributer = state.contributers[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: new NetworkImage(contributer.avatarUrl),
                ),
                title: Text(contributer.login),
              );
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
          );
        } else {
          return LoadingIndicator();
        }
      }
    );
  }
}