import 'package:chatapp/core/utils/errror_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkController extends GetxController {
  var isConnected = true.obs;
  final Connectivity connectivity = Connectivity();
  @override
  void onInit() {
    super.onInit();
    print("network error is checking");
    getConnectionStatus();
    Connectivity().onConnectivityChanged.listen((result) {
      updateConnectionStatus(result);
    });

    ever(isConnected, (connected) {
      if (connected == true) {
        Get.back();
        Get.snackbar(
          "Network Restored",
          "You're back online!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.blue.shade200,
          colorText: Colors.black,
        );
      }
    });
  }

  Future<void> getConnectionStatus() async {
    final connectivityResult = await connectivity.checkConnectivity();
    print("network is a list $connectivityResult");
    updateConnectionStatus(connectivityResult);
  }

  void updateConnectionStatus(List connectivityResult) {
    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)) {
      isConnected.value = true;
      print("network is connected $connectivityResult");
    } else if (connectivityResult.contains(ConnectivityResult.none)) {
      isConnected.value = false;
      print("network is not connected $connectivityResult");
      if (Get.currentRoute != '/error') {
        Get.toNamed('/error');
      }
    }
  }

  Future<void> retry() async {
    print("u are in retry funtion ${isConnected.value}");
    final connectivityResult = await connectivity.checkConnectivity();

    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)) {
      isConnected.value = true;
      if (Get.currentRoute == '/error') {
        Get.back();
      }
      Get.snackbar(
        "Network Restored",
        "You're back online!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blue.shade200,
        colorText: Colors.black,
      );
    } else {
      isConnected.value = false;
      Get.snackbar(
        "No Internet Connection",
        "",
        messageText: Text(
          "Please check your connection and try again.",
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade200,
        colorText: Colors.black,
      );
    }
  }
}
