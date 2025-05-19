import 'dart:typed_data';

class ContactModel {
  final String name;
  final String phone;
  final Uint8List? photo;

  ContactModel({required this.name, required this.phone, this.photo});
}
