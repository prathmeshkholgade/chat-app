import 'package:chatapp/core/error/failure.dart';
import 'package:chatapp/features/addnewcontact/domain/repository/contact_repository.dart';
import 'package:dartz/dartz.dart';

class GetContactsUsecase {
  final ContactRepository repository;
  GetContactsUsecase({required this.repository});
  Future<Either<Failure, Map<String, dynamic>>> call() async {
    return await repository.getRegisteredContacts();
  }
}
