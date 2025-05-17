import 'package:chatapp/core/common/widgets/app_text.dart';
import 'package:chatapp/di/injection.dart';
import 'package:chatapp/features/auth/presentation/getx/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  final authController = sl<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: AppText(text: "Profile"), centerTitle: true),
      body: Obx(() {
        final user = authController.user.value;

        if (user == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                const SizedBox(height: 20),
                SizedBox(
                  width: 100,
                  height: 100,
                  child: const CircleAvatar(
                    child: Icon(Icons.person, size: 60),
                  ),
                ),
                const SizedBox(height: 10),
                Text(user.name.isNotEmpty ? user.name : "User"),
                const SizedBox(height: 10),
                Text(user.email),
                SizedBox(height: 10),
                TextButton(onPressed: () {
                  authController.logout();
                }, child: Text("Sign Out")),
              ],
            ),
          ],
        );
      }),
    );
  }
}
