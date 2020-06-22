import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:items_repository/items_repository.dart';

class CredentialWidget extends StatelessWidget {
  final Credential credential;
  final GestureTapCallback onTap;

  CredentialWidget({Key key, @required this.credential, @required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Hero(
        tag: '${credential.username}__heroTag',
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Text(
            credential.username,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
      ),
      trailing:
          Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
    );
  }
}
