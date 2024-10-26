import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_routes.dart';

class ChangePasswordController extends GetxController {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  // Method untuk mengubah password
  void changePassword() {
    String newPassword = newPasswordController.text;
    String confirmPassword = confirmPasswordController.text;

    // Validasi password
    if (newPassword.isEmpty || confirmPassword.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill in all fields',
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    if (newPassword != confirmPassword) {
      Get.snackbar(
        'Error',
        'Passwords do not match',
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    // Tambahkan logika untuk mengganti password di sini

    // Jika berhasil, navigasi ke halaman Password Changed
    Get.offNamed(AppRoutes.PASSWORD_CHANGED);
  }

  // Method untuk kembali ke halaman Verify Code
  void goToVerifyCodePage() {
    Get.offNamed(AppRoutes.VERIFY_CODE);
  }

  // Method untuk kembali ke halaman Login
  void goToLoginPage() {
    Get.offNamed(AppRoutes.LOGIN_PAGE);
  }
}
