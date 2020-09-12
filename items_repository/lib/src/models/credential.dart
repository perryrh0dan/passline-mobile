import 'package:meta/meta.dart';
import '../entities/entities.dart';

@immutable
class Credential {
  final String username;
  final String password;

  Credential(this.username, this.password);

  Credential copyWith({String username}) {
    return Credential(
      username ?? this.username,
      password ?? this.password
    );
  }

  @override
  int get hashCode =>
      username.hashCode ^ password.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Credential &&
          runtimeType == other.runtimeType &&
          username == other.username &&
          password == other.password;

  @override
  String toString() {
    return 'Credential{Username: $username, Password: $password}';
  }

  CredentialEntity toEntity() {
    return CredentialEntity(username, password);
  }

  static Credential fromEntity(CredentialEntity entity) {
    return Credential(
      entity.username,
      entity.password
    );
  }
}
