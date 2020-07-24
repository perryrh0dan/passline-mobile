import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:meta/meta.dart';
import 'package:passline_mobile/authentication/authentication_bloc.dart';
import 'package:user_repository/user_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LocalAuthentication auth = LocalAuthentication();
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    @required this.userRepository,
    @required this.authenticationBloc,
  })  : assert(userRepository != null),
        assert(authenticationBloc != null), super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginStarted) {
      yield* _mapStartedToState(event);
    }

    if (event is LoginButtonPressed) {
      yield* _mapLoginButtonPressToState(event);
    }

    if (event is BiometricLoginPressed) {
      yield* _mapBiometricButtonPressToState();
    }
  }

  Stream<LoginState> _mapStartedToState(LoginStarted event) async* {
    final valid = await _biometricAuthentication();

    if (valid) {
      await userRepository.authenticateWithoutPW();
      authenticationBloc.add(AuthenticationLoggedIn());
    }
    yield LoginInitial();
  }

  Stream<LoginState> _mapLoginButtonPressToState(
      LoginButtonPressed event) async* {
    yield LoginInProgress();

    var valid = await userRepository.authenticate(event.password);
    if (!valid) {
      yield LoginFailure(error: "Wrong Password");
    } else {
      try {
        authenticationBloc.add(AuthenticationLoggedIn());
        yield LoginInitial();
      } catch (error) {
        yield LoginFailure(error: "Wrong Password");
      }
    }
  }

  Stream<LoginState> _mapBiometricButtonPressToState() async* {
    final bool valid = await _biometricAuthentication();

    if (valid) {
      await userRepository.authenticateWithoutPW();
      authenticationBloc.add(AuthenticationLoggedIn());
      yield LoginInitial();
    } else {
      yield LoginFailure(error: 'Unable to load key');
    }
  }

  Future<bool> _biometricAuthentication() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticateWithBiometrics(
          localizedReason: 'Scan your fingerprint to authenticate',
          useErrorDialogs: true,
          stickyAuth: true);
    } on PlatformException catch (e) {
      print(e);
      return false;
    }
    return authenticated;
  }
}
