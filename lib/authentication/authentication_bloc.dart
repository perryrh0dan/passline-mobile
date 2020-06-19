import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:meta/meta.dart';
import 'package:user_repository/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final LocalAuthentication auth = LocalAuthentication();
  final UserRepository userRepository;

  AuthenticationBloc({@required this.userRepository})
      : assert(userRepository != null);

  @override
  AuthenticationState get initialState => AuthenticationInitial();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationStarted) {
      yield* _mapStartedToState();
    }
    if (event is AuthenticationLoggedIn) {
      yield* _mapLoggedInToState(event);
    }
    if (event is AuthenticationLoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AuthenticationState> _mapStartedToState() async* {
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
        yield Authenticated(encryptionKey);
      } else {
        yield AuthenticationFailure();
      }
    } else {
      yield AuthenticationFailure();
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState(
      AuthenticationLoggedIn event) async* {
    yield AuthenticationInProgress();
    await userRepository.persistKey(event.encryptionKey);
    yield Authenticated(event.encryptionKey);
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    await userRepository.deleteKey();
    yield AuthenticationInitial();
  }
}
