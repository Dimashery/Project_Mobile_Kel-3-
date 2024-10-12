import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart'; // Sesuaikan dengan path yang Anda gunakan

class LoginPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

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
                  const Image(width: 100, image: AssetImage('assets/images/logo/doi_coffee.png')), // Path logo sesuaikan
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.SIGNUP_PAGE);  // Menggunakan navigasi GetX
                    },
                    child: const Text(
                      "Sign Up!",
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 100,
              ),
              const Text(
                'Login',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 40,
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Text("Username",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: usernameController,  // Menggunakan controller dari GetX
                maxLength: 15,  // Batas maksimal 15 karakter
                decoration: InputDecoration(
                  hintText: 'Enter your Username',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40)),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Text("Password",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: passwordController,  // Menggunakan controller dari GetX
                maxLength: 10,  // Batas maksimal 10 karakter
                obscureText: true,  // Password disensor dengan tanda *
                decoration: InputDecoration(
                  hintText: 'Enter your Password',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40)),
                ),
              ),
              const SizedBox(
                height: 36,
              ),
              GestureDetector(
                onTap: () {
                  Get.offNamed(AppRoutes.HOME);  // Navigasi ke halaman home setelah login
                },
                child: Container(
                  width: 300,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20)),
                  child: const Center(
                    child: Text(
                      "Continue",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              GestureDetector(
                onTap: () {
                  Get.offNamed(AppRoutes.FORGET_PASSWORD);
                },
                child: const Text(
                  "Forget Password",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
