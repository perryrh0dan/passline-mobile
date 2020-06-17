import 'package:equatable/equatable.dart';
import 'package:items_repository/items_repository.dart';

abstract class ItemsState extends Equatable {
  const ItemsState();

  @override
  List<Object> get props => [];
}

class ItemsLoading extends ItemsState {}

class ItemsLoaded extends ItemsState {
  final List<Item> items;

  final String query;
  final List<Item> filteredItems;

  const ItemsLoaded([this.items = const [], this.query = "", this.filteredItems = const []]);

  @override
  List<Object> get props => [items, query, filteredItems];

  @override
  String toString() => 'ItemsLoaded { items: $items, filtereditems: $filteredItems }';
}

class ItemsNotLoaded extends ItemsState {}
