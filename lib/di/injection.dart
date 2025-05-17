import 'package:chatapp/features/auth/data/repository/auth_repository_imp.dart';
import 'package:chatapp/features/auth/data/repository/user_repository_imp.dart';
import 'package:chatapp/features/auth/data/sources/auth_remote_data_source.dart';
import 'package:chatapp/features/auth/data/sources/user_remote.data_source.dart';
import 'package:chatapp/features/auth/domain/repository/auth_repository.dart';
import 'package:chatapp/features/auth/domain/repository/user_repository.dart';
import 'package:chatapp/features/auth/domain/usecase/get_current_user_usecase.dart';
import 'package:chatapp/features/auth/domain/usecase/login_user_usecase.dart';
import 'package:chatapp/features/auth/domain/usecase/save_user_data_usecase.dart';
import 'package:chatapp/features/auth/domain/usecase/signup_user_usecase.dart';
import 'package:chatapp/features/auth/presentation/getx/controller/auth_controller.dart';
import 'package:chatapp/service/firebase_auth_service.dart';
import 'package:chatapp/service/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance; // get_it instance for service locator

Future<void> setupServiceLocator() async {
  // Firebase services
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);

  // FirebaseAuthService & FirestoreService
  sl.registerLazySingleton(() => FirebaseAuthService(sl<FirebaseAuth>()));
  sl.registerLazySingleton(() => FirestoreService(sl(), fireStore: sl()));
  // sl.registerLazySingleton(() => FirestoreService(fireStore: sl()));

  // Remote Data Sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl(), sl()),
  );
  // sl.registerLazySingleton<AuthRemoteDataSource>(
  //   () => AuthRemoteDataSourceImpl(sl()),
  // );

  sl.registerLazySingleton<UserRemotedataSource>(
    () => UserRemoteDataSourceImp(firestoreService: sl()),
  );

  // Repositories (after data sources!)
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImp(sl()));

  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImp(userRemoteDataSource: sl()),
  );

  // Usecases
  sl.registerLazySingleton(() => LoginUserUsecase(repository: sl()));
  sl.registerLazySingleton(() => SignupUserUsecase(repository: sl()));
  sl.registerLazySingleton(() => SaveUserDataUsecase(sl()));
  sl.registerLazySingleton(() => GetCurrentUserUsecase(userRepository: sl()));

  // Controller
  sl.registerLazySingleton(
    () => AuthController(
      loginUseCase: sl(),
      signupUseCase: sl(),
      saveUserDataUseCase: sl(),
      getCurrentUserUseCase: sl(),
    ),
  );
}

// get_it is a service locator for flutter
// it helps us to access class (like service ,controller, repository) from anywhere in the app without passing them around manually
// it centralized the code


 // sl.registerLazySingleton :created and stores instance only first time when it is called not immediatly when app starts ,it created first when u need it

  //   registerSingleton() :		Creates and stores the instance immediately when the app starts

  // registerFactory() :	Creates a new instance every time you ask

