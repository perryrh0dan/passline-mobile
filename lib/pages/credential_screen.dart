import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:items_repository/items_repository.dart';
import 'package:passline/blocs/authentication/authentication.dart';
import 'package:passline/crypt/crypt.dart';

class CredentialScreen extends StatelessWidget {
  final Credential credential;

  CredentialScreen({Key key, @required this.credential}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is Authenticated) {
          return Scaffold(
            appBar: AppBar(
              title: Text(credential.username),
            ),
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: FutureBuilder(
                  builder: (context, passwordSnap) {
                    if (passwordSnap.hasData == null) {
                      return Container();
                    } else {
                      Clipboard.setData(ClipboardData(text: passwordSnap.data));
                      return Text(passwordSnap.data);
                    }
                  },
                  future: this.decryptCredentials(
                      state.encryptionKey, credential.password),
                ),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Future<String> decryptCredentials(
      List<int> encryptionKey, String cipherText) {
        return Crypt.decryptCredentials(encryptionKey, cipherText);
  }
}
