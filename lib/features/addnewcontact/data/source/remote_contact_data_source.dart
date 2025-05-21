import 'dart:typed_data';

import 'package:chatapp/core/error/failure.dart';
import 'package:chatapp/di/injection.dart';
import 'package:chatapp/features/addnewcontact/domain/model/contact_model.dart';
import 'package:chatapp/features/auth/presentation/getx/controller/auth_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

abstract class RemoteContactDataSource {
  Future<Either<Failure, Map<String, dynamic>>> getContact();
}

class RemoteContactDataSourceImpl implements RemoteContactDataSource {
  final fireStore = sl<FirebaseFirestore>();
  final authController = sl<AuthController>();

  String normalizePhone(String phone) {
    return phone.replaceAll(RegExp(r'\D'), '').replaceFirst(RegExp(r'^0+'), '');
  }

  Future<Either<Failure, Map<String, dynamic>>> getContact() async {
    try {
      final permissionGranted = await FlutterContacts.requestPermission();
      if (!permissionGranted) {
        return Left(ServerFailure("Contact permission not granted"));
      }

      final contacts = await FlutterContacts.getContacts(
        withProperties: true,
        withPhoto: true,
      );

      print(
        "this is the current logged in user ${authController.user.value!.id}",
      );

      final normalizedContacts =
          contacts
              .where((contact) => contact.phones.isNotEmpty)
              .map(
                (contact) => {
                  'name': contact.displayName,
                  'phone': normalizePhone(contact.phones.first.number),
                  'photo': contact.photo,
                },
              )
              .toList();
      print("this is the normalized contact $normalizedContacts");

      final userSnapshot = await fireStore.collection("users").get();

      final registeredUsers =
          userSnapshot.docs
              .map((doc) => doc.data())
              .where((data) => data.containsKey('number'))
              .toList();

      final matchedContacts =
          normalizedContacts
              .where((contact) {
                String phoneNumber = normalizePhone(
                  contact['phone']?.toString() ?? '',
                );

                return registeredUsers.any((user) {
                  String userNumber = normalizePhone(user['number'].toString());

                  final isBothNumberSame = userNumber == phoneNumber;

                  final isUserDifferent =
                      user["id"] != authController.user.value!.id;

                  return isBothNumberSame && isUserDifferent;
                });
              })
              .map((contact) {
                String phoneNumber = normalizePhone(
                  contact['phone']?.toString() ?? '',
                );

                final matchedUser = registeredUsers.firstWhere((user) {
                  String userNumber = normalizePhone(user['number'].toString());
                  return userNumber == phoneNumber;
                });
                print(matchedUser);
                return ContactModel(
                  id: matchedUser["id"],
                  name: contact["name"] as String? ?? '',
                  phone: contact["phone"] as String? ?? '',
                  photo: contact["photo"] as Uint8List?,
                );
              })
              .toList();

      return Right({"matchedContacts": matchedContacts});
    } catch (e) {
      return Left(ServerFailure("Error fetching contacts: ${e.toString()}"));
    }
  }
}
