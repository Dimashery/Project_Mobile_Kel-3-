import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_routes.dart';
 // Sesuaikan dengan path yang Anda gunakan

class ChangePasswordPage extends StatelessWidget {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              // Bagian atas dengan logo dan link Sign Up
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.VERIFY_CODE);  // Menggunakan GetX untuk kembali
                    },
                    child: const Icon(Icons.arrow_back),
                  ),
                  const Image(width: 100, image: AssetImage('assets/images/logo/doi_coffee.png')), // Sesuaikan path logo
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.LOGIN_PAGE);  // Navigasi ke halaman Login
                    },
                    child: const Text(
                      "Sign In!",
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 100),

              // Title
              const Text(
                'Change Password',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),

              // Label "New Password"
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "New Password",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 8),

              // Input "New Password"
              TextField(
                controller: newPasswordController,
                obscureText: true,
                maxLength: 10,  // Batas maksimal 10 karakter
                decoration: InputDecoration(
                  hintText: 'Enter your New Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Label "Confirm Password"
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Confirm Password",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 8),

              // Input "Confirm Password"
              TextField(
                controller: confirmPasswordController,
                obscureText: true,
                maxLength: 10,  // Batas maksimal 10 karakter
                decoration: InputDecoration(
                  hintText: 'Re-enter your Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Ketentuan Password
              const Text(
                "*Password must have at least one uppercase letter\n"
                "*Password must be a minimum of 5 words and a maximum of 10",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 36),

              // Tombol "Continue"
              GestureDetector(
                onTap: () {
                  Get.offNamed(AppRoutes.PASSWORD_CHANGED);  // Navigasi ke halaman Password Changed
                },
                child: Container(
                  width: 300,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Text(
                      "Continue",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Back to Login link
              GestureDetector(
                onTap: () {
                  Get.offNamed(AppRoutes.LOGIN_PAGE);  // Navigasi kembali ke halaman Login
                },
                child: const Text(
                  "Back to Login",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
