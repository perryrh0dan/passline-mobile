import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passline/blocs/password/password.dart';

class PasswordDialogState extends StatelessWidget {
  final TextEditingController _password = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PasswordBloc, PasswordState>(
      builder: (context, state) {
        return new Scaffold(
            appBar: new AppBar(
              title: new Text("Enter master password"),
            ),
            body: new Padding(
              child: new ListView(
                children: <Widget>[
                  new TextField(
                    controller: _password,
                  ),
                  new Row(
                    children: <Widget>[
                      new Expanded(
                          child: new RaisedButton(
                        onPressed: () {
                          BlocProvider.of<PasswordBloc>(context).add(Authenticate(_password.text));
                        },
                        child: new Text("Save"),
                      ))
                    ],
                  )
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
            ));
      },
    );
  }
}
