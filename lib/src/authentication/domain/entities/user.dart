import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.avatar,
  });

  const User.empty()
      : this(
    id: "1",
    createdAt: "_empty.createdAt",
    name: "_empty.name",
    avatar: "_empty.avatar",
  );

  final String id;
  final String createdAt;
  final String name;
  final String avatar;

  // @override
  // bool operator == (other){
  //   return identical(this, other) || other is User
  //           && other.runtimeType == runtimeType
  //           && other.id == id
  //       && other.name == name;
  // }
  //
  // @override
  // int get hashCode => id.hashCode ^ name.hashCode;

  @override
  List<Object?> get props => [id, name, avatar];
}

/*void main() {
  const user1 = User(
    id: 1,
    createdAt: "createdAt",
    name: "name1",
    avatar: "avatar",
  );

  const user2 = User(
    id: 1,
    createdAt: "createdAt",
    name: "name2",
    avatar: "avatar",
  );

  if (kDebugMode) {
    print((user1 == user2).toString());
  }
}*/
