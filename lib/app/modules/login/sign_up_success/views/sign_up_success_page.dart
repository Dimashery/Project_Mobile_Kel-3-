import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_routes.dart';
 // Sesuaikan dengan path yang Anda gunakan

class SignUpSuccessPage extends StatelessWidget {
  const SignUpSuccessPage({super.key});

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
                      Get.back(); // Navigasi kembali menggunakan GetX
                    },
                    child: const Icon(Icons.arrow_back),
                  ),
                  const Image(width: 100, image: AssetImage('assets/images/logo/doi_coffee.png')), // Path logo sesuaikan
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.LOGIN_PAGE); // Menggunakan navigasi GetX
                    },
                    child: const Text(
                      "Sign In!",
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 150),
              const Text(
                "You Have Successfully Registered an Account",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 50),
              const Icon(Icons.check_circle, color: Colors.black, size: 150), // Mengganti gambar dengan ikon
              const SizedBox(height: 58),
              GestureDetector(
                onTap: () => Get.offNamed(AppRoutes.LOGIN_PAGE), // Kembali ke LoginPage menggunakan GetX
                child: Container(
                  width: 300,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Text(
                      "Back To Login",
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
