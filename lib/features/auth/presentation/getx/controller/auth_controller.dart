import 'package:chatapp/core/error/failure.dart';
import 'package:chatapp/features/auth/data/model/user_model.dart';
import 'package:chatapp/features/auth/domain/entities/user.dart';
import 'package:chatapp/features/auth/domain/usecase/get_current_user_usecase.dart';
import 'package:chatapp/features/auth/domain/usecase/login_user_usecase.dart';
import 'package:chatapp/features/auth/domain/usecase/logout_usecase.dart';
import 'package:chatapp/features/auth/domain/usecase/save_user_data_usecase.dart';
import 'package:chatapp/features/auth/domain/usecase/signup_user_usecase.dart';
import 'package:chatapp/features/home/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final SignupUserUsecase signupUseCase;
  final LoginUserUsecase loginUseCase;
  final SaveUserDataUsecase saveUserDataUseCase;
  final GetCurrentUserUsecase getCurrentUserUseCase;
  final LogoutUsecase logoutUseCase;
  AuthController({
    required this.loginUseCase,
    required this.signupUseCase,
    required this.saveUserDataUseCase,
    required this.getCurrentUserUseCase,
    required this.logoutUseCase,
  });
  var isLoading = false.obs;
  var authFailure = Rxn<Failure>();
  var user = Rxn<User>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final numberController = TextEditingController();
  @override
  void onInit() {
    super.onInit();
    print("calling currUser...");
    Future.delayed(Duration.zero, () async {
      await loadCurrentUser();
    });
  }

  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    numberController.dispose();

    super.onClose();
  }

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
        Get.snackbar("signup Failed", failure.message);
      },
      (userEntity) async {
        user.value = userEntity;
        final userModel = UserModel(
          id: userEntity.id,
          name: nameController.text.trim(),
          email: emailController.text.trim(),
          number: int.parse(numberController.text),
        );
        final saveResult = await saveUserDataUseCase(userModel);
        saveResult.fold(
          (e) {
            print(e);
            authFailure.value = e;
            Get.snackbar("Save Failed", e.message);
          },
          (value) async {
            print(value);
            Get.snackbar("saved user data", value.toString());
            print("..loading user");
            await loadCurrentUser();
            print("this is ${user.value!.id}");
            print("saved user $user");
            Get.offAll(HomePage());
          },
        );
      },
    );
    isLoading.value = false;
  }

  Future<void> login() async {
    isLoading.value = true;
    authFailure.value = null;
    try {
      print(isLoading);
      final result = await loginUseCase(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      result.fold(
        (failure) {
          print(failure);
          authFailure.value = failure;
          Get.snackbar("Login Failed", failure.message);
        },
        (userEntity) async {
          user.value = userEntity;
          await loadCurrentUser();
          print("saved login user $user");
          Get.offAll(HomePage());
        },
      );
    }catch(e){
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadCurrentUser() async {
    isLoading.value = true;
    authFailure.value = null;
    final result = await getCurrentUserUseCase.call();
    result.fold(
      (failure) {
        print(failure);
        authFailure.value = failure;
        Get.snackbar("Failed", failure.message);
      },
      (userEntity) {
        user.value = userEntity;
      },
    );
    isLoading.value = false;
  }

  Future<void> logout() async {
    await logoutUseCase.call();
  }
}
