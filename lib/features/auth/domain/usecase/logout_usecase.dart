import 'package:chatapp/features/auth/domain/repository/auth_repository.dart';

class LogoutUsecase {
  final AuthRepository repository;
  LogoutUsecase({required this.repository});
  Future<void> call() async {
    await repository.logout();
  }
}
