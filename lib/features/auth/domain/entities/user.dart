import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String email;

  final int number;
  const User({
    required this.email,
    required this.id,
    required this.name,
    required this.number,
  });
  @override
  List<Object?> get props => [id, name, email, number];
}
