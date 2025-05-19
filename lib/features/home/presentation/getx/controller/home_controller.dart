import 'package:get/get.dart';

class HomeController extends GetxController {
  final RxInt _currentIndex = 0.obs;

  int get currentIndex => _currentIndex.value;
  void onItemTapped(int index) {
    _currentIndex.value = index;
  }
}
