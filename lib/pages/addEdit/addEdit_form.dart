import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passline_mobile/pages/addEdit/bloc/addEdit_bloc.dart';

typedef OnSaveCallback = Function(
    String name, String username, String password);

class AddEditForm extends StatelessWidget {
  AddEditForm({@required this.isEditing, @required this.onSave});

  final bool isEditing;
  final OnSaveCallback onSave;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<AddEditBloc, AddEditState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              isEditing ? 'Edit Item' : 'Add Item',
            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(0.0),
            child: Form(
              child: ListView(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
                    child: TextFormField(
                      initialValue: state.name,
                      autofocus: !isEditing,
                      style: textTheme.bodyText2,
                      decoration: InputDecoration(
                        hintText: 'Enter the website name',
                      ),
                      onChanged: (value) =>
                          BlocProvider.of<AddEditBloc>(context).add(
                        NameChanged(name: value),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
                    child: TextFormField(
                      initialValue: state.username,
                      autofocus: !isEditing,
                      style: textTheme.bodyText2,
                      decoration: InputDecoration(
                        hintText: 'Enter your username',
                      ),
                      onChanged: (value) =>
                          BlocProvider.of<AddEditBloc>(context).add(
                        UsernameChanged(username: value),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CheckboxListTile(
                    title: Text("Use characters"),
                    value: state.characters,
                    onChanged: (value) =>
                        BlocProvider.of<AddEditBloc>(context).add(
                      CharactersSetChanged(characters: value),
                    ),
                  ),
                  CheckboxListTile(
                    title: Text("Use numbers"),
                    value: state.numbers,
                    onChanged: (value) =>
                        BlocProvider.of<AddEditBloc>(context).add(
                      NumbersSetChanged(numbers: value),
                    ),
                  ),
                  CheckboxListTile(
                    title: Text("Use symbols"),
                    value: state.symbols,
                    onChanged: (value) =>
                        BlocProvider.of<AddEditBloc>(context).add(
                      SymbolsSetChanged(symbols: value),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Password length",
                          style: textTheme.subtitle1,
                        ),
                        Slider(
                          label: "${state.length}",
                          value: state.length.toDouble(),
                          min: 6,
                          max: 30,
                          divisions: 24,
                          onChanged: (value) =>
                              BlocProvider.of<AddEditBloc>(context).add(
                            PasswordLengthChanged(
                              length: value.toInt(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(16.0, 16.0, 0, 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Password preview",
                          style: textTheme.subtitle1,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        new Container(
                          decoration: new BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            border: new Border.all(
                              color: Colors.black,
                              width: 1.0,
                            ),
                          ),
                          child: new TextField(
                            readOnly: true,
                            textAlign: TextAlign.center,
                            decoration: new InputDecoration(
                              hintText: state.password,
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
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
              onSave(state.name, state.username, state.password);
            },
          ),
        );
      },
    );
  }
}
