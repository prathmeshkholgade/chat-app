import 'package:chatapp/core/error/failure.dart';
import 'package:chatapp/features/auth/domain/entities/user.dart';
import 'package:chatapp/features/auth/domain/usecase/login_user_usecase.dart';
import 'package:chatapp/features/auth/domain/usecase/signup_user_usecase.dart';
import 'package:chatapp/features/home/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final SignupUserUsecase signupUseCase;
  final LoginUserUsecase loginUseCase;
  AuthController({required this.loginUseCase, required this.signupUseCase});
  var isLoading = false.obs;
  var authFailure = Rxn<Failure>();
  var user = Rxn<User>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final numberController = TextEditingController();

  Future<void> signup() async {
    isLoading.value = true;
    authFailure.value = null;
    final result = await signupUseCase(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
    result.fold(
      (failure) {
        authFailure.value = failure;
        Get.snackbar("Login Failed", failure.message);
      },
      (userEntity) {
        user.value = userEntity;
        Get.offAll(HomePage());
      },
    );
    isLoading.value = false;
  }

  Future<void> login() async {
    isLoading.value = true;
    authFailure.value = null;
    final result = await loginUseCase(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
    result.fold(
      (failure) {
        authFailure.value = failure;
        Get.snackbar("Login Failed", failure.message);
      },
      (userEntity) {
        user.value = userEntity;
        Get.offAll(HomePage());
      },
    );
    isLoading.value = false;
  }
}
