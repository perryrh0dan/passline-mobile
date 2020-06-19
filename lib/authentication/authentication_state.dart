part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  final List<int> encryptionKey;

  const Authenticated(this.encryptionKey);

  @override
  List<Object> get props => [encryptionKey];

  @override
  String toString() => 'Authenticated { encryptionKey: $encryptionKey }';
}

class AuthenticationFailure extends AuthenticationState {}

class AuthenticationInProgress extends AuthenticationState {}
