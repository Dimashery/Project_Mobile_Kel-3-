import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';


class CheckOrderPage extends StatelessWidget {
  const CheckOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Baris atas: tombol kembali dan judul
              GestureDetector(
                onTap: () {
                  Get.back(); // Kembali ke halaman sebelumnya
                },
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
              const Text(
                "Ongoing",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "BCA Virtual Account",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            SizedBox(height: 4),
                            Text("BCA"),
                          ],
                        ),
                        Text("19:30"),
                      ],
                    ),
                    Divider(thickness: 1, height: 24),
                    Text("1 x Indomie Goreng...............................Rp.15.000"),
                    Text("1 x Nasi Goreng....................................Rp.16.000"),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.location_on, color: Colors.red),
                            SizedBox(width: 4),
                            Text("Jl. Sengkaling, Malang"),
                          ],
                        ),
                        Text(
                          "Total : Rp. 31.310",
                          style: TextStyle(fontWeight: FontWeight.bold),
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
                    // Tombol Buy Again
                    BuyAgainButton(),
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
    return GestureDetector(
      onTap: () {
        Get.offNamed(AppRoutes.START_TO_BUY); // Navigasi kembali ke Home
      },
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
