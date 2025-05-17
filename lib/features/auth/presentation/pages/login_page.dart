import 'package:chatapp/di/injection.dart';
import 'package:chatapp/features/auth/presentation/getx/controller/auth_controller.dart';
import 'package:chatapp/features/auth/presentation/pages/signup_page.dart';
import 'package:chatapp/core/common/widgets/app_button.dart';
import 'package:chatapp/core/common/widgets/app_text.dart';
import 'package:chatapp/features/auth/presentation/widgets/auth_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Loginpage extends StatelessWidget {
  final authController = sl<AuthController>();
  final _formKey = GlobalKey<FormState>();

  Loginpage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText(text: "CHATTER", size: 22),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        margin: EdgeInsets.only(top: 50),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              AppText(text: "Welcome back"),
              AuthField(
                hint: "Email",
                controller: authController.emailController,
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? "Please enter your email"
                            : null,
              ),
              SizedBox(height: 20),
              AuthField(
                hint: "Password",
                isObscureText: true,
                controller: authController.passwordController,
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? "Please enter your password"
                            : null,
              ),
              SizedBox(height: 20),
              Obx(
                () => AppButton(
                  isLoading: authController.isLoading.value,
                  width: 70,
                  height: 30,
                  color: Colors.blue,
                  text: "Log In",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      authController.login();
                    }
                  },
                ),
              ),
              SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  text: "Don't have an account?",
                  style: Theme.of(context).textTheme.titleMedium,
                  children: [
                    TextSpan(
                      recognizer:
                          TapGestureRecognizer()
                            ..onTap = () {
                              Get.to(SignupPage());
                            },
                      text: "Create Account",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.orangeAccent,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
