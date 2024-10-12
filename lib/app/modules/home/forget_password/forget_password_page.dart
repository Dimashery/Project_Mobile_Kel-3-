import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart'; // Sesuaikan dengan path yang Anda gunakan

class ForgetPasswordPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  ForgetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              // Logo dan tombol "Sign Up" di atas
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.LOGIN_PAGE);  // Menggunakan GetX untuk kembali
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
              const SizedBox(height: 170),

              // Title
              const Text(
                'Enter Your Email',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Sub Title
              const Text(
                'Enter the email address to get a link to reset your password',
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),

              // Input email field
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Email",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: emailController,  // Controller for email
                decoration: InputDecoration(
                  hintText: 'Enter your Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
              ),
              const SizedBox(height: 36),

              // Button "Continue"
              GestureDetector(
                onTap: () {
                  // Navigate to Verify Code Page
                  Get.offNamed(AppRoutes.VERIFY_CODE);
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
