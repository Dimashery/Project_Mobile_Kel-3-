import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../conrtrollers/check_order_controller.dart';
// Import controller yang telah dibuat

class CheckOrderPage extends StatelessWidget {
  const CheckOrderPage({super.key});

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
              // Baris atas: tombol kembali dan judul
              GestureDetector(
                onTap: controller.goBack, // Menggunakan metode dari controller
                child: const Icon(Icons.arrow_back),
              ),
              const SizedBox(height: 24),

              // Judul halaman
              const Center(
                child: Text(
                  "Your Order",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 40),

              // Status pesanan
              Text(
                controller.getOrderStatus(), // Menggunakan metode dari controller
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Kotak detail pesanan (transparan dengan border)
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.grey.shade400, // Warna garis tepi
                    width: 1.0,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "BCA Virtual Account",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            SizedBox(height: 4),
                            Text("BCA"),
                          ],
                        ),
                        const Text("19:30"),
                      ],
                    ),
                    const Divider(thickness: 1, height: 24),
                    const Text("1 x Indomie Goreng...............................Rp.15.000"),
                    const Text("1 x Nasi Goreng....................................Rp.16.000"),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.location_on, color: Colors.red),
                            SizedBox(width: 4),
                            Text("Jl. Sengkaling, Malang"),
                          ],
                        ),
                        Text(
                          "Total : ${controller.getTotalOrder()}", // Menggunakan metode dari controller
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),

              // Text dan tombol Buy Again
              const Center(
                child: Column(
                  children: [
                    Text("Want to add more orders?"),
                    SizedBox(height: 20),
                    BuyAgainButton(), // Tombol dibisakan sebagai widget terpisah
                  ],
                ),
              ),

              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}

class BuyAgainButton extends StatelessWidget {
  const BuyAgainButton({super.key});

  @override
  Widget build(BuildContext context) {
    final CheckOrderController controller = Get.find(); // Mengambil instance controller yang sama

    return GestureDetector(
      onTap: controller.buyAgain, // Menggunakan metode dari controller
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
