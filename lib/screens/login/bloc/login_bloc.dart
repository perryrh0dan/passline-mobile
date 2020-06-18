import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:config_repository/config_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:passline/blocs/authentication/authentication.dart';
import 'package:passline/crypt/crypt.dart';
import 'package:user_repository/user_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;
  final configRepository = FirebaseConfigRepository();

  LoginBloc({
    @required this.userRepository,
    @required this.authenticationBloc,
  })  : assert(userRepository != null),
        assert(authenticationBloc != null);

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginInProgress();

      try {
        final isSignedIn = await userRepository.isAuthenticated();
        if (!isSignedIn) {
          await userRepository.authenticate();
        }

        // get encryption key
        final encryptedEncryptionKey = await configRepository.key();
        var pwKey = Crypt.getKey(event.password);
        var encryptionKey =
            await Crypt.aesGCMDecrypt(pwKey, encryptedEncryptionKey);

        authenticationBloc
            .add(AuthenticationLoggedIn(encryptionKey: encryptionKey));
        yield LoginInitial();
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }
}
