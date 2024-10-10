import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';

class SignUpPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();  // Menggunakan GetX untuk kembali
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
                controller: emailController,  // Menggunakan controller dari GetX
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
                controller: usernameController,  // Menggunakan controller dari GetX
                maxLength: 15,  // Batas maksimal username adalah 15 karakter
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
                controller: passwordController,  // Menggunakan controller dari GetX
                maxLength: 10,  // Batas maksimal password adalah 10 karakter
                obscureText: true,  // Password disensor dengan tanda *
                decoration: InputDecoration(
                  hintText: 'Enter your New Password',
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40)),
                ),
              ),
              const SizedBox(height: 36),
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.SIGNUP_SUCCESS_PAGE);  // Navigasi ke halaman sukses Sign Up
                },
                child: Container(
                  width: double.infinity,
                  height: 40,
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
    );
  }
}
