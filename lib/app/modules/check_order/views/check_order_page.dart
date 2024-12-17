import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/check_order_controller.dart';

class CheckOrderPage extends StatefulWidget {
  const CheckOrderPage({Key? key}) : super(key: key);

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

              // Tab menu to select Ongoing or Complete
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
                      style: TextStyle(color: Colors.black),
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
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Display orders based on selected tab
              Expanded(
                child: Obx(() {
                  if (_selectedIndex == 0) {
                    if (controller.ongoingOrders.isEmpty) {
                      return const Center(child: Text('No ongoing orders.'));
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
                      return const Center(child: Text('No completed orders.'));
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
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey,
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Order: ${order.itemNames.join(', ')}",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 11),
          Text("Payment Method: ${order.paymentMethod}", style: const TextStyle(fontSize: 15)),
          const SizedBox(height: 8),
          Text("Total: Rp.${order.total}", style: const TextStyle(fontSize: 15)),
          const SizedBox(height: 8),
          Text("Time: ${order.timestamp}", style: const TextStyle(fontSize: 15)),
          const SizedBox(height: 16),
          if (!isComplete)
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: const Icon(Icons.check, size: 20, color: Colors.green),
                onPressed: () async {
                  bool? confirm = await Get.dialog<bool?>(
                    AlertDialog(
                      title: const Text("Confirm"),
                      content: const Text("Are you sure this order is completed?"),
                      actions: [
                        TextButton(
                          onPressed: () => Get.back(result: true),
                          child: const Text("Yes"),
                        ),
                        TextButton(
                          onPressed: () => Get.back(result: false),
                          child: const Text("No"),
                        ),
                      ],
                    ),
                  );

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
  const BuyAgainButton({Key? key}) : super(key: key);

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
