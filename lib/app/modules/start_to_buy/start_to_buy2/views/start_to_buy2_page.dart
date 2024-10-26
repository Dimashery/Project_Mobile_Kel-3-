import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_routes.dart';
import '../controllers/start_to_buy2_controller.dart'; // Import controller yang telah dibuat

class StartToBuy2Page extends StatelessWidget {
  const StartToBuy2Page({super.key});

  @override
  Widget build(BuildContext context) {
    // Mengambil instance dari StartToBuy2Controller
    final StartToBuy2Controller controller = Get.put(StartToBuy2Controller());

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back(); // Kembali ke halaman sebelumnya
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
            Text(
              'What you want to buy?',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16.0,
                crossAxisSpacing: 16.0,
                children: [
                  _buildCategoryButton(controller, 'Food', Icons.fastfood, AppRoutes.FOOD),
                  _buildCategoryButton(controller, 'Drink', Icons.local_drink, AppRoutes.DRINK),
                  _buildCategoryButton(controller, 'Snack', Icons.restaurant_menu, AppRoutes.SNACK),
                  _buildCategoryButton(controller, 'Coffee', Icons.local_cafe, AppRoutes.COFFEE),
                  _buildCategoryButton(controller, 'Soft Drink', Icons.local_bar, AppRoutes.SOFT_DRINK),
                ],
              ),
            ),
            // Tampilan order dari halaman MyOrder
            SizedBox(height: 10),
            _buildOrderSummary(controller),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryButton(StartToBuy2Controller controller, String label, IconData icon, String route) {
    return GestureDetector(
      onTap: () {
        controller.navigateTo(route); // Arahkan ke halaman yang sesuai
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50),
            SizedBox(height: 10),
            Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  // Fungsi untuk menampilkan ringkasan order
  Widget _buildOrderSummary(StartToBuy2Controller controller) {
    return Container(
      width: 500,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 213, 245, 154),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('MyOrder', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text('1 x Indomie Goreng - Rp. 15.000', style: TextStyle(fontSize: 16)),
          Text('1 x Nasi Goreng - Rp. 16.000', style: TextStyle(fontSize: 16)),
          SizedBox(height: 30),
          Text('Total: Rp. 31.310', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
