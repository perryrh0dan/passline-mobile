import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passline/crypt/crypt.dart';
import 'package:user_repository/user_repository.dart';

part 'setup_event.dart';
part 'setup_state.dart';

class SetupBloc extends Bloc<SetupEvent, SetupState> {
  final UserRepository userRepository;

  SetupBloc({@required this.userRepository});

  @override
  SetupState get initialState => SetupInitial();

  @override
  Stream<SetupState> mapEventToState(SetupEvent event) async* {
    if (event is SetupButtonPressed) {
      yield* _mapSetupButtonPressToState(event);
    }
  }

  Stream<SetupState> _mapSetupButtonPressToState(
      SetupButtonPressed event) async* {
    yield SetupInProgress();
    try {
      final encryptedEncryptionKey = await userRepository.loadKey();
      var pwKey = Crypt.passwordToKey(event.password);
      var encryptionKey = await Crypt.decryptKey(pwKey, encryptedEncryptionKey);
      userRepository.persistKey(encryptionKey);
    } catch (e) {
      yield SetupFailure(error: "Wrong master key");
    }
  }
}