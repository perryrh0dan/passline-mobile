part of 'contributers_bloc.dart';

abstract class ContributersEvent extends Equatable {
  const ContributersEvent();

  @override
  List<Object> get props => [];
}

class ContributersLoad extends ContributersEvent {}
