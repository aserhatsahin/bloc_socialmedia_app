//handling backend calls
import 'package:equatable/equatable.dart';

class MyUserEntity extends Equatable {
  final String id;
  final String email;
  final String name;
  final String? picture;

  const MyUserEntity({
    required this.id,
    required this.email,
    required this.name,
    this.picture,
  });


  /// Converts the MyUserEntity instance into a Map representation.
  /// 
  /// Returns a `Map<String, Object>` containing the user's id, email, name, and picture.

  Map<String, Object> toDocument() {
    return {'id': id, 'email': email, 'name': name, 'picture': picture!};
  }

  static MyUserEntity fromDocument(Map<String, dynamic> doc) {
    //dynamic object farki ?
    return MyUserEntity(
      id: doc['id'] as String,
      email: doc['email'] as String,
      name: doc['name'] as String,
      picture: doc['picture'] as String,
    );
  }

  @override
  List<Object?> get props => [id, email, name, picture];

  @override
  String toString() {
    return '''User Entity : {
id: $id
email: $email
name: $name
picture : $picture

}''';
  }
}
