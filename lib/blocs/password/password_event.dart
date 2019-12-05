import 'package:equatable/equatable.dart';

abstract class PasswordEvent extends Equatable {
  const PasswordEvent();

  @override
  List<Object> get props => [];
}

class Authenticate extends PasswordEvent {
  final String password;

  const Authenticate(this.password);

  @override
  String toString() => 'Authenticate { password: $password }';
}