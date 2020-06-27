import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:items_repository/items_repository.dart';

typedef OnSaveCallback = Function(String name, String username, String password);

class AddEditPage extends StatefulWidget {
  final bool isEditing;
  final OnSaveCallback onSave;
  final Item item;

  AddEditPage({
    Key key,
    @required this.onSave,
    @required this.isEditing,
    this.item,
  }) : super(key: key);

  @override
  _AddEditPageState createState() => _AddEditPageState();
}

class _AddEditPageState extends State<AddEditPage> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String name;
  String username;
  String password;

  bool get isEditing => widget.isEditing;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? 'Edit Item' : 'Add Item',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: isEditing ? '' : '',
                autofocus: !isEditing,
                style: textTheme.headline5,
                decoration: InputDecoration(
                  hintText: 'Enter the website name',
                ),
                validator: (val) {
                  return val.trim().isEmpty ? 'Please enter some text' : null;
                },
                onSaved: (value) => name = value,
              ),
              TextFormField(
                initialValue: isEditing ? '' : '',
                maxLines: 10,
                style: textTheme.subtitle1,
                decoration: InputDecoration(
                  hintText: 'Enter your username',
                ),
                onSaved: (value) => username = value,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: isEditing ? 'Save changes' : 'Add Todo',
        child: Icon(isEditing ? Icons.check : Icons.add),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();

            widget.onSave(name, username, password);
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
