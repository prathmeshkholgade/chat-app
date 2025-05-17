import 'package:chatapp/core/error/failure.dart';
import 'package:chatapp/features/auth/data/model/user_model.dart';
import 'package:chatapp/features/auth/domain/entities/user.dart';
import 'package:chatapp/features/auth/domain/repository/user_repository.dart';
import 'package:dartz/dartz.dart';

class SaveUserDataUsecase {
  final UserRepository repository;
  SaveUserDataUsecase(this.repository);
  Future<Either<Failure, User>> call(UserModel user) {
    return repository.saveUserData(user);
  }
}
