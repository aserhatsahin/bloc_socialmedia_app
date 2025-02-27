//user class
import 'package:equatable/equatable.dart';
import 'package:user_repository/src/entities/my_user_entity.dart';

class MyUser extends Equatable {
  final String id;
  final String email;
  final String name;
  final String? picture;

  const MyUser({
    required this.id,
    required this.email,
    required this.name,
    this.picture,
  });

  /// Empty user which represents an unauthenticated user.
  static var empty = MyUser(id: '', email: '', name: '', picture: '');

  //Modify MyUser parameters
  MyUser copyWith({String? id, String? email, String? name, String? picture}) {
    return MyUser(
      id: id ?? this.id,
      email: email ?? this.id,
      name: name ?? this.name,
      picture: picture ?? this.picture,
    );
  }

  // getter to determine whether the current user is empty
  bool get isEmpty => this == MyUser.empty;
  //getter to determine whether the current user is not empty
  bool get isNotEmpty => this != MyUser.empty;

  //transform user object into MyUserEntity object useful for transforming to JSon
  MyUserEntity toEntity() {
    return MyUserEntity(id: id, email: email, name: name, picture: picture);
  }

  //take json and transform to MyUserEntity  and then to MyUser
  static MyUser fromEntity(MyUserEntity entity) {
    return MyUser(
      id: entity.id,
      email: entity.email,
      name: entity.name,
      picture: entity.picture,
    );
  }

  @override
  List<Object?> get props => [id, email, name, picture];
}
