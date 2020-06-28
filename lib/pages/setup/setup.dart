import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passline/pages/setup/bloc/setup_bloc.dart';
import 'package:passline/pages/setup/setup_form.dart';
import 'package:user_repository/user_repository.dart';

class SetupPage extends StatelessWidget {
  final UserRepository userRepository;

  const SetupPage({Key key, @required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) {
          return SetupBloc(userRepository: userRepository);
        },
        child: SetupForm(),
      ),
    );
  }
}
