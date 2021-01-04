import 'package:flutter/material.dart';
import 'package:items_repository/items_repository.dart';
import 'package:passline_mobile/pages/credential/credential.dart';
import 'package:passline_mobile/pages/credential/credential_page.dart';

class Credentials extends StatelessWidget {
  final Item item;
  final List<Credential> credentials;

  const Credentials({Key key, @required this.item, @required this.credentials})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(5.0),
      itemCount: credentials.length,
      itemBuilder: (context, index) {
        final credential = credentials[index];
        return CredentialWidget(
            credential: credential,
            onTap: () async {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => CredentialPage(
                        item: item,
                        credential: credential,
                      )));
            });
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }
}
