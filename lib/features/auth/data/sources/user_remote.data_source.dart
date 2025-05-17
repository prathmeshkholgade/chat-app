import 'package:chatapp/core/error/failure.dart';
import 'package:chatapp/features/auth/data/model/user_model.dart';
import 'package:chatapp/features/auth/domain/entities/user.dart';
import 'package:chatapp/service/firestore_service.dart';
import 'package:dartz/dartz.dart';

abstract class UserRemotedataSource {
  Future<Either<Failure, UserModel>> saveUserData(UserModel user);
}

class UserRemoteDataSourceImp implements UserRemotedataSource {
  final FirestoreService firestoreService;
  UserRemoteDataSourceImp({required this.firestoreService});
  @override
  Future<Either<Failure, UserModel>> saveUserData(UserModel user) async {
    try {
      final result = await firestoreService.saveDataInDb(user);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
