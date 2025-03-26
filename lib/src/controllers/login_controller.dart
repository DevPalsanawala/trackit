import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trackit/src/screens/auth/Services/auth_service.dart';
import 'package:trackit/src/screens/home/home_screen.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final RxBool isSecure = true.obs;
  final RxBool isLoading = false.obs;
  final AuthService _authService = AuthService();

  @override
  void onClose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.onClose();
  }

  void isVisible() {
    isSecure.value = !isSecure.value;
  }

  Future<void> loginUser(String email, String password) async {
    isLoading.value = true;
    String res = await _authService.loginUser(email, password);
    if (res == "success") {
      Get.off(HomeScreen());
    }
    isLoading.value = false;
  }
}
