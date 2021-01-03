import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:items_repository/items_repository.dart';
import 'package:passline_mobile/crypt/pwgen.dart';
import 'package:passline_mobile/pages/addEdit/addEdit_form.dart';
import 'package:passline_mobile/pages/addEdit/bloc/addEdit_bloc.dart';

typedef OnSaveCallback = Function(
    String name, String username, String password);

class AddEditPage extends StatefulWidget {
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
  _AddEditPageState createState() => _AddEditPageState();
}

class _AddEditPageState extends State<AddEditPage> {
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String name;
  String username;
  String password;
  bool symbols = true;
  bool numbs = true;
  bool characs = true;

  SnackBar errorSnackbar = SnackBar(
    content: new Text('One option has to be checked'),
    duration: new Duration(seconds: 2),
    backgroundColor: Colors.red,
  );

  _AddEditPageState() {
    this.password = PwGen.generate(20, symbols, numbs, characs);
  }

  bool get isEditing => widget.isEditing;

  void showErrorSnackbar() {
    _scaffoldKey.currentState.showSnackBar(errorSnackbar);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddEditBloc(),
      child: AddEditForm(),
    );
}
