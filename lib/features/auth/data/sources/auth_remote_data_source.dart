import 'package:chatapp/features/auth/domain/entities/user.dart' as appUser;
import 'package:chatapp/service/firebase_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRemoteDataSource {
  Future<appUser.User> signUp(String email, String password);
  Future<appUser.User> login(String email, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuthService _firebaseAuthService;
  AuthRemoteDataSourceImpl(this._firebaseAuthService);

  @override
  Future<appUser.User> signUp(String email, String password) async {
    final userCredential = await _firebaseAuthService.signupUser(
      email,
      password,
    );
    final fbUser = userCredential.user!;
    return appUser.User(
      id: fbUser.uid,
      email: fbUser.email ?? '',
      name: fbUser.displayName ?? '',
      password: '', // Firebase doesn't return password
      number: 0, // Optional: fetch from Firestore if needed
    );
  }

  @override
  Future<appUser.User> login(String email, String password) async {
    final userCredential = await _firebaseAuthService.loginUser(
      email,
      password,
    );
    final fbUser = userCredential.user!;
    return appUser.User(
      id: fbUser.uid,
      email: fbUser.email ?? '',
      name: fbUser.displayName ?? '',
      password: '',
      number: 0,
    );
  }
}
