import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:config_repository/config_repository.dart';
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
  final configRepository = FirebaseConfigRepository();

  LoginBloc({
    @required this.userRepository,
    @required this.authenticationBloc,
  })  : assert(userRepository != null),
        assert(authenticationBloc != null);

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield* _mapLoginButtonPressToState(event);
    }

    if (event is BiometricLoginPressed) {
      yield* _mapBiometricButtonPressToState();
    }
  }

  Stream<LoginState> _mapLoginButtonPressToState(LoginButtonPressed event) async* {
    yield LoginInProgress();

    try {
      final isSignedIn = await userRepository.isAuthenticated();
      if (!isSignedIn) {
        await userRepository.authenticate();
      }

      // get encryption key
      final encryptedEncryptionKey = await configRepository.key();
      var pwKey = Crypt.getKey(event.password);
      var encryptionKey =
          await Crypt.aesGCMDecrypt(pwKey, encryptedEncryptionKey);

      authenticationBloc
          .add(AuthenticationLoggedIn(encryptionKey: encryptionKey));
      yield LoginInitial();
    } catch (error) {
      yield LoginFailure(error: "Wrong Password");
    }
  }

  Stream<LoginState> _mapBiometricButtonPressToState() async* {
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
      }
      if (authenticated) {
              authenticationBloc
          .add(AuthenticationLoggedIn(encryptionKey: encryptionKey));
        yield LoginInitial();
      } else {
        yield LoginFailure(error: 'Unknown error');
      }
    } else {
      yield LoginFailure(error: 'Unable to load key');
    }
  }
}
