import 'package:chatapp/features/auth/data/model/user_model.dart';
import 'package:chatapp/features/auth/domain/entities/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore fireStore;
  final FirebaseAuth auth;
  FirestoreService(this.auth, {required this.fireStore});
  Future<UserModel> saveDataInDb(UserModel user) async {
    try {
      print("this is the user we saving in db $user");
      print("Saving user to Firestore with ID: ${user.id}");
      await fireStore.collection("users").doc(user.id).set(user.toJson());
      final currentUser = auth.currentUser;
      print(currentUser);
      return user;
    } catch (e) {
      print("Error saving user to Firestore: $e");
      rethrow;
    }
  }

  Future<UserModel?> getCurrentUser() async {
    final currentUser = auth.currentUser;
    print("this is the current logged  in user $currentUser");
    try {
      final user =
          await fireStore.collection("users").doc(currentUser!.uid).get();
      if (!user.exists) return null;
      return UserModel.fromJson(user.data()!);
    } catch (e) {
      print("Error getting current user: $e");
      rethrow;
    }
  }
}
