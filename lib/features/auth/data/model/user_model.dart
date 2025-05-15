import 'package:chatapp/features/auth/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required String id,
    required String name,
    required String email,
    required String password,
    required int number,
  }) : super(
         id: id,
         email: email,
         name: name,
         number: number,
         password: password,
       );
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'number': number,
      'password': password,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json["name"],
      password: json["password"],
      number: json["number"],
      email: json["email"],
      id: json["id"],
    );
  }
}
