part of 'items_bloc.dart';

abstract class ItemsEvent extends Equatable {
  const ItemsEvent();

  @override
  List<Object> get props => [];
}

class LoadItems extends ItemsEvent {}

class ItemsUpdated extends ItemsEvent {
  final List<Item> items;

  const ItemsUpdated(this.items);

  @override
  List<Object> get props => [items];
}

class FilterItems extends ItemsEvent {
  final String query;

  const FilterItems(this.query);

    @override
  List<Object> get props => [query];
}