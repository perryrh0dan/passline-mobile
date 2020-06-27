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

  const RegistrationButtonPressed({
    @required this.password,
  });

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'RegistrationButtonPressed { password: $password }';
}
