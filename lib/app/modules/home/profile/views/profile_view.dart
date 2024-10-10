import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.toNamed('/home');
          },
        ),
        
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Section
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey[300], // Placeholder avatar
                  child: const Icon(Icons.person, size: 40, color: Colors.white),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'FULANA PUTRI ANDRIANI',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text('📍 Malang, Indonesia',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        )),
                    Text('0815566777328',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        )),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 40),

            // MyAccount Section
            const Text(
              'MyAccount',
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 15),

            // List of Menu Items
            ListTile(
              title: const Text('Your Order'),
              onTap: () {
                Get.toNamed('/check-order');
              },
            ),
            ListTile(
              title: const Text('Favorite Menu'),
              onTap: () {
                Get.toNamed('/favorite');
              },
            ),
            ListTile(
              title: const Text('History'),
              onTap: () {
                Get.toNamed('/history');
              },
            ),
            ListTile(
              title: const Text('Language'),
              onTap: () {
                Get.toNamed('/language');
              },
            ),
            ListTile(
              title: const Text('Notification'),
              onTap: () {
                Get.toNamed('/notification');
              },
            ),
            ListTile(
              title: const Text('Account Security'),
              onTap: () {
                Get.toNamed('/account_security');
              },
            ),
            ListTile(
              title: const Text('Invite Your Get Free Voucher'),
              onTap: () {
                Get.toNamed('/free_voucher');
              },
            ),
            ListTile(
              title: const Text('Give Us Rating'),
              onTap: () {
                Get.toNamed('/give_rating');
              },
            ),
            ListTile(
              title: const Text('Account Settings'),
              onTap: () {
                Get.toNamed('/account_settings');
              },
            ),
          ],
        ),
      ),
    );
  }
}
