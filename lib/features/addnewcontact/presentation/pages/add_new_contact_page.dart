import 'package:chatapp/di/injection.dart';
import 'package:chatapp/features/addnewcontact/presentation/getx/contact_controller.dart';
import 'package:chatapp/features/messages/presentation/pages/message_details_page.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

void showContactsDialog(BuildContext context) {
  final contactsController = sl<ContactController>();
  final contact = contactsController.allContacts.value;

  if (contact == null || contact.isEmpty) {
    print("No contacts available");
    return;
  }

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Select a Contact"),
        content: SizedBox(
          height: 300, // set a fixed height for dialog content
          width: double.maxFinite,

          child: ListView.builder(
            itemCount: contact.length,
            itemBuilder: (context, index) {
              final contactU = contact[index];
              return ListTile(
                onTap: () {
                  print("this contact is coming ${contactU.id}");
                  Get.to(
                    MessageDetailsPage(
                      receiverId: contactU.id,
                      receiverName: contactU.name,
                    ),
                  );
                },
                leading: CircleAvatar(
                  child: Text(contactU.name[0].toUpperCase()),
                ),
                title: Text(contactU.name),
              );
            },
          ),
        ),
      );
    },
  );
}
