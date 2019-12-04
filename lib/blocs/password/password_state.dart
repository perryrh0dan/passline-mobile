import 'package:equatable/equatable.dart';
import 'package:items_repository/items_repository.dart';

abstract class PasswordState extends Equatable {
  const PasswordState();

  @override
  List<Object> get props => [];
}

class Authenticated extends PasswordState {
  final String password;

  const Authenticated(this.password);

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'Authenticated { password: $password }';
}

class Unauthenticated extends PasswordState {}
