import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:items_repository/items_repository.dart';
import 'package:passline/authentication/authentication_bloc.dart';
import 'package:passline/crypt/crypt.dart';
import 'package:passline/pages/credential/bloc/credential_bloc.dart';
import 'package:user_repository/user_repository.dart';

class CredentialPage extends StatelessWidget {
  final Credential credential;

  CredentialPage({Key key, @required this.credential}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return CredentialBloc(
          authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
          userRepository: FirebaseUserRepository(),
        )..add(CredentialDecrypt(credential: this.credential));
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(credential.username),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {},
            ),
          ],
        ),
        body: BlocListener<CredentialBloc, CredentialState>(
          listener: (context, state) {
            if (state is CredentialDecryptionSuccess) {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text('Successful copied to clipboard'),
              ));
            }
            if (state is CredentialDecryptionError) {
              Scaffold.of(context).showSnackBar(
                  SnackBar(content: Text('Error decrypting password')));
            }
          },
          child: BlocBuilder<CredentialBloc, CredentialState>(
            builder: (context, state) {
              if (state is CredentialDecryptionSuccess) {
                return SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(state.password),
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Future<String> decryptCredentials(
      List<int> encryptionKey, String cipherText) {
    return Crypt.decryptCredentials(encryptionKey, cipherText);
  }
}
