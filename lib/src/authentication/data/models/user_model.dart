import 'dart:convert';

import 'package:tdd_flutter/core/utils/typedef.dart';
import 'package:tdd_flutter/src/authentication/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.createdAt,
    required super.name,
    required super.avatar,
  });

  const UserModel.empty()
      : this(
    id: "1",
    createdAt: "_empty.createdAt",
    name: "_empty.name",
    avatar: "_empty.avatar",
  );

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(jsonDecode(source) as DataMap);

  UserModel copyWith({
    String? avatar,
    String? id,
    String? createdAt,
    String? name,
  }) {
    return UserModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
    );
  }

  UserModel.fromMap(DataMap map)
      : this(
    avatar: map['avatar'] as String,
    id: map['id'] as String,
    createdAt: map['createdAt'] as String,
    name: map['name'] as String,
  );

  DataMap toMap() => {
    "id": id,
    "name": name,
    "avatar": avatar,
    "createdAt": createdAt,

  };

  String toJson() => jsonEncode(toMap());
}
