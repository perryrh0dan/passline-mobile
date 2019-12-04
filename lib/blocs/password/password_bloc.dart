import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:passline/blocs/password/password.dart';

class PasswordBloc extends Bloc<PasswordEvent, PasswordState> {
  PasswordBloc();

  @override
  PasswordState get initialState => Unauthenticated();

  @override
  Stream<PasswordState> mapEventToState(PasswordEvent event) async* {
    if (event is Authenticate) {
      yield* _mapAuthenticateToState(event);
    }
  }

  Stream<PasswordState> _mapAuthenticateToState(Authenticate event) async* {
    yield Authenticated(event.password);
  }
}
