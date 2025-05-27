import 'package:chatapp/core/common/widgets/app_text.dart';
import 'package:chatapp/di/injection.dart';
import 'package:chatapp/features/addnewcontact/presentation/getx/contact_controller.dart';
import 'package:chatapp/features/messages/presentation/pages/message_details_page.dart';
import 'package:chatapp/features/profile/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

class ContactPage extends StatelessWidget {
  final contactsController = sl<ContactController>();

  // if(contact == null || contact.isEmpty) {
  //   print("No contacts available");
  //   return;
  // }
  ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.search)),
        title: AppText(text: "Contact", size: 18),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(ProfilePage());
            },
            icon: Icon(Icons.person),
          ),
        ],
      ),
      body: Obx(() {
        final contacts = contactsController.allContacts.value;
        if (contacts == null) {
          return Center(child: Text("No contacts available"));
        }
        return ListView.builder(
          itemCount: contacts.length,
          itemBuilder: (context, index) {
            final contact = contacts[index];
            return ListTile(
              onTap: () {
                print("this contact is coming ${contact}");
                Get.to(
                  MessageDetailsPage(
                    receiverId: contact.id,
                    receiverName: contact.name,
                  ),
                );
              },
              leading: CircleAvatar(child: Text(contact.name[0].toUpperCase())),
              title: Text(contact.name),
            );
          },
        );
      }),
    );
  }
}
