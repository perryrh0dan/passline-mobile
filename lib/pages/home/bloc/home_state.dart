part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeNotInitialized extends HomeState {}

class SetupInProgress extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Item> items;

  const HomeLoaded([this.items = const []]);

  @override
  List<Object> get props => [items];

  @override
  String toString() => 'HomeLoaded { items: $items }';
}

class HomeSetupFailur extends HomeState {
  final String error;

  const HomeSetupFailur({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'SetupFailure { error: $error }';
}
