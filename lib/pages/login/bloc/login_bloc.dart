import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:meta/meta.dart';
import 'package:passline/authentication/authentication_bloc.dart';
import 'package:passline/crypt/crypt.dart';
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
        assert(authenticationBloc != null);

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginStarted) {
      yield* _mapStartedToState();
    }

    if (event is LoginButtonPressed) {
      yield* _mapLoginButtonPressToState(event);
    }

    if (event is BiometricLoginPressed) {
      yield* _mapBiometricButtonPressToState();
    }
  }

  Stream<LoginState> _mapStartedToState() async* {
    final List<int> encryptionKey = await _biometricAuthentication();

    if (encryptionKey != null) {
      authenticationBloc
          .add(AuthenticationLoggedIn(encryptionKey: encryptionKey));
      yield LoginInitial();
    } else {
      yield LoginInitial();
    }
  }

  Stream<LoginState> _mapLoginButtonPressToState(
      LoginButtonPressed event) async* {
    yield LoginInProgress();

    try {
      final isSignedIn = await userRepository.isAuthenticated();
      if (!isSignedIn) {
        await userRepository.authenticate();
      }

      // get encryption key
      final encryptedEncryptionKey = await userRepository.loadKey();
      var pwKey = Crypt.passwordToKey(event.password);
      var encryptionKey =
          await Crypt.decryptKey(pwKey, encryptedEncryptionKey);

      authenticationBloc
          .add(AuthenticationLoggedIn(encryptionKey: encryptionKey));
      yield LoginInitial();
    } catch (error) {
      yield LoginFailure(error: "Wrong Password");
    }
  }

  Stream<LoginState> _mapBiometricButtonPressToState() async* {
    final List<int> encryptionKey = await _biometricAuthentication();

    if (encryptionKey != null) {
      authenticationBloc
          .add(AuthenticationLoggedIn(encryptionKey: encryptionKey));
      yield LoginInitial();
    } else {
      yield LoginFailure(error: 'Unable to load key');
    }
  }

  Future<List<int>> _biometricAuthentication() async {
    final List<int> encryptionKey = await userRepository.getKey();

    if (encryptionKey != null) {
      bool authenticated = false;
      try {
        authenticated = await auth.authenticateWithBiometrics(
            localizedReason: 'Scan your fingerprint to authenticate',
            useErrorDialogs: true,
            stickyAuth: true);
      } on PlatformException catch (e) {
        print(e);
        return null;
      }

      if (authenticated) {
        return encryptionKey;
      }
    }

    return null;
  }
}
