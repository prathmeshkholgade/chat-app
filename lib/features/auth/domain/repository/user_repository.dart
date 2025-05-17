import 'package:chatapp/core/error/failure.dart';
import 'package:chatapp/features/auth/data/model/user_model.dart';
import 'package:chatapp/features/auth/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> saveUserData(UserModel user);
  //  update profile, getUserInfo
}
