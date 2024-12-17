import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/payment_controller.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final PaymentController controller = Get.put(PaymentController());

    // Panggil ulang stream setiap kali halaman dibuka
    controller.streamCompletedOrders();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        title: const Text('Payment'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              // Total payment section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red[800],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Payment',
                      style: TextStyle(fontSize: 40, color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    Obx(() => Text(
                          'Total: ${controller.getTotal()}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        )),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Choose payment method section
              const Text(
                'Choose your preferred payment method',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              _buildPaymentOption(controller, 'OVO', 'OVO Wallet Payment'),
              _buildPaymentOption(controller, 'DANA', 'DANA Wallet Payment'),
              _buildPaymentOption(
                  controller, 'BCA Virtual Account', 'BCA Virtual Payment'),
              const SizedBox(height: 30),

              // Completed orders section
              const Text('Menu Orders', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 10),
              Obx(() {
                if (controller.completedOrders.isEmpty) {
                  return const Center(child: Text('No Orders Available.'));
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.completedOrders.length,
                  itemBuilder: (context, index) {
                    final item = controller.completedOrders[index];
                    return ListTile(
                      title: Text(item.name),
                      subtitle: Text('Quantity: ${item.quantity}'),
                      trailing: Text('Rp. ${(item.price * item.quantity).toStringAsFixed(0)}'),
                    );
                  },
                );
              }),

              const SizedBox(height: 50),

              // Pay Now button
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    await controller.addPaymentData();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 17),
                    backgroundColor: Colors.black,
                  ),
                  child: const Text(
                    'Pay Now',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Build payment option widget
  Widget _buildPaymentOption(
      PaymentController controller, String paymentMethod, String description) {
    return Obx(() => Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(17),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(paymentMethod),
                trailing: Radio<String>(
                  value: paymentMethod,
                  groupValue: controller.selectedPaymentMethod.value,
                  onChanged: (value) {
                    controller.selectPaymentMethod(value);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 8.0),
                child: Text(description,
                    style: const TextStyle(color: Colors.grey)),
              ),
            ],
          ),
        ));
  }
}
