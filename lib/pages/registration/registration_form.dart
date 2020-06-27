import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/registration_bloc.dart';

class RegistrationForm extends StatelessWidget {
  final _passwordController = TextEditingController();
  final _passwordRepeatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _onRegistrationButtonPressed() {
      BlocProvider.of<RegistrationBloc>(context).add(
        RegistrationButtonPressed(
          password: _passwordController.text,
        ),
      );
    }

    return BlocListener<RegistrationBloc, RegistrationState>(
      listener: (context, state) {
        if (state is RegistrationFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<RegistrationBloc, RegistrationState>(
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
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Password (repeat)',
                    ),
                    controller: _passwordRepeatController,
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    width: 300,
                    child: RaisedButton(
                      onPressed: state is! RegistrationInProgress
                          ? _onRegistrationButtonPressed
                          : null,
                      child: Text('SET UP'),
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Container(
                    child: state is RegistrationInProgress
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
