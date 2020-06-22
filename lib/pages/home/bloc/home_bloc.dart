import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:items_repository/items_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ItemsRepository _itemsRepository;
  StreamSubscription _itemsSubscription;

  HomeBloc({@required ItemsRepository itemsRepository})
      : assert(itemsRepository != null),
        _itemsRepository = itemsRepository;

  @override
  HomeState get initialState => HomeLoading();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is LoadItems) {
      yield* _mapLoadItemsToState();
    } else if (event is ItemsUpdated) {
      yield* _mapItemsUpdatedToState(event);
    }
  }

  Stream<HomeState> _mapLoadItemsToState() async* {
    _itemsSubscription?.cancel();
    _itemsSubscription = _itemsRepository.items().listen(
          (items) => add(ItemsUpdated(items)),
        );
  }

  Stream<HomeState> _mapItemsUpdatedToState(ItemsUpdated event) async* {
    yield HomeLoaded(event.items);
  }

  @override
  Future<void> close() {
    _itemsSubscription?.cancel();
    return super.close();
  }
}
