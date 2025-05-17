import 'package:chatapp/core/common/widgets/app_text.dart';
import 'package:chatapp/features/profile/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.search)),
        title: AppText(text: "Messages", size: 18),
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
    );
  }
}
