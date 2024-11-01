import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../routes/app_routes.dart';

class LoginController extends GetxController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance; // Inisialisasi FirebaseAuth

  void login() async {
    String username = usernameController.text;
    String password = passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Username and password cannot be empty');
      return;
    }

    try {
      await _auth.signInWithEmailAndPassword(email: username, password: password);
      Get.offNamed(AppRoutes.HOME); // Navigasi ke halaman Home jika berhasil login
    } catch (e) {
      Get.snackbar('Error', 'Login failed: ${e.toString()}');
    }
  }

  void goToSignup() {
    Get.toNamed(AppRoutes.SIGNUP_PAGE);
  }

  void goToForgetPassword() {
    Get.toNamed(AppRoutes.FORGET_PASSWORD);
  }
}
