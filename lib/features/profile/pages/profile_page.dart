import 'package:chatapp/core/common/widgets/app_text.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: AppText(text: "Profile")),
      body: Column(children: []),
    );
  }
}
