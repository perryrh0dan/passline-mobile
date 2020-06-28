import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passline/pages/login/bloc/login_bloc.dart';

class LoginForm extends StatelessWidget {
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _onLoginButtonPressed() {
      BlocProvider.of<LoginBloc>(context).add(
        LoginButtonPressed(
          password: _passwordController.text,
        ),
      );
    }

    _onBiometricButtonPressed() {
      BlocProvider.of<LoginBloc>(context).add(
        BiometricLoginPressed(),
      );
    }

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
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
                        labelText: 'Password', hintText: 'Enter your password'),
                    controller: _passwordController,
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    width: 300,
                    child: RaisedButton(
                      onPressed: state is! LoginInProgress
                          ? _onLoginButtonPressed
                          : null,
                      child: Text('UNLOCK'),
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  IconButton(
                    iconSize: 50.0,
                    icon: Icon(Icons.fingerprint),
                    onPressed: () => state is! LoginInProgress
                        ? _onBiometricButtonPressed()
                        : null,
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Container(
                    child: state is LoginInProgress
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
