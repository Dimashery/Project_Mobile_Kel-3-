import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_routes.dart';

class VerifyCodeController extends GetxController {
  final TextEditingController codeController1 = TextEditingController();
  final TextEditingController codeController2 = TextEditingController();
  final TextEditingController codeController3 = TextEditingController();
  final TextEditingController codeController4 = TextEditingController();

  // Method untuk memverifikasi kode
  void verifyCode() {
    String code = codeController1.text +
        codeController2.text +
        codeController3.text +
        codeController4.text;

    if (code.length < 4) {
      Get.snackbar(
        'Error',
        'Please enter the complete 4-digit code',
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    // Jika kode benar, navigasi ke halaman Change Password
    Get.offNamed(AppRoutes.CHANGE_PASSWORD);
  }

  // Method untuk kembali ke halaman Forget Password
  void goToForgetPasswordPage() {
    Get.offNamed(AppRoutes.FORGET_PASSWORD);
  }

  // Method untuk kembali ke halaman Login
  void goToLoginPage() {
    Get.offNamed(AppRoutes.LOGIN_PAGE);
  }
}
