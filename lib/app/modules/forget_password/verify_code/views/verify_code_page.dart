import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_routes.dart';
 // Sesuaikan dengan path yang Anda gunakan

class VerifyCodePage extends StatelessWidget {
  final TextEditingController codeController1 = TextEditingController();
  final TextEditingController codeController2 = TextEditingController();
  final TextEditingController codeController3 = TextEditingController();
  final TextEditingController codeController4 = TextEditingController();

  VerifyCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              // Logo dan tombol "Sign Up" di bagian atas
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.FORGET_PASSWORD);  // Menggunakan GetX untuk kembali
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
                'Verify Code',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Subtitle
              const Text(
                'Enter the 4-digit code sent to your email',
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),

              // Input untuk kode verifikasi (4 kotak)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildCodeBox(codeController1),
                  _buildCodeBox(codeController2),
                  _buildCodeBox(codeController3),
                  _buildCodeBox(codeController4),
                ],
              ),
              const SizedBox(height: 70),

              // Button "Verify The Code"
              GestureDetector(
                onTap: () {
                  Get.offNamed(AppRoutes.CHANGE_PASSWORD);  // Arahkan ke halaman Change Password
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
                      "Verify The Code",
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

  // Widget untuk kode verifikasi (TextField dengan border dan ukuran)
  Widget _buildCodeBox(TextEditingController controller) {
    return SizedBox(
      width: 50,
      height: 50,
      child: TextField(
        controller: controller,
        textAlign: TextAlign.center,
        maxLength: 1,
        decoration: InputDecoration(
          counterText: "", // Menghilangkan counter untuk panjang maksimal
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}
