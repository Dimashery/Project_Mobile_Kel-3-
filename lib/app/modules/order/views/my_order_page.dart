import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/my_order_controller.dart';

class MyOrderPage extends StatelessWidget {
  const MyOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final MyOrderController controller = Get.put(MyOrderController());

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        title: const Text('My Order'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Obx(() {
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'My Order (${controller.orderItems.length})',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text('Your Location:'),
                      Row(
                        children: [
                          const Icon(Icons.location_on, color: Colors.red),
                          Text(controller.location.value),
                        ],
                      ),
                    ],
                  ),
                );
              }),
              const SizedBox(height: 20),

              Obx(() {
                if (controller.orderItems.isEmpty) {
                  return const Center(child: Text('Tidak ada pesanan.'));
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.orderItems.length,
                  itemBuilder: (context, index) {
                    final item = controller.orderItems[index];
                    return _buildOrderItem(item, controller);
                  },
                );
              }),
              const SizedBox(height: 30),

              Obx(() => _buildTotalSummary(controller)),
              const SizedBox(height: 50),

              Center(
                child: ElevatedButton(
                  onPressed: () => controller.checkOutAndCompleteOrder(),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 70, vertical: 20),
                    backgroundColor: Colors.black,
                  ),
                  child: const Text(
                    'Check Out',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderItem(OrderItem item, MyOrderController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text('Jumlah: ${item.quantity}'),
                Text('Status: ${item.status}'),
              ],
            ),
          ),
          Row(
            children: [
              Text('Rp. ${item.price.toStringAsFixed(0)}'),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => controller.deleteOrder(item.id),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTotalSummary(MyOrderController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Subtotal:...................Rp. ${controller.getSubtotal().toStringAsFixed(0)}',
        ),
        Text(
          'PPN (10%):...............Rp. ${controller.getTax().toStringAsFixed(0)}',
        ),
        Text(
          'Discount:..................Rp. ${controller.getDiscount().toStringAsFixed(0)}',
        ),
        Text(
          'Total:.......................Rp. ${controller.getTotal().toStringAsFixed(0)}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
