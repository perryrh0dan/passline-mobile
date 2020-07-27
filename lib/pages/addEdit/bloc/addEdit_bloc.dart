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
    if (event is AddEditPasswordLength) {
      yield* _mapPasswordLengthToState(event);
    }
  }

  Stream<AddEditState>_mapPasswordLengthToState(AddEditPasswordLength event) async* {
    yield AddEditState(length: event.length);
  }
}
