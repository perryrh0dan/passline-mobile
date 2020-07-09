import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passline/pages/home/home_page.dart';
import 'package:passline/pages/setup/bloc/setup_bloc.dart';

class SetupForm extends StatelessWidget {
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _onSetupButtonPressed() {
      BlocProvider.of<SetupBloc>(context).add(
        SetupButtonPressed(
          password: _passwordController.text,
        ),
      );
    }

    return BlocListener<SetupBloc, SetupState>(
      listener: (context, state) {
        if (state is SetupFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<SetupBloc, SetupState>(
        builder: (context, state) {
          return Form(
            child: Padding(
              padding: EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                    controller: _passwordController,
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                      "Please enter your master password, that was used to encrypt the storage"),
                  SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    width: 300,
                    child: RaisedButton(
                      onPressed: state is! SetupInProgress
                          ? _onSetupButtonPressed
                          : null,
                      child: Text('FINISH'),
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Container(
                    child: state is SetupInProgress
                        ? CircularProgressIndicator()
                        : null,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
