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
    final textTheme = Theme.of(context).textTheme;

    void _onSliderChange(double value) {
      this.setState(() {
        password = PwGen.generate(value.round(), symbols, numbs, characs);
      });
    }

    void _onSymbolsChange(bool newValue) {
      if (!newValue && !numbs && !characs) {
        showErrorSnackbar();
        return;
      }
      this.setState(() {
        symbols = newValue;
        password = PwGen.generate(password.length, symbols, numbs, characs);
      });
    }

    void _onNumbsChange(bool newValue) {
      if (!newValue && !characs && !symbols) {
        showErrorSnackbar();
        return;
      }
      this.setState(() {
        numbs = newValue;
        password = PwGen.generate(password.length, symbols, numbs, characs);
      });
    }

    void _onCharacsChange(bool newValue) {
      if (!newValue && !numbs && !symbols) {
        showErrorSnackbar();
        return;
      }
      this.setState(() {
        characs = newValue;
        password = PwGen.generate(password.length, symbols, numbs, characs);
      });
    }

    return Scaffold(
      key: _scaffoldKey,
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
                initialValue: isEditing ? this.widget.item.name : '',
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
                initialValue: isEditing ? this.widget.credential.username : '',
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
              Container(),
              CheckboxListTile(
                  title: Text("Use characters"),
                  value: this.characs,
                  onChanged: _onCharacsChange),
              CheckboxListTile(
                  title: Text("Use numbers"),
                  value: this.numbs,
                  onChanged: _onNumbsChange),
              CheckboxListTile(
                  title: Text("Use symbols"),
                  value: this.symbols,
                  onChanged: _onSymbolsChange),
              Text("Password length"),
              Slider(
                label: "${this.password.length}",
                value: this.password.length.toDouble(),
                min: 6,
                max: 30,
                divisions: 24,
                onChanged: _onSliderChange,
              ),
              Text("Password preview"),
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
                  readOnly: true,
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
