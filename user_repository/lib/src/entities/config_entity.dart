import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ConfigEntity extends Equatable {
  final String key;

  const ConfigEntity(this.key);

  Map<String, Object> toJson() {
    return {
      "key": key,
    };
  }

  @override
  List<Object> get props => [key];

  @override
  String toString() {
    return 'ConfigEntity { key: $key}';
  }

  static ConfigEntity fromJson(Map<dynamic, dynamic> json) {
    return ConfigEntity(
      json["Key"] as String,
    );
  }

  static ConfigEntity fromSnapshot(DocumentSnapshot snap) {
    return ConfigEntity(
      snap.data['Key'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      "key": key
    };
  }
}
