import 'package:chatapp/features/auth/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required String id,
    required String name,
    required String email,
    required int number,
  }) : super(id: id, email: email, name: name, number: number);
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'email': email, 'number': number};
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json["name"],
      number: json["number"],
      email: json["email"],
      id: json["id"],
    );
  }
}
