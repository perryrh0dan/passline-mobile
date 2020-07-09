part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeRegister extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Item> items;

  const HomeLoaded([this.items = const []]);

  @override
  List<Object> get props => [items];

  @override
  String toString() => 'HomeLoaded { items: $items }';
}
