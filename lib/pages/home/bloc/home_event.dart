part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class LoadItems extends HomeEvent {}

class ItemsUpdated extends HomeEvent {
  final List<Item> items;

  const ItemsUpdated(this.items);

  @override
  List<Object> get props => [items];
}