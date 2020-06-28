part of 'setup_bloc.dart';

abstract class SetupState extends Equatable {
  const SetupState();

  @override
  List<Object> get props => [];
}

class SetupInitial extends SetupState {}

class SetupInProgress extends SetupState {}

class SetupFailure extends SetupState {
  final String error;

  const SetupFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'SetupFailure { error: $error }';
}
