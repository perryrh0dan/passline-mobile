import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'addEdit_event.dart';
part 'addEdit_state.dart';

class AddEditBloc extends Bloc<AddEditEvent, AddEditState> {
  AddEditBloc() : super(AddEditState(length: 20));

  @override
  Stream<AddEditState> mapEventToState(
    AddEditEvent event,
  ) async* {
    if (event is PasswordLengthChanged) {
      yield state.copyWith(length: event.length);
    } else if (event is CharactersSetChanged) {
      yield state.copyWith(characters: event.characters);
    } else if (event is NumbersSetChanged) {
      yield state.copyWith(numbers: event.numbers);
    } else if (event is SymbolsSetChanged) {
      yield state.copyWith(symbols: event.symbols);
    }
  }
}
