part of 'registration_bloc.dart';

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  @override
  List<Object> get props => [];
}

class RegistrationStarted extends RegistrationEvent {}

class RegistrationSetPassword extends RegistrationEvent {}

class RegistrationButtonPressed extends RegistrationEvent {
  final String password;
  final String passwordRepeat;

  const RegistrationButtonPressed({
    @required this.password,
    @required this.passwordRepeat,
  });

  @override
  List<Object> get props => [password, passwordRepeat];

  @override
  String toString() => 'RegistrationButtonPressed { password: $password, passwordRepeat: $passwordRepeat }';
}
