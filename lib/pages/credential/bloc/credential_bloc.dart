import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:items_repository/items_repository.dart';
import 'package:meta/meta.dart';
import 'package:passline/authentication/authentication_bloc.dart';
import 'package:passline/crypt/crypt.dart';
import 'package:user_repository/user_repository.dart';

part 'credential_event.dart';
part 'credential_state.dart';

class CredentialBloc extends Bloc<CredentialEvent, CredentialState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  CredentialBloc({
    @required this.userRepository,
    @required this.authenticationBloc,
  })  : assert(userRepository != null),
        assert(authenticationBloc != null);

  @override
  CredentialState get initialState => CredentialInitial();

  @override
  Stream<CredentialState> mapEventToState(CredentialEvent event) async* {
    if (event is CredentialDecrypt) {
      yield* _mapCredentialDecryptToState(event);
    }
  }

  Stream<CredentialState> _mapCredentialDecryptToState(
      CredentialDecrypt event) async* {
    var encryptionKey = await this.userRepository.getKey();
    try {
      var password = await Crypt.decryptCredentials(
          encryptionKey, event.credential.password);
      yield CredentialDecryptionSuccess(password: password);
    } catch (e) {
      yield CredentialDecryptionError(error: "Unable to decrypt credential");
    }
  }
}
