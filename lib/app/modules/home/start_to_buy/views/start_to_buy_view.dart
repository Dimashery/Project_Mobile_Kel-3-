import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_routes.dart'; // Ganti sesuai dengan struktur proyek

class StartToBuyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
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
            SizedBox(height: 20),
            Text(
              'What you want to buy ?',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            // Grid buttons
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16.0,
                crossAxisSpacing: 16.0,
                childAspectRatio: 1.2,
                children: [
                  _buildCategoryButton('Food', Icons.fastfood, AppRoutes.FOOD),
                  _buildCategoryButton('Drink', Icons.local_drink, AppRoutes.DRINK),
                  _buildCategoryButton('Snack', Icons.restaurant_menu, AppRoutes.SNACK),
                  _buildCategoryButton('Coffee', Icons.local_cafe, AppRoutes.COFFEE),
                  _buildCategoryButton('Soft Drink', Icons.local_bar, AppRoutes.SOFT_DRINK),
                ],
              ),
            ),
            // Continue Button
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Action for continue button if needed
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
                child: Text('Continue', style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
             SizedBox(height: 40),
          ],
        ),
      ),
      // Bottom navigation bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // index aktif
        
        onTap: (index) {
          switch (index) {
            case 0:
              Get.toNamed(AppRoutes.HOME);
              break;

              /*
            case 1:
              Get.toNamed(AppRoutes.VOUCHER);
              break;
            case 2:
              Get.toNamed(AppRoutes.MYORDER);
              break;
            case 3:
              Get.toNamed(AppRoutes.PROFILE);
              break;

              */
          }
        },
        
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home, color: Colors.black,), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.card_giftcard, color: Colors.black,), label: 'Voucher'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart, color: Colors.black,), label: 'My Order'),
          BottomNavigationBarItem(icon: Icon(Icons.person, color: Colors.black,), label: 'Profile'),
        ],
      ),
    );
  }

  // Helper function for building category buttons
  Widget _buildCategoryButton(String label, IconData icon, String route) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(route); // Navigate to the respective page
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
            SizedBox(height: 10),
            Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
