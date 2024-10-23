import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NotificationSettingsScreen(),
    );
  }
}

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  NotificationSettingsScreenState createState() =>
      NotificationSettingsScreenState();  // Nama class sekarang public tanpa underscore
}

class NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {  // Class sekarang public tanpa underscore
  bool _orderNotification = false;
  bool _promoNotification = false;

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
        title: const Text('Notification'),
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
              'Notification Settings',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            SwitchListTile(
              title: const Text('Order Notification'),
              value: _orderNotification,
              onChanged: (bool value) {
                setState(() {
                  _orderNotification = value;
                });
              },
            ),
            const Divider(height: 30, thickness: 1),
            const SizedBox(height: 30),
            SwitchListTile(
              title: const Text('Promo Notification'),
              value: _promoNotification,
              onChanged: (bool value) {
                setState(() {
                  _promoNotification = value;
                });
              },
            ),
            const Divider(height: 30, thickness: 1),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
