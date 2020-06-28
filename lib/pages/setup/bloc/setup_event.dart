part of 'setup_bloc.dart';

class SetupEvent extends Equatable {
  const SetupEvent();

  @override
  List<Object> get props => [];
}

class SetupButtonPressed extends SetupEvent {
  final String password;

  @override
  const SetupButtonPressed({@required this.password});

  @override
  List<Object> get props => [password];
}
