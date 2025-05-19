import 'package:chatapp/di/injection.dart';
import 'package:chatapp/features/addnewcontact/presentation/getx/contact_controller.dart';
import 'package:flutter/material.dart';

void showContactsDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Select a Contact"),
        content: Text("contact will be here"),
      );
    },
  );
}
