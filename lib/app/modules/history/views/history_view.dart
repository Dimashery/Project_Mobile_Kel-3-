import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/history_controller.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final HistoryController controller = Get.put(HistoryController());

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.toNamed('/profile');
          },
        ),
        title: const Text('History'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (controller.historyOrders.isEmpty) {
            return const Center(child: Text('Tidak ada riwayat pesanan.'));
          }

          return ListView.builder(
            itemCount: controller.historyOrders.length,
            itemBuilder: (context, index) {
              final order = controller.historyOrders[index];
              return _buildOrderCard(order);
            },
          );
        }),
      ),
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 213, 245, 154),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pesanan: ${order["itemName"]} - ${order["quantity"]} x Rp. ${order["price"]}',
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            'Harga: Rp. ${order["price"]}', // Menampilkan harga per item tanpa perkalian
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
            'Tanggal: ${order["timestamp"].toDate().toLocal()}',
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
