import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/payment_controller.dart'; // Import controller yang telah dibuat

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Mengambil instance dari PaymentController
    final PaymentController controller = Get.put(PaymentController());

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back(); // Kembali ke halaman sebelumnya
          },
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
              // Kotak merah tua di atas untuk "Payment" dan "Total"
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red[800], // Warna merah tua
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
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              const Text('Choose your preferred payment method', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 20),

              // Opsi metode pembayaran dengan tombol Radio di sebelah kanan
              _buildPaymentOption(controller, 'OVO', 'OVO'),
              _buildPaymentOption(controller, 'DANA', 'DANA Wallet'),
              _buildPaymentOption(controller, 'BCA Virtual Account', 'BCA'),

              const SizedBox(height: 20),

              // Teks catatan di bawah metode pembayaran
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "*Make sure your order is appropriate\n"
                  "*Make sure your payment method matches your choice",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              const SizedBox(height: 50),

              // Tombol "Pay Now"
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    controller.confirmPayment(); // Memanggil metode konfirmasi pembayaran
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 17),
                    backgroundColor: Colors.black,
                  ),
                  child: const Text('Pay Now', style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(height: 20), // Jarak tambahan di bagian bawah
            ],
          ),
        ),
      ),
    );
  }

  // Fungsi untuk membuat opsi metode pembayaran
  Widget _buildPaymentOption(PaymentController controller, String paymentMethod, String description) {
    return GetBuilder<PaymentController>(
      builder: (controller) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 10), // Jarak antar opsi pembayaran
          decoration: BoxDecoration(
            border: Border.all(color: const Color.fromARGB(255, 0, 0, 0)), // Garis tepi
            borderRadius: BorderRadius.circular(17),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(paymentMethod),
                trailing: Radio<String>(
                  value: paymentMethod,
                  groupValue: controller.selectedPaymentMethod, // Mengatur metode pembayaran yang dipilih
                  onChanged: (value) {
                    controller.selectPaymentMethod(value); // Menyimpan metode yang dipilih
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  description,
                  style: const TextStyle(color: Colors.grey), // Deskripsi dengan warna abu-abu
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
