import 'package:chatapp/features/addnewcontact/data/repositories/contact_repo_imp.dart';
import 'package:chatapp/features/addnewcontact/data/source/remote_contact_data_source.dart';
import 'package:chatapp/features/addnewcontact/domain/repository/contact_repository.dart';
import 'package:chatapp/features/addnewcontact/domain/usecase/get_contacts.usecase.repo.dart';
import 'package:chatapp/features/addnewcontact/presentation/getx/contact_controller.dart';
import 'package:chatapp/features/auth/data/repository/auth_repository_imp.dart';
import 'package:chatapp/features/auth/data/repository/user_repository_imp.dart';
import 'package:chatapp/features/auth/data/sources/auth_remote_data_source.dart';
import 'package:chatapp/features/auth/data/sources/user_remote.data_source.dart';
import 'package:chatapp/features/auth/domain/repository/auth_repository.dart';
import 'package:chatapp/features/auth/domain/repository/user_repository.dart';
import 'package:chatapp/features/auth/domain/usecase/get_current_user_usecase.dart';
import 'package:chatapp/features/auth/domain/usecase/login_user_usecase.dart';
import 'package:chatapp/features/auth/domain/usecase/logout_usecase.dart';
import 'package:chatapp/features/auth/domain/usecase/save_user_data_usecase.dart';
import 'package:chatapp/features/auth/domain/usecase/signup_user_usecase.dart';
import 'package:chatapp/features/auth/presentation/getx/controller/auth_controller.dart';
import 'package:chatapp/features/messages/data/repository/chat_repo_imp.dart';
import 'package:chatapp/features/messages/data/source/chat_remote_data_sorce.dart';
import 'package:chatapp/features/messages/data/source/get_more_msg_remote_data_source.dart';
import 'package:chatapp/features/messages/data/source/get_msg_remote_data_source.dart';
import 'package:chatapp/features/messages/data/source/send_msg_remote_data_source.dart';
import 'package:chatapp/features/messages/domain/repository/chat_repository.dart';
import 'package:chatapp/features/messages/domain/usecase/get_chat_room.usecase.dart';
import 'package:chatapp/features/messages/domain/usecase/get_more_msg_usecase.dart';
import 'package:chatapp/features/messages/domain/usecase/get_msg_usecase.dart';
import 'package:chatapp/features/messages/domain/usecase/send_msg_usecase.dart';
import 'package:chatapp/features/messages/presentation/getx/message_chat_controller.dart';
import 'package:chatapp/service/firebase_auth_service.dart';
import 'package:chatapp/service/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
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
  sl.registerLazySingleton<RemoteContactDataSource>(
    () => RemoteContactDataSourceImpl(),
  );

  // Repositories (after data sources!)
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImp(sl()));

  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImp(userRemoteDataSource: sl()),
  );
  sl.registerLazySingleton<ContactRepository>(
    () => ContactRepoImp(remoteContactDataSource: sl()),
  );

  // Usecases
  sl.registerLazySingleton(() => LoginUserUsecase(repository: sl()));
  sl.registerLazySingleton(() => SignupUserUsecase(repository: sl()));
  sl.registerLazySingleton(() => SaveUserDataUsecase(sl()));
  sl.registerLazySingleton(() => GetCurrentUserUsecase(userRepository: sl()));
  sl.registerLazySingleton(() => LogoutUsecase(repository: sl()));
  sl.registerLazySingleton(() => GetContactsUsecase(repository: sl()));
  // Controller
  sl.registerLazySingleton(
    () => AuthController(
      loginUseCase: sl(),
      signupUseCase: sl(),
      saveUserDataUseCase: sl(),
      getCurrentUserUseCase: sl(),
      logoutUseCase: sl(),
    ),
  );
  sl.registerLazySingleton(() => ContactController(getContactsUsecase: sl()));

  // dependency for chatmessage
  sl.registerLazySingleton<ChatRepository>(
    () => ChatRepoImp(
      sendMsgRemoteDataSource: sl(),
      chatRemoteDataSorce: sl(),
      getMsgRemoteDataSource: sl(),
      getMoreMsgRemoteDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<SendMsgRemoteDataSource>(
    () => SendMsgRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<ChatRemoteDataSorce>(
    () => ChatRemoteDataSorceImpl(),
  );
  sl.registerLazySingleton<GetMsgRemoteDataSource>(
    () => GetMsgeRemoteDataSourceImp(),
  );
  sl.registerLazySingleton<GetMoreMsgRemoteDataSource>(
    () => GetMoreMsgRemoteDataSourceImp(),
  );
  sl.registerLazySingleton(() => SendMsgUseCase(chatRepository: sl()));
  sl.registerLazySingleton(() => GetChatRoomUseCase(chatRepository: sl()));
  sl.registerLazySingleton<GetMsgUsecase>(
    () => GetMsgUsecase(chatRepository: sl()),
  );
  sl.registerLazySingleton(()=>GetMoreMsgUsecase(chatRepository: sl()));

  sl.registerLazySingleton(
    () => MessageChatController(
      sendMsgUseCase: sl(),
      getChatRoomUseCase: sl(),
      getMsgUseCase: sl(),
      getMoreMsgUsecase: sl(),
    ),
  );
}

// get_it is a service locator for flutter
// it helps us to access class (like service ,controller, repository) from anywhere in the app without passing them around manually
// it centralized the code


 // sl.registerLazySingleton :created and stores instance only first time when it is called not immediatly when app starts ,it created first when u need it

  //   registerSingleton() :		Creates and stores the instance immediately when the app starts

  // registerFactory() :	Creates a new instance every time you ask

