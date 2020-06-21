part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginStarted extends LoginEvent {}

class LoginButtonPressed extends LoginEvent {
  final String password;

  const LoginButtonPressed({
    @required this.password,
  });

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'LoginButtonPressed { password: $password }';
}

class BiometricLoginPressed extends LoginEvent {}
