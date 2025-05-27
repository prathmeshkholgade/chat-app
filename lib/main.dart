import 'package:chatapp/core/theme/theme.dart';
import 'package:chatapp/di/injection.dart';
import 'package:chatapp/features/auth/domain/entities/user.dart';
import 'package:chatapp/features/auth/presentation/getx/bindings/auth_binding.dart';
import 'package:chatapp/features/auth/presentation/getx/controller/auth_controller.dart';
import 'package:chatapp/features/auth/presentation/pages/login_page.dart';
import 'package:chatapp/features/auth/presentation/pages/signup_page.dart';
import 'package:chatapp/features/home/presentation/pages/home_page.dart';
import 'package:chatapp/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/route_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // AuthBinding().dependencies();  instead of authBinding we used Get_it service locator

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final authController = Get.put(sl<AuthController>());
  final user = FirebaseAuth.instance.currentUser;

  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    print("logged in user $user");
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkThemMode,
      home: user != null ? HomePage() : SignupPage(),
    );
  }
}
