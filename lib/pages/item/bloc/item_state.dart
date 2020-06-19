part of 'item_bloc.dart';

abstract class ItemState extends Equatable {
  const ItemState();

  @override
  List<Object> get props => [];
}

class ItemLoading extends ItemState {}

class ItemLoaded extends ItemState {
  final Item item;

  const ItemLoaded(this.item);

  @override
  List<Object> get props => [item];

  @override
  String toString() => 'ItemLoaded { item: $item }';
}

class ItemNotLoaded extends ItemState {}