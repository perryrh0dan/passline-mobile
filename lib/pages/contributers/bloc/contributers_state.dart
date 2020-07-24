part of 'contributers_bloc.dart';

abstract class ContributersState extends Equatable {
  const ContributersState();

  @override
  List<Object> get props => [];
}

class ContributersLoading extends ContributersState {

}

class ContributersLoaded extends ContributersState {
  final List<Contributer> contributers;

  const ContributersLoaded({@required this.contributers});

  @override
  List<Object> get props => [this.contributers];
}

class ContributersFailure extends ContributersState {
  final String error;

  const ContributersFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'ContributersFailure { error: $error }';
}
