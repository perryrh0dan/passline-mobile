import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:items_repository/items_repository.dart';
import 'package:passline_mobile/pages/addEdit/addEdit_form.dart';
import 'package:passline_mobile/pages/addEdit/bloc/addEdit_bloc.dart';

class AddEditPage extends StatelessWidget {
  final bool isEditing;
  final OnSaveCallback onSave;
  final Item item;
  final Credential credential;

  AddEditPage({
    Key key,
    @required this.onSave,
    @required this.isEditing,
    this.item,
    this.credential,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          AddEditBloc(name: item?.name, username: credential?.username),
      child: AddEditForm(
        isEditing: isEditing,
        onSave: onSave,
      ),
    );
  }
}
