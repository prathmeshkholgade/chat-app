import 'package:chatapp/service/firebase_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;

abstract class AuthRemoteDataSource {
  Future<UserCredential> signUp(String email, String password);
  Future<UserCredential> login(String email, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuthService _firebaseAuthService;
  AuthRemoteDataSourceImpl(this._firebaseAuthService);
  @override
  Future<UserCredential> signUp(String email, String password) {
    return _firebaseAuthService.signupUser(email, password);
  }

  @override
  Future<UserCredential> login(String email, String password) {
    return _firebaseAuthService.loginUser(email, password);
  }
}
