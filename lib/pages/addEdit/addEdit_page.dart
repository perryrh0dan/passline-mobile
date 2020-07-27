import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:items_repository/items_repository.dart';
import 'package:passline_mobile/crypt/pwgen.dart';

typedef OnSaveCallback = Function(
    String name, String username, String password);

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

  _AddEditPageState() {
    this.password = PwGen.generate(20);
  }

  bool get isEditing => widget.isEditing;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    void _onSliderChange(double value) {
      this.setState(() {
        password = PwGen.generate(value.round());
      });
    }

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
                style: textTheme.subtitle1,
                decoration: InputDecoration(
                  hintText: 'Enter your username',
                ),
                validator: (val) {
                  return val.trim().isEmpty ? 'Please enter some text' : null;
                },
                onSaved: (value) => username = value,
              ),
              SizedBox(
                height: 20,
              ),
              Text("Password length"),
              Slider(
                label: "${this.password.length}",
                value: this.password.length.toDouble(),
                min: 6,
                max: 30,
                divisions: 24,
                onChanged: _onSliderChange,
              ),
              new Container(
                decoration: new BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  border: new Border.all(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
                child: new TextField(
                  textAlign: TextAlign.center,
                  decoration: new InputDecoration(
                    hintText: this.password,
                    border: InputBorder.none,
                  ),
                ),
              ),
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
