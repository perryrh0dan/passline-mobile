import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:user_repository/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
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
    if (event is AuthenticationLocked) {
      yield* _mapLockedToState();
    }
    if (event is AuthenticationLoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AuthenticationState> _mapStartedToState() async* {
    yield AuthenticationInitial();
  }

  Stream<AuthenticationState> _mapLoggedInToState(
      AuthenticationLoggedIn event) async* {
    await userRepository.persistKey(event.encryptionKey);
    yield Authenticated(event.encryptionKey);
  }

  Stream<AuthenticationState> _mapLockedToState() async* {
    yield AuthenticationInitial();
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    await userRepository.deleteKey();
    yield AuthenticationInitial();
  }
}
