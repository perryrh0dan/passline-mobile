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
    if (event is AuthenticationRegister) {
      yield* _mapRegisterToState(event);
    }
  }

  Stream<AuthenticationState> _mapStartedToState() async* {
    if (await userRepository.isRegistered()) {
      yield Registered();
    } else {
      yield NotRegistered();
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState(
      AuthenticationLoggedIn event) async* {
    yield Authenticated();
  }

  Stream<AuthenticationState> _mapLockedToState() async* {
    yield Registered();
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    await userRepository.deleteKey();
    yield Registered();
  }

  Stream<AuthenticationState> _mapRegisterToState(
      AuthenticationRegister event) async* {
    await userRepository.register(event.password);
    yield Registered();
  }
}
