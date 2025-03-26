import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trackit/src/screens/auth/Services/auth_service.dart';
import 'package:trackit/src/screens/home/home_screen.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final RxBool isSecure = true.obs;
  final RxBool isLoading = false.obs;

  final AuthService _authService = AuthService();

  @override
  void onClose() {
    namecontroller.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.onClose();
  }

  void isVisible() {
    isSecure.value = !isSecure.value;
  }

  Future<void> signupUser(String name, String email, String password) async {
    isLoading.value = true;
    String res = await _authService.registerUser(name, email, password);
    if (res == "success") {
      Get.off(HomeScreen());
    }
    isLoading.value = false;
  }
}
