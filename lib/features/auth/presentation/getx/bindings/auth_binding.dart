import 'package:chatapp/features/auth/data/repository/auth_repository_imp.dart';
import 'package:chatapp/features/auth/data/sources/auth_remote_data_source.dart';
import 'package:chatapp/features/auth/domain/usecase/login_user_usecase.dart';
import 'package:chatapp/features/auth/domain/usecase/signup_user_usecase.dart';
import 'package:chatapp/features/auth/presentation/getx/controller/auth_controller.dart';
import 'package:chatapp/service/firebase_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthBinding extends Bindings {
  final firebaseAuthService = FirebaseAuthService(FirebaseAuth.instance);
  @override
  void dependencies() {
    final remoteDataSource = AuthRemoteDataSourceImpl(firebaseAuthService);
    final authRepo = AuthRepositoryImp(remoteDataSource);
    final loginUseCase = LoginUserUsecase(repository: authRepo);
    final signupUseCase = SignupUserUsecase(repository: authRepo);
    Get.lazyPut<AuthController>(
      () => AuthController(
        loginUseCase: loginUseCase,
        signupUseCase: signupUseCase,
      ),
    );
  }
}
