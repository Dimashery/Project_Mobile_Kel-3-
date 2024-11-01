import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import '../../../../routes/app_routes.dart';

class SignUpController extends GetxController {
  // TextEditingController untuk mengelola input pengguna
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Variabel untuk menyimpan pesan notifikasi
  var snackbarMessage = ''.obs;

  // Instance FirebaseAuth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Method untuk melakukan pendaftaran
  void signUp() async {
    // Dapatkan input dari controller
    String email = emailController.text;
    String password = passwordController.text;

    // Validasi input (contoh sederhana)
    if (email.isEmpty || password.isEmpty) {
      snackbarMessage.value = 'Please fill in all fields';
      Get.snackbar('Error', snackbarMessage.value, snackPosition: SnackPosition.TOP);
      return;
    }

    try {
      // Firebase Sign Up dengan Email dan Password
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      
      // Jika berhasil, arahkan ke halaman login atau halaman sukses
      snackbarMessage.value = 'Sign Up Successful!';
      Get.snackbar('Success', snackbarMessage.value, snackPosition: SnackPosition.TOP);
      
      Get.offNamed(AppRoutes.LOGIN_PAGE); // Redirect ke halaman login
    } catch (e) {
      snackbarMessage.value = 'Sign Up Failed: ${e.toString()}';
      Get.snackbar('Error', snackbarMessage.value, snackPosition: SnackPosition.TOP);
    }
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
