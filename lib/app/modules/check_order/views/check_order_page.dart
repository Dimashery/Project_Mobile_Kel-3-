import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../conrtrollers/check_order_controller.dart';

class CheckOrderPage extends StatefulWidget {
  const CheckOrderPage({super.key});

  @override
  _CheckOrderPageState createState() => _CheckOrderPageState();
}

class _CheckOrderPageState extends State<CheckOrderPage> {
  int _selectedIndex = 0; // 0 for Ongoing, 1 for Complete

  @override
  Widget build(BuildContext context) {
    final CheckOrderController controller = Get.put(CheckOrderController());

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: controller.goBack,
                child: const Icon(Icons.arrow_back),
              ),
              const SizedBox(height: 24),
              Center(
                child: Obx(() => Text(
                  "Order (${controller.getOrderCount()})",
                  style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                )),
              ),
              const SizedBox(height: 24),

              // Menu to select Ongoing or Complete
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _selectedIndex = 0; // Select Ongoing
                      });
                    },
                    child: const Text(
                      "Ongoing",
                      style: TextStyle(color: Colors.black), // Minimalist black text
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _selectedIndex = 1; // Select Complete
                      });
                    },
                    child: const Text(
                      "Complete",
                      style: TextStyle(color: Colors.black), // Minimalist black text
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Kotak detail pesanan sesuai dengan menu yang dipilih
              Expanded(
                child: Obx(() {
                  if (_selectedIndex == 0) {
                    if (controller.ongoingOrders.isEmpty) {
                      return const Center(child: Text('Tidak ada pesanan.'));
                    }
                    return ListView.builder(
                      itemCount: controller.ongoingOrders.length,
                      itemBuilder: (context, index) {
                        final order = controller.ongoingOrders[index];
                        return _buildOrderBox(order, controller, false);
                      },
                    );
                  } else {
                    if (controller.completedOrders.isEmpty) {
                      return const Center(child: Text('Tidak ada pesanan selesai.'));
                    }
                    return ListView.builder(
                      itemCount: controller.completedOrders.length,
                      itemBuilder: (context, index) {
                        final order = controller.completedOrders[index];
                        return _buildOrderBox(order, controller, true);
                      },
                    );
                  }
                }),
              ),

              // Bagian tombol 'Buy Again'
              const SizedBox(height: 20),
              const Center(
                child: Column(
                  children: [
                    Text("Want to add more orders?"),
                    SizedBox(height: 20),
                    BuyAgainButton(),
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderBox(CoffeeOrder order, CheckOrderController controller, bool isComplete) {
    final priceString = order.price.replaceAll(RegExp(r'[^0-9]'), '');
    final price = int.tryParse(priceString) ?? 0;

    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: Colors.white, // Optional: background color
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey, // Add border color
          width: 1.0,
        ),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                order.quantity > 1 ? '${order.quantity} x ${order.itemName}' : order.itemName,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 16),
              Text("Total: Rp.${(price * order.quantity).toString()}"),
            ],
          ),
          if (!isComplete) // Show check button only for ongoing orders
            Positioned(
              bottom: 8,
              right: 8,
              child: IconButton(
                icon: const Icon(Icons.check, size: 20, color: Colors.green),
                onPressed: () async {
                  // Show confirmation dialog
                  bool? confirm = await Get.dialog<bool?>(
                    AlertDialog(
                      title: const Text("Konfirmasi"),
                      content: const Text("Apakah Anda yakin pesanan sudah diterima?"),
                      actions: [
                        TextButton(
                          onPressed: () => Get.back(result: true),
                          child: const Text("Iya, Sudah"),
                        ),
                        TextButton(
                          onPressed: () => Get.back(result: false),
                          child: const Text("Belum"),
                        ),
                      ],
                    ),
                  );

                  // If confirmed, complete the order
                  if (confirm == true) {
                    controller.completeOrder(order);
                  }
                },
              ),
            ),
        ],
      ),
    );
  }
}

class BuyAgainButton extends StatelessWidget {
  const BuyAgainButton({super.key});

  @override
  Widget build(BuildContext context) {
    final CheckOrderController controller = Get.find();

    return GestureDetector(
      onTap: controller.buyAgain,
      child: Container(
        width: 200,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(25),
        ),
        child: const Center(
          child: Text(
            "Buy Again",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
