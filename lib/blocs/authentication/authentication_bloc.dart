import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:passline/blocs/authentication/authentication.dart';
import 'package:user_repository/user_repository.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;

  AuthenticationBloc({@required this.userRepository})
      : assert(userRepository != null);

  @override
  AuthenticationState get initialState => AuthenticationInitial();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationLoggedIn) {
      yield* _mapLoggedInToState(event);
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState(
      AuthenticationLoggedIn event) async* {
    yield Authenticated(event.encryptionKey);
  }
}
