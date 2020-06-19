import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:items_repository/items_repository.dart';

part 'items_event.dart';
part 'items_state.dart';

class ItemsBloc extends Bloc<ItemsEvent, ItemsState> {
  final ItemsRepository _itemsRepository;
  StreamSubscription _itemsSubscription;

  ItemsBloc({@required ItemsRepository itemsRepository})
      : assert(itemsRepository != null),
        _itemsRepository = itemsRepository;

  @override
  ItemsState get initialState => ItemsLoading();

  @override
  Stream<ItemsState> mapEventToState(ItemsEvent event) async* {
    if (event is LoadItems) {
      yield* _mapLoadItemsToState();
    } else if (event is ItemsUpdated) {
      yield* _mapItemsUpdateToState(event);
    }
  }

  Stream<ItemsState> _mapLoadItemsToState() async* {
    _itemsSubscription?.cancel();
    _itemsSubscription = _itemsRepository.items().listen(
          (items) => add(ItemsUpdated(items)),
        );
  }

  Stream<ItemsState> _mapItemsUpdateToState(ItemsUpdated event) async* {
    yield ItemsLoaded(event.items);
  }

  @override
  Future<void> close() {
    _itemsSubscription?.cancel();
    return super.close();
  }
}
