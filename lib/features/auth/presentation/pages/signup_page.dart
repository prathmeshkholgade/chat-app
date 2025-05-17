import 'package:chatapp/di/injection.dart';
import 'package:chatapp/features/auth/presentation/getx/controller/auth_controller.dart';
import 'package:chatapp/features/auth/presentation/pages/login_page.dart';
import 'package:chatapp/core/common/widgets/app_button.dart';
import 'package:chatapp/core/common/widgets/app_text.dart';
import 'package:chatapp/features/auth/presentation/widgets/auth_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

class SignupPage extends StatelessWidget {
  final authController = sl<AuthController>();
  final _formKey = GlobalKey<FormState>();

  SignupPage({super.key});
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
              AppText(text: "Register"),
              SizedBox(height: 20),
              AuthField(
                hint: "FullName",
                controller: authController.nameController,
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? "Please enter your fullname"
                            : null,
              ),
              SizedBox(height: 20),
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
                hint: "Mobile Number",
                controller: authController.numberController,
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? "Please enter your mobile number"
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
                            ? "Please enter password"
                            : null,
              ),
              SizedBox(height: 20),
              Obx(
                () => AppButton(
                  width: 70,
                  height: 30,
                  isLoading: authController.isLoading.value,
                  color: Colors.blue,
                  text: "Sign up",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      authController.signup();
                    }
                  },
                ),
              ),
              SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  text: "Already have an account?",
                  style: Theme.of(context).textTheme.titleMedium,
                  children: [
                    TextSpan(
                      text: "Login",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.orangeAccent,
                      ),
                      recognizer:
                          TapGestureRecognizer()
                            ..onTap = () {
                              Get.to(Loginpage());
                            },
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
