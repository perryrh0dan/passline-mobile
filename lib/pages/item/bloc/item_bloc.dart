import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:items_repository/items_repository.dart';

part 'item_event.dart';
part 'item_state.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  final ItemsRepository _itemsRepository;
  StreamSubscription _itemsSubscription;

  ItemBloc({@required ItemsRepository itemsRepository})
      : assert(itemsRepository != null),
        _itemsRepository = itemsRepository, super(ItemLoading());

  @override
  Stream<ItemState> mapEventToState(ItemEvent event) async* {
    if (event is LoadItem) {
      yield* _mapLoadItemToState(event);
    } else if (event is ItemUpdated) {
      yield* _mapItemUpdateToState(event);
    }
  }

  Stream<ItemState> _mapLoadItemToState(LoadItem event) async* {
    _itemsSubscription?.cancel();
    _itemsSubscription = _itemsRepository.item(event.name).listen(
          (item) => add(ItemUpdated(item)),
        );
  }

  Stream<ItemState> _mapItemUpdateToState(ItemUpdated event) async* {
    yield ItemLoaded(event.item);
  }

  @override
  Future<void> close() {
    _itemsSubscription?.cancel();
    return super.close();
  }
}
