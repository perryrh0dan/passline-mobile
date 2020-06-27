part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeStarted extends HomeEvent {}

class SetupButtunPressed extends HomeEvent {
  final String password;

  @override
  const SetupButtunPressed({@required this.password});

  @override
  List<Object> get props => [password];
}

class LoadItems extends HomeEvent {}

class ItemsUpdated extends HomeEvent {
  final List<Item> items;

  const ItemsUpdated(this.items);

  @override
  List<Object> get props => [items];
}

class AddItem extends HomeEvent {
  final Item item;

  const AddItem(this.item);

  @override
  List<Object> get props => [item];

  @override
  String toString() => 'AddItem { item: $item }';
}