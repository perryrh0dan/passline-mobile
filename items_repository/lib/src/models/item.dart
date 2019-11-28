import 'package:items_repository/items_repository.dart';
import 'package:meta/meta.dart';
import '../entities/entities.dart';

@immutable
class Item {
  final String name;
  final List<Credential> credentials;

  Item(this.name, this.credentials);

  Item copyWith({String name}) {
    return Item(name ?? this.name, credentials ?? this.credentials);
  }

  @override
  int get hashCode => name.hashCode ^ credentials.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Item && runtimeType == other.runtimeType && name == other.name;

  @override
  String toString() {
    return 'Item{name: $name}';
  }

  ItemEntity toEntity() {
    List<CredentialEntity> credentials = List<CredentialEntity>();
    for (var i = 0; i < this.credentials.length; i++) {
      credentials.add(this.credentials[i].toEntity());
    }
    return ItemEntity(name, credentials);
  }

  static Item fromEntity(ItemEntity entity) {
    List<Credential> credentials = List<Credential>();
    for (var i = 0; i < entity.credentials.length; i++) {
      credentials.add(Credential.fromEntity(entity.credentials[i]));
    }
    return Item(entity.name, credentials);
  }
}
