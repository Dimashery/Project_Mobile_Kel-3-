import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../routes/app_routes.dart';

class LoginController extends GetxController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login() {
    String username = usernameController.text;
    String password = passwordController.text;

    // TODO: Tambahkan logika autentikasi di sini.
    if (username.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Username and password cannot be empty');
      return;
    }

    // Misalkan berhasil login
    Get.offNamed(AppRoutes.HOME); // Navigasi ke halaman Home
  }

  void goToSignup() {
    Get.toNamed(AppRoutes.SIGNUP_PAGE); // Navigasi ke halaman Sign Up
  }

  void goToForgetPassword() {
    Get.toNamed(AppRoutes.FORGET_PASSWORD); // Navigasi ke Forget Password
  }
}
