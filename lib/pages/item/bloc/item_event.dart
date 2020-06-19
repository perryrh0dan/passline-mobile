part of 'item_bloc.dart';

abstract class ItemEvent extends Equatable {
  const ItemEvent();

  @override
  List<Object> get props => [];
}

class LoadItem extends ItemEvent {
  final String name;

  const LoadItem(this.name);

  @override
  String toString() => 'LoadItem { name: $name }';
}

class ItemUpdated extends ItemEvent {
  final Item item;

  const ItemUpdated(this.item);

  @override
  List<Object> get props => [item];
}