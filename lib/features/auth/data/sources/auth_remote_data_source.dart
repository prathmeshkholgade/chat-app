import 'package:chatapp/features/auth/domain/entities/user.dart' as appUser;
import 'package:chatapp/service/firebase_auth_service.dart';
import 'package:chatapp/service/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class AuthRemoteDataSource {
  Future<appUser.User> signUp(String email, String password);
  Future<appUser.User> login(String email, String password);
  Future<appUser.User> getCurrentUser();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuthService _firebaseAuthService;
  final FirestoreService _firebaseFirestore;
  AuthRemoteDataSourceImpl(this._firebaseAuthService, this._firebaseFirestore);

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
      number: 0,
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

      number: 0,
    );
  }

  @override
  Future<appUser.User> getCurrentUser() async {
    final userModel = await _firebaseFirestore.getCurrentUser();

    if (userModel == null) {
      throw Exception("User not found in Firestore");
    }

    // Convert UserModel to appUser.User
    return appUser.User(
      id: userModel.id,
      email: userModel.email,
      name: userModel.name,
      number: userModel.number,
    );
  }
}
