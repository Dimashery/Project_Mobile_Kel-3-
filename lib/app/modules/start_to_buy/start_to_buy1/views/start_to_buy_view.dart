import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_routes.dart';
import '../controllers/start_to_buy_controller.dart';

class StartToBuyView extends StatelessWidget {
  const StartToBuyView({super.key});

  @override
  Widget build(BuildContext context) {
    // Mengambil instance dari StartToBuyController
    final StartToBuyController controller = Get.put(StartToBuyController());

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back(); // Navigasi ke halaman sebelumnya
          },
        ),
        title: LinearProgressIndicator(
          value: 0.5, // Progress bar (opsional)
          backgroundColor: Colors.grey[300],
          color: Colors.black,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              'What you want to buy ?',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            // Grid buttons
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16.0,
                crossAxisSpacing: 16.0,
                childAspectRatio: 1.2,
                children: [
                  _buildCategoryButton(controller, 'Food', Icons.fastfood, AppRoutes.FOOD),
                  _buildCategoryButton(controller, 'Drink', Icons.local_drink, AppRoutes.DRINK),
                  _buildCategoryButton(controller, 'Snack', Icons.restaurant_menu, AppRoutes.SNACK),
                  _buildCategoryButton(controller, 'Coffee', Icons.local_cafe, AppRoutes.COFFEE),
                  _buildCategoryButton(controller, 'Soft Drink', Icons.local_bar, AppRoutes.SOFT_DRINK),
                ],
              ),
            ),
            // Continue Button
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                controller.navigateTo(AppRoutes.MY_ORDER);
                // Action for continue button if needed
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
                child: Text('Continue', style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
      // Bottom navigation bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // index aktif
        onTap: (index) {
          switch (index) {
            case 0:
              controller.navigateTo(AppRoutes.HOME);
              break;
            case 2:
              controller.navigateTo(AppRoutes.MY_ORDER);
              break;
            case 3:
              controller.navigateTo(AppRoutes.PROFILE);
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home, color: Colors.black,), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.card_giftcard, color: Colors.black,), label: 'Voucher'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart, color: Colors.black,), label: 'My Order'),
          BottomNavigationBarItem(icon: Icon(Icons.person, color: Colors.black,), label: 'Profile'),
        ],
      ),
    );
  }

  // Helper function for building category buttons
  Widget _buildCategoryButton(StartToBuyController controller, String label, IconData icon, String route) {
    return GestureDetector(
      onTap: () {
        controller.navigateTo(route); // Navigate to the respective page
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: Colors.black),
            const SizedBox(height: 10),
            Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
