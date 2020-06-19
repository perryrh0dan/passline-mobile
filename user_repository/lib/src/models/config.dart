import 'package:meta/meta.dart';
import '../entities/entities.dart';

@immutable
class Config {
  final String key;

  Config(this.key);

  Config copyWith() {
    return Config(key ?? this.key);
  }

  @override
  int get hashCode => key.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Config && runtimeType == other.runtimeType && key == other.key;

  @override
  String toString() {
    return 'Config{key: $key}';
  }

  ConfigEntity toEntity() {
    return ConfigEntity(key);
  }

  static Config fromEntity(ConfigEntity entity) {
    return Config(entity.key);
  }
}
