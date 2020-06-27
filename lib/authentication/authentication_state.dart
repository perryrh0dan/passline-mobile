part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class NotRegistered extends AuthenticationState {}

class Registered extends AuthenticationState {}

class Authenticated extends AuthenticationState {}

class AuthenticationFailure extends AuthenticationState {}
