import 'package:encrypt/encrypt.dart' as prefix0;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:items_repository/items_repository.dart';
import 'package:passline/blocs/password/password.dart';
import 'package:passline/widgets/dialog.dart';
import 'package:password/password.dart';

class CredentialScreen extends StatelessWidget {
  final Credential credential;

  CredentialScreen({Key key, @required this.credential}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PasswordBloc, PasswordState>(
      builder: (context, state) {
        if (state is Unauthenticated) {
          return new FullScreenDialog();
        } else if (state is Authenticated) {
          return Scaffold(
              appBar: AppBar(
                title: Text(credential.username),
              ),
              body: Text(
                aesGCMDecrypt(generateKey(state.password), credential.password),
              ));
        } else {
          return Container();
        }
      },
    );
  }

  String generateKey(String password) {
    return Password.hash(
        password,
        new PBKDF2(
            blockLength: 32,
            salt: "This is the salt",
            iterationCount: 4096,
            desiredKeyLength: 32));
  }

  String aesGCMDecrypt(String keyString, String text) {
    final key = prefix0.Key.fromUtf8(keyString);
    final encrypter = prefix0.Encrypter(prefix0.AES(key));
    encrypter.encrypt(text);

    return text;
  }
}
