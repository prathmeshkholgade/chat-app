import 'package:chatapp/core/error/failure.dart';
import 'package:chatapp/features/auth/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

// it's like a contract 
// we define method here and implementation in data layer

// it's interface for auth //  not implementation of logic that's why i i wrote abstract class showing login and signup feature should be implement or done,it dose't care how it will done 

// it's like a menu of restaurant (interface) we are telling here what have to create but not how to create it

abstract interface class AuthRepository {
  Future<Either<Failure, User>> login(String email, String password);
  Future<Either<Failure, User>> signup(String email, String password);
}



// domain layer must be independent 