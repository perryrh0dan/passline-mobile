import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passline_mobile/authentication/authentication_bloc.dart';
import 'package:passline_mobile/pages/registration/bloc/registration_bloc.dart';
import 'package:passline_mobile/pages/registration/registration_form.dart';
import 'package:user_repository/user_repository.dart';

class RegistrationPage extends StatelessWidget {
  final UserRepository userRepository;

  const RegistrationPage({Key key, @required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) {
          return RegistrationBloc(
              authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
              userRepository: userRepository)
            ..add(RegistrationStarted());
        },
        child: RegistrationForm(),
      ),
    );
  }
}