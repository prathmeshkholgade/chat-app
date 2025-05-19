import 'package:chatapp/core/error/failure.dart';
import 'package:chatapp/features/addnewcontact/data/source/remote_contact_data_source.dart';
import 'package:chatapp/features/addnewcontact/domain/repository/contact_repository.dart';
import 'package:dartz/dartz.dart';

class ContactRepoImp implements ContactRepository {
  final RemoteContactDataSource remoteContactDataSource;
  ContactRepoImp({required this.remoteContactDataSource});
  @override
  Future<Either<Failure, Map<String, dynamic>>> getRegisteredContacts() {
    return remoteContactDataSource.getContact();
  }
}
