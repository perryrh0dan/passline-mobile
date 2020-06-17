import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:items_repository/items_repository.dart';
import 'package:passline/blocs/password/password.dart';
import 'package:passline/widgets/dialog.dart';
import 'package:passline/crypt/crypt.dart';

class CredentialScreen extends StatelessWidget {
  final Credential credential;

  CredentialScreen({Key key, @required this.credential}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PasswordBloc, PasswordState>(
      builder: (context, state) {
        if (state is Unauthenticated) {
          return new PasswordDialogState();
        } else if (state is Authenticated) {
          return Scaffold(
              appBar: AppBar(
                title: Text(credential.username),
              ),
              body: FutureBuilder(
                builder: (context, passwordSnap) {
                  if (passwordSnap.hasData == null) {
                    return Container();
                  }
                  return Text(passwordSnap.data);
                },
                future: this.decryptCredentials(state.encryptionKey, credential.password),
              ));
        } else {
          return Container();
        }
      },
    );
  }

  Future<String> decryptCredentials(String encryptionKey, String cipherText) {
    var encryptionKeyBytes = Uint8List.fromList(encryptionKey.codeUnits);
    return Crypt.decryptCredentials(encryptionKeyBytes, cipherText);
  }
}
