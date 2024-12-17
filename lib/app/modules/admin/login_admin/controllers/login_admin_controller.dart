import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../routes/app_routes.dart';

class LoginAdminController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void loginAdmin() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Email and password cannot be empty');
      return;
    }

    try {
      // Login menggunakan Firebase Authentication
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Verifikasi role admin menggunakan koleksi admin di Firestore
      QuerySnapshot adminQuery = await _firestore
          .collection('admin')
          .where('email', isEqualTo: email)
          .where('role', isEqualTo: 'admin')
          .get();

      if (adminQuery.docs.isNotEmpty) {
        // Jika email ditemukan di koleksi admin dan role adalah admin
        Get.offNamed(AppRoutes.HOME_ADMIN); // Navigasi ke halaman admin
      } else {
        Get.snackbar('Error', 'You are not authorized as admin');
        await _auth.signOut(); // Logout jika bukan admin
      }
    } catch (e) {
      Get.snackbar('Error', 'Login failed: ${e.toString()}');
    }
  }
}
