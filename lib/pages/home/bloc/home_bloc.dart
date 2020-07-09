import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:items_repository/items_repository.dart';
import 'package:user_repository/user_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final UserRepository userRepository;
  final ItemsRepository itemsRepository;
  StreamSubscription _itemsSubscription;

  HomeBloc({@required this.userRepository, @required this.itemsRepository});

  @override
  HomeState get initialState => HomeLoading();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is HomeStarted) {
      yield* _mapStartedToState();
    } else if (event is LoadItems) {
      yield* _mapLoadItemsToState();
    } else if (event is AddItem) {
      yield* _mapAddItemToState(event);
    } else if (event is ItemsUpdated) {
      yield* _mapItemsUpdatedToState(event);
    }
  }

  Stream<HomeState> _mapStartedToState() async* {
    if (await this.userRepository.hasKey()) {
      add(LoadItems());
    } else {
      yield HomeRegister();
    }
  }

  Stream<HomeState> _mapLoadItemsToState() async* {
    _itemsSubscription?.cancel();
    _itemsSubscription = itemsRepository.items().listen(
          (items) => add(ItemsUpdated(items)),
        );
  }

  Stream<HomeState> _mapAddItemToState(AddItem event) async* {
    itemsRepository.addItem(event.item);
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
