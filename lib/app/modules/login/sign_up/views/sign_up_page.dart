import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/sign_up_controller.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final SignUpController controller = Get.put(SignUpController());

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                  return Container();
                }),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: controller.goBack,
                      child: const Icon(Icons.arrow_back),
                    ),
                    const Image(width: 100, image: AssetImage('assets/images/logo/doi_coffee.png')),
                    GestureDetector(
                      onTap: controller.goToLoginPage,
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
                const Text("Please fill in the data below", style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 40),
                
                // Input Email
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text("Email", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: controller.emailController,
                  decoration: InputDecoration(
                    hintText: 'Enter your Email',
                    hintStyle: const TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
                  ),
                ),
                const SizedBox(height: 24),
                
                // Input Password
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text("New Password", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: controller.passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Enter your New Password',
                    hintStyle: const TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
                  ),
                ),
                const SizedBox(height: 36),
                
                // Tombol Sign Up
                GestureDetector(
                  onTap: controller.signUp,
                  child: Container(
                    width: double.infinity,
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
