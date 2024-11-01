import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';
import '../controllers/my_order_controller.dart';

class MyOrderPage extends StatelessWidget {
  const MyOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final MyOrderController controller = Get.put(MyOrderController());
    controller.getMyOrders();

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
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() => Text(
                          'My Order (${controller.orderItems.length})',
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        )),
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
              ),
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
                    return _buildOrderItem(controller, item);
                  },
                );
              }),
              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Expanded(child: Divider(thickness: 1, color: Colors.black)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: GestureDetector(
                      onTap: () => Get.toNamed(AppRoutes.START_TO_BUY2),

                      child: const CircleAvatar(
                        backgroundColor: Colors.green,
                        child: Icon(Icons.add, color: Colors.white),
                      ),
                    ),
                  ),
                  const Expanded(child: Divider(thickness: 1, color: Colors.black)),
                ],
              ),
              const SizedBox(height: 30),

              Obx(() => _buildTotalSummary(controller)),
              const SizedBox(height: 50),

              Center(
                child: ElevatedButton(
                  onPressed: () => _showCheckoutDialog(controller),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 20),
                    backgroundColor: Colors.black,
                  ),
                  child: const Text('Check Out', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderItem(MyOrderController controller, OrderItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text('Jumlah: ${item.quantity}'),
              ],
            ),
          ),
          Row(
            children: [
              Text('Rp. ${item.price.toStringAsFixed(0)}'),
              IconButton(
                icon: const Icon(Icons.remove_circle, color: Colors.red),
                onPressed: () => _showDeleteDialog(controller, item),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(MyOrderController controller, OrderItem item) {
    Get.defaultDialog(
      title: "Hapus Pesanan",
      middleText: "Apakah Anda yakin ingin menghapus pesanan ini?",
      textCancel: "Batal",
      textConfirm: "Hapus",
      confirmTextColor: Colors.white,
      onConfirm: () {
        controller.deleteOrderItem(item.id);
        Get.back();
      },
    );
  }

  void _showCheckoutDialog(MyOrderController controller) {
    Get.defaultDialog(
      title: "Konfirmasi Pesanan",
      middleText: "Apakah Anda sudah memilih menu dengan benar?",
      textCancel: "Belum, Tunggu Dulu",
      textConfirm: "Iya, Lanjutkan ke Pembayaran",
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back();
        Get.toNamed(AppRoutes.PAYMENT);
      },
    );
  }

  Widget _buildTotalSummary(MyOrderController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Subtotal:...................Rp. ${controller.getSubtotal().toStringAsFixed(0)}'),
        Text('PPN (10%):...............Rp. ${controller.getTax().toStringAsFixed(0)}'),
        Text('Discount:..................Rp. ${controller.getDiscount().toStringAsFixed(0)}', style: const TextStyle(color: Colors.green)),
        Text(
          'TOTAL: ...................Rp. ${controller.getTotal().toStringAsFixed(0)}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
