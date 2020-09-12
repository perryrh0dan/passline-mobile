import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class CredentialEntity extends Equatable {
  final String username;
  final String password;

  const CredentialEntity(this.username, this.password);

  Map<String, Object> toJson() {
    return {
      "username": username,
      "password": password
    };
  }

  @override
  List<Object> get props => [username, password];

  @override
  String toString() {
    return 'CredentialEntity { username: $username, password: $password}';
  }

  static CredentialEntity fromJson(Map<dynamic, dynamic> json) {
    return CredentialEntity(
      json["Username"] as String,
      json["Password"] as String
    );
  }

  static CredentialEntity fromSnapshot(DocumentSnapshot snap) {
    return CredentialEntity(
      snap.data['Username'],
      snap.data['Password'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      "Username": username,
      "Password": password
    };
  }
}
