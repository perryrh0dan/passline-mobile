import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:config_repository/config_repository.dart';
import 'package:passline/blocs/password/password.dart';
import 'package:passline/crypt/crypt.dart';

class PasswordBloc extends Bloc<PasswordEvent, PasswordState> {
  final ConfigRepository configRepository;

  PasswordBloc({
    @required this.configRepository,
  })  : assert(configRepository != null);

  @override
  PasswordState get initialState => Unauthenticated();

  @override
  Stream<PasswordState> mapEventToState(PasswordEvent event) async* {
    if (event is Authenticate) {
      try {
        final encryptedEncryptionKey = await configRepository.key(); 
        var pwKey = Crypt.getKey(event.password);
        var encryptionKey = await Crypt.aesGCMDecrypt(pwKey, encryptedEncryptionKey);
        yield Authenticated(String.fromCharCodes(encryptionKey));
      } catch (e) {
        yield Unauthenticated();
      }
    }
  }
}
