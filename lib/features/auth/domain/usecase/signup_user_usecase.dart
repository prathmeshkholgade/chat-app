import 'package:chatapp/core/error/failure.dart';
import 'package:chatapp/features/auth/domain/entities/user.dart';
import 'package:chatapp/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

// even here also we did't implemented logic of firebase login/signup we just difine it that implementation will be done in  RepositoryImpl in (data layer )

// use cases define what the app should do
// we just calling the method from authRepository

class SignupUserUsecase {
  final AuthRepository repository;
  SignupUserUsecase({required this.repository});
  Future<Either<Failure, User>> call({
    required String email,
    required String password,
  }) {
    // no logic here just forward call to repository
    return repository.signup(email, password);
  }
}
