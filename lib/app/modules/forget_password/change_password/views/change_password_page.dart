import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/change_password_controller.dart'; // Import controller

class ChangePasswordPage extends StatelessWidget {
  ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ChangePasswordController controller = Get.put(ChangePasswordController()); // Menginisialisasi controller

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                // Bagian atas dengan logo dan link Sign Up
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: controller.goToVerifyCodePage, // Menggunakan metode dari controller
                      child: const Icon(Icons.arrow_back),
                    ),
                    const Image(width: 100, image: AssetImage('assets/images/logo/doi_coffee.png')), // Sesuaikan path logo
                    GestureDetector(
                      onTap: controller.goToLoginPage, // Navigasi ke halaman Login
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
                  controller: controller.newPasswordController, // Menggunakan controller
                  obscureText: true,
                  maxLength: 10,
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
                  controller: controller.confirmPasswordController, // Menggunakan controller
                  obscureText: true,
                  maxLength: 10,
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
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 36),

                // Tombol "Continue"
                GestureDetector(
                  onTap: controller.changePassword, // Menggunakan metode dari controller
                  child: Container(
                    width: double.infinity,
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
                  onTap: controller.goToLoginPage, // Menggunakan metode dari controller
                  child: const Text(
                    "Back to Login",
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
