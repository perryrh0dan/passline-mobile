import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passline/pages/home/bloc/home_bloc.dart';
import 'package:passline/pages/login/bloc/login_bloc.dart';

class InitForm extends StatelessWidget {
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _onLoginButtonPressed() {
      BlocProvider.of<HomeBloc>(context).add(
        SetupButtunPressed(
          password: _passwordController.text,
        ),
      );
    }

    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is HomeSetupFailur) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<HomeBloc, HomeState>(
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
                        hintText: 'Enter your master password'),
                    controller: _passwordController,
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    width: 300,
                    child: RaisedButton(
                      onPressed: state is! SetupInProgress
                          ? _onLoginButtonPressed
                          : null,
                      child: Text('SETUP'),
                    ),
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
