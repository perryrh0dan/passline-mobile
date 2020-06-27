import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:local_auth/local_auth.dart';
import 'package:meta/meta.dart';
import 'package:passline/authentication/authentication_bloc.dart';
import 'package:user_repository/user_repository.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final LocalAuthentication auth = LocalAuthentication();
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  RegistrationBloc({
    @required this.userRepository,
    @required this.authenticationBloc,
  })  : assert(userRepository != null),
        assert(authenticationBloc != null);

  @override
  RegistrationState get initialState => RegistrationInitial();

  @override
  Stream<RegistrationState> mapEventToState(RegistrationEvent event) async* {
    if (event is RegistrationButtonPressed) {
      yield* _mapRegistrationButtonPressToState(event);
    }
  }

  Stream<RegistrationState> _mapRegistrationButtonPressToState(
      RegistrationButtonPressed event) async* {
    yield RegistrationInProgress();

    authenticationBloc.add(AuthenticationRegister(password: event.password));
  }
}
