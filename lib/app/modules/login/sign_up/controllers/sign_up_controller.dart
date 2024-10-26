import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_routes.dart';

class SignUpController extends GetxController {
  // TextEditingController untuk mengelola input pengguna
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Variabel untuk menyimpan pesan notifikasi
  var snackbarMessage = ''.obs;

  // Method untuk melakukan pendaftaran
  void signUp() {
    // Dapatkan input dari controller
    String email = emailController.text;
    String username = usernameController.text;
    String password = passwordController.text;

    // Validasi input (contoh sederhana)
    if (email.isEmpty || username.isEmpty || password.isEmpty) {
      snackbarMessage.value = 'Please fill in all fields';
      Get.snackbar('Error', snackbarMessage.value,
          snackPosition: SnackPosition.TOP);
      return;
    }

    // Jika semua validasi lolos, arahkan ke halaman sukses
    snackbarMessage.value = 'Sign Up Successful!';
    Get.snackbar('Success', snackbarMessage.value,
        snackPosition: SnackPosition.TOP);
    
    Get.toNamed(AppRoutes.SIGNUP_SUCCESS_PAGE);
  }

  // Method untuk navigasi ke halaman Login
  void goToLoginPage() {
    Get.toNamed(AppRoutes.LOGIN_PAGE);
  }

  // Method untuk kembali ke halaman sebelumnya
  void goBack() {
    Get.back();
  }
}
