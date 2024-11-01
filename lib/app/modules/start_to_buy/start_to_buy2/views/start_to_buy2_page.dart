import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_routes.dart';
import '../../../order/controllers/my_order_controller.dart';
import '../controllers/start_to_buy2_controller.dart';
 // Import MyOrderController

class StartToBuy2Page extends StatelessWidget {
  const StartToBuy2Page({super.key});

  @override
  Widget build(BuildContext context) {
    final StartToBuy2Controller controller = Get.put(StartToBuy2Controller());
    final MyOrderController orderController = Get.find<MyOrderController>(); // Instance of MyOrderController

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        title: LinearProgressIndicator(
          value: 0.5,
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
            const Text(
              'What you want to buy?',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
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
            const SizedBox(height: 10),
            _buildOrderSummary(orderController), // Display order summary from MyOrderController
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryButton(StartToBuy2Controller controller, String label, IconData icon, String route) {
    return GestureDetector(
      onTap: () {
        controller.navigateTo(route);
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
            const SizedBox(height: 10),
            Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  // Widget to display dynamic order summary
  Widget _buildOrderSummary(MyOrderController orderController) {
    return Container(
      width: 500,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 213, 245, 154),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Obx(() {
        if (orderController.orderItems.isEmpty) {
          return const Text('No items in the order.');
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('My Order', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            // Loop to display each item in the order
            ...orderController.orderItems.map((item) => Text(
              '${item.quantity} x ${item.name} - Rp. ${item.price.toStringAsFixed(0)}',
              style: const TextStyle(fontSize: 16),
            )),
            const SizedBox(height: 30),
            Text(
              'Total: Rp. ${orderController.getTotal().toStringAsFixed(0)}',
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ],
        );
      }),
    );
  }
}
