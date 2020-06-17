import 'package:equatable/equatable.dart';
import 'package:items_repository/items_repository.dart';

abstract class PasswordState extends Equatable {
  const PasswordState();

  @override
  List<Object> get props => [];
}

class Authenticated extends PasswordState {
  final String encryptionKey;

  const Authenticated(this.encryptionKey);

  @override
  List<Object> get props => [encryptionKey];

  @override
  String toString() => 'Authenticated { encryptionKey: $encryptionKey }';
}

// class AuthenticationFailure extends PasswordState {
//   final String error;

//   const AuthenticationFailure({this.error});

//   @override
//   List<Object> get props => [error];

//   @override
//   String toString() => 'AuthenticationFailure { error: $error }';
// }

class Unauthenticated extends PasswordState {}
