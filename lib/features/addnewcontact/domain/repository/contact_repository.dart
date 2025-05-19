import 'package:chatapp/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

abstract class ContactRepository {
  // Future<bool> requestContactsPermission() async {
  //   return await FlutterContacts.requestPermission();
  // }
  Future<Either<Failure, Map<String, dynamic>>> getRegisteredContacts();
}
