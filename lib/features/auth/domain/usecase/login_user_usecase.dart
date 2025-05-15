import 'package:chatapp/core/error/failure.dart';
import 'package:chatapp/features/auth/domain/entities/user.dart';
import 'package:chatapp/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class LoginUserUsecase {
  final AuthRepository repository;
  LoginUserUsecase({required this.repository});
  Future<Either<Failure, User>> call({
    required String email,
    required String password,
  }) {
    // no logic here just forward call to repository
    return repository.login(email, password);
  }
}
