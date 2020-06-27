part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationStarted extends AuthenticationEvent {}

class AuthenticationLoggedIn extends AuthenticationEvent {}

class AuthenticationLocked extends AuthenticationEvent {}

class AuthenticationLoggedOut extends AuthenticationEvent {}

class AuthenticationRegister extends AuthenticationEvent {
  final String password;

  const AuthenticationRegister({@required this.password});

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'Register { password: $password }';
}
