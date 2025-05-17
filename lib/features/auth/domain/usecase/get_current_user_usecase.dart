import 'package:chatapp/core/error/failure.dart';
import 'package:chatapp/features/auth/domain/entities/user.dart';
import 'package:chatapp/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class GetCurrentUserUsecase {
  final AuthRepository userRepository;
  GetCurrentUserUsecase({required this.userRepository});

  Future<Either<Failure, User>> call() async {
    return await userRepository.getCurrentUser();
  }
}
