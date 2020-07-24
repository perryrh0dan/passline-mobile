import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passline_mobile/crypt/crypt.dart';
import 'package:passline_mobile/pages/home/bloc/home_bloc.dart';
import 'package:user_repository/user_repository.dart';

part 'setup_event.dart';
part 'setup_state.dart';

class SetupBloc extends Bloc<SetupEvent, SetupState> {
  final UserRepository userRepository;
  final HomeBloc homeBloc;

  SetupBloc({@required this.userRepository, @required this.homeBloc}) : super(SetupInitial());

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
      this.homeBloc.add(LoadItems());
    } catch (e) {
      yield SetupFailure(error: "Wrong master key");
    }
  }
}
