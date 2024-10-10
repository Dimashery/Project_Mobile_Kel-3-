import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountSettingsView extends StatelessWidget {
  const AccountSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AccountSettingsScreen(),
    );
  }
}

class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({super.key});

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
        title: const Text('Account Settings'),
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
              'Account Settings',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                // Aksi untuk menambahkan akun
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.shade300, width: 1),
                  ),
                ),
                child: const Text(
                  'Add Account',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed('/login_page');
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.shade300, width: 1),
                  ),
                ),
                child: const Text(
                  'Log Out',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.red, // Warna merah untuk menonjolkan logout
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
