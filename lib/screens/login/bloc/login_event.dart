 
part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginButtonPressed extends LoginEvent {
  final String password;

  const LoginButtonPressed({
    @required this.password,
  });

  @override
  List<Object> get props => [password];

  @override
  String toString() =>
      'LoginButtonPressed { password: $password }';
}