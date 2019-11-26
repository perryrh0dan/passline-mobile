import 'package:meta/meta.dart';
import '../entities/entities.dart';

@immutable
class Item {
  final String name;

  Item(this.name);

  Item copyWith({String name}) {
    return Item(
      name ?? this.name
    );
  }

  @override
  int get hashCode =>
      name.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Item &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  String toString() {
    return 'Item{name: $name}';
  }

  ItemEntity toEntity() {
    return ItemEntity(name);
  }

  static Item fromEntity(ItemEntity entity) {
    return Item(
      entity.name
    );
  }
}
