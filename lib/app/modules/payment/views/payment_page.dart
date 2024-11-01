import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/payment_controller.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final PaymentController controller = Get.put(PaymentController());

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              // Kotak total
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
                    Text(
                      'Total: ${controller.getTotal()}',
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              const Text('Choose your preferred payment method',
                  style: TextStyle(fontSize: 18)),
              const SizedBox(height: 20),
              _buildPaymentOption(controller, 'OVO', 'OVO'),
              _buildPaymentOption(controller, 'DANA', 'DANA Wallet'),
              _buildPaymentOption(controller, 'BCA Virtual Account', 'BCA'),
              const SizedBox(height: 50),
              // In your payment page where you handle the payment confirmation
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Assume you have access to the orderId here
                    String orderId =
                        "your_order_id"; // Replace with actual order ID
                    controller.confirmPayment(orderId); // Pass the orderId
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 17),
                    backgroundColor: Colors.black,
                  ),
                  child: const Text('Pay Now',
                      style: TextStyle(color: Colors.white)),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentOption(
      PaymentController controller, String paymentMethod, String description) {
    return GetBuilder<PaymentController>(
      builder: (controller) {
        return Container(
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
                  groupValue: controller.selectedPaymentMethod,
                  onChanged: (value) {
                    controller.selectPaymentMethod(value);
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(description,
                    style: const TextStyle(color: Colors.grey)),
              ),
            ],
          ),
        );
      },
    );
  }
}
