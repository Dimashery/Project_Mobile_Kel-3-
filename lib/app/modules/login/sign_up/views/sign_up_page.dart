import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/sign_up_controller.dart'; // Import controller yang telah dibuat

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final SignUpController controller = Get.put(SignUpController()); // Menginisialisasi controller

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView( // Tambahkan SingleChildScrollView
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                // Notifikasi Snackbar
                Obx(() {
                  if (controller.snackbarMessage.isNotEmpty) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Text(
                        controller.snackbarMessage.value,
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    );
                  }
                  return Container(); // Kembali ke kosong jika tidak ada pesan
                }),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: controller.goBack, // Menggunakan metode dari controller
                      child: const Icon(Icons.arrow_back),
                    ),
                    const Image(width: 100, image: AssetImage('assets/images/logo/doi_coffee.png')), // Sesuaikan path logo
                    GestureDetector(
                      onTap: controller.goToLoginPage, // Menggunakan metode dari controller
                      child: const Text(
                        "Sign In!",
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 80),
                const Text(
                  'Sign Up Account',
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                ),
                const Text("Please fill in the data below",
                    style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 40),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text("Email",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: controller.emailController, // Menggunakan controller dari GetX
                  decoration: InputDecoration(
                    hintText: 'Enter your Email',
                    hintStyle: const TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40)),
                  ),
                ),
                const SizedBox(height: 24),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text("New Username",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: controller.usernameController, // Menggunakan controller dari GetX
                  maxLength: 15, // Batas maksimal username adalah 15 karakter
                  decoration: InputDecoration(
                    hintText: 'Enter your New Username',
                    hintStyle: const TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40)),
                  ),
                ),
                const SizedBox(height: 24),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text("New Password",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: controller.passwordController, // Menggunakan controller dari GetX
                  maxLength: 10, // Batas maksimal password adalah 10 karakter
                  obscureText: true, // Password disensor dengan tanda *
                  decoration: InputDecoration(
                    hintText: 'Enter your New Password',
                    hintStyle: const TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40)),
                  ),
                ),
                const SizedBox(height: 36),
                GestureDetector(
                  onTap: controller.signUp, // Menggunakan metode dari controller
                  child: Container(
                    width: double.infinity, // Menggunakan double.infinity agar bisa responsif
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20)),
                    child: const Center(
                      child: Text(
                        "Sign Up",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
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
