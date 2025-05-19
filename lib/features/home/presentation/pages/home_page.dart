import 'package:chatapp/di/injection.dart';
import 'package:chatapp/features/addnewcontact/presentation/getx/contact_controller.dart';
import 'package:chatapp/features/addnewcontact/presentation/pages/add_new_contact_page.dart';
import 'package:chatapp/features/calls/pages/call_history_page.dart';
import 'package:chatapp/features/contacts/pages/contact_page.dart';
import 'package:chatapp/features/home/presentation/getx/controller/home_controller.dart';
import 'package:chatapp/features/messages/pages/message_page.dart';
import 'package:chatapp/features/notifications/pages/notfication_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());
  final contactControll = sl<ContactController>();
  HomePage({super.key});
  final List<Widget> pages = [
    MessagePage(),
    NotificationPage(),
    Placeholder(),
    CallHistoryPage(),
    ContactPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: pages[controller.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.currentIndex,
          // backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            if (index == 2) {
              contactControll.getContacts();
              return showContactsDialog(context);
            }
            controller.onItemTapped(index);
          },
          selectedItemColor: const Color.fromARGB(221, 24, 179, 179),
          selectedFontSize: 0,
          unselectedFontSize: 0,
          showUnselectedLabels: false,
          unselectedItemColor: Colors.grey.withAlpha(150),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.message),
              label: "Message",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notification_add),
              label: "Notification",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.add), label: "add"),
            BottomNavigationBarItem(icon: Icon(Icons.call), label: "Calls"),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_2_outlined),
              label: "Contacts",
            ),
          ],
        ),
      ),
    );
  }
}
