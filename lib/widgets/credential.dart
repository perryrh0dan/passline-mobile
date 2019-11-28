import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:items_repository/items_repository.dart';

class CredentialWidget extends StatelessWidget {
  final Credential credential;

  CredentialWidget({Key key, @required this.credential}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('__item_item_${credential.username}'),
      child: ListTile(
        title: Hero(
          tag: '${credential.username}__heroTag',
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Text(
              credential.username,
              style: Theme.of(context).textTheme.title,
            ),
          ),
        ),
        subtitle: Text(
          credential.password,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.subhead,
        ),
      ),
    );
  }
}
