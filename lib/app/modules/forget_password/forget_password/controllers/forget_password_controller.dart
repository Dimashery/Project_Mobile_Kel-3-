import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_routes.dart';

class ForgetPasswordController extends GetxController {
  final TextEditingController emailController = TextEditingController();

  // Method untuk menangani tindakan ketika tombol "Continue" ditekan
  void continueToVerifyCode() {
    // Ambil email dari controller
    String email = emailController.text;

    // Validasi email (sederhana)
    if (email.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your email address',
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    // Jika valid, navigasi ke halaman Verify Code
    Get.offNamed(AppRoutes.VERIFY_CODE);
  }

  // Method untuk kembali ke halaman Login
  void goToLoginPage() {
    Get.offNamed(AppRoutes.LOGIN_PAGE);
  }
}
