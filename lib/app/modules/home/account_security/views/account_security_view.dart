import 'package:flutter/material.dart';
import 'package:get/get.dart';



class AccountSecurityView extends StatelessWidget {
  const AccountSecurityView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.toNamed('/profile');
          },
        ),
        title: const Text('Account Security'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0, // Hilangkan bayangan app bar
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Two-Layer Protection',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Login with added security',
                  style: TextStyle(color: Colors.grey),
                ),
                Switch(
                  value: true, // Contoh status ON, sesuaikan dengan kebutuhan
                  onChanged: (bool value) {
                    // Fungsi untuk mengubah status jika diperlukan
                  },
                ),
              ],
            ),
            const Divider(height: 30, thickness: 1),
            const Text(
              'Update Email',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'In case you\'re using another one',
              style: TextStyle(color: Colors.grey),
            ),
            const Divider(height: 30, thickness: 1),
            const Text(
              'Use Password Recovery',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Recover your password easily',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
