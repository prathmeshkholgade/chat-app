import 'package:chatapp/core/error/failure.dart';
import 'package:chatapp/features/auth/data/model/user_model.dart';
import 'package:chatapp/features/auth/data/sources/user_remote.data_source.dart';
import 'package:chatapp/features/auth/domain/entities/user.dart';
import 'package:chatapp/features/auth/domain/repository/user_repository.dart';
import 'package:dartz/dartz.dart';

class UserRepositoryImp implements UserRepository {
  final UserRemotedataSource userRemoteDataSource;
  UserRepositoryImp({required this.userRemoteDataSource});
  @override
  Future<Either<Failure, User>> saveUserData(UserModel user) {
    return userRemoteDataSource.saveUserData(user);
  }
}
