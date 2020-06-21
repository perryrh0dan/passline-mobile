part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationStarted extends AuthenticationEvent {}

class AuthenticationLoggedIn extends AuthenticationEvent {
  final List<int> encryptionKey;

  const AuthenticationLoggedIn({@required this.encryptionKey});

  @override
  List<Object> get props => [encryptionKey];

  @override
  String toString() => 'LoggedIn  { encryptionKey: $encryptionKey }';
}

class AuthenticationLocked extends AuthenticationEvent {}

class AuthenticationLoggedOut extends AuthenticationEvent {}
