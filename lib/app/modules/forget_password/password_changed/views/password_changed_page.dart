import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_routes.dart';
 // Sesuaikan dengan path yang Anda gunakan

class PasswordChangedPage extends StatelessWidget {
  const PasswordChangedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(width: 100, image: AssetImage('assets/images/logo/doi_coffee.png')), // Sesuaikan path log
                ],
              ),
              const SizedBox(height: 170),

              // Pesan sukses
              const Text(
                "Your password has been successfully changed",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 28),

              // Ikon centang hijau
              const Icon(Icons.check_circle, color: Colors.black, size: 150),
              const SizedBox(height: 58),

              // Tombol "Back To Login"
              GestureDetector(
                onTap: () {
                  Get.offNamed(AppRoutes.LOGIN_PAGE);  // Kembali ke halaman Login
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
