import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_routes.dart'; // Sesuaikan dengan struktur proyek Anda

class MyOrderPage extends StatelessWidget {
  const MyOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Kotak abu-abu di atas
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[300], // Warna abu-abu
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'MyOrder (2)',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text('Your Location:'),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.red),
                      Text('Jl. Sengkaling, Malang'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20), // Jarak setelah kotak

            
            const SizedBox(height: 70),

            _buildOrderItem(
              'Indomie Goreng',
              'Rp. 15.000',
              'assets/images/food/indomie_goreng.png', // Ganti dengan path gambar yang sesuai
            ),
            const SizedBox(height: 10),
            _buildOrderItem(
              'Nasi Goreng',
              'Rp. 16.000',
              'assets/images/food/nasi_goreng.png', // Ganti dengan path gambar yang sesuai
            ),
            const SizedBox(height: 60),
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Expanded(child: Divider(thickness: 1, color: Colors.black)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: GestureDetector(
                    onTap: () {
                      // Tindakan ketika tombol (+) ditekan
                      Get.toNamed(AppRoutes.START_TO_BUY2); // Arahkan ke halaman StartToBuy2
                    },
                    child: const CircleAvatar(
                      backgroundColor: Colors.green,
                      child: Icon(Icons.add, color: Colors.white), // Ikon +
                    ),
                  ),
                ),
                const Expanded(child: Divider(thickness: 1, color: Colors.black)),
              ],
            ),
            // Tanda (+) untuk menambah pesanan (hapus karena sudah ditambahkan di atas)
            // Center(
            //   child: IconButton(
            //     icon: const Icon(Icons.add_circle, color: Colors.green, size: 40),
            //     onPressed: () {
            //       Get.toNamed(AppRoutes.START_TO_BUY2); // Arahkan ke halaman StartToBuy2
            //     },
            //   ),
            // ),

            const SizedBox(height: 20),
            _buildTotalSummary(),
            const SizedBox(height: 100),

            // Tombol Check Out
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.PAYMENT); // Arahkan ke halaman Payment
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 15),
                  backgroundColor: Colors.black,
                ),
                child: const Text('Check Out', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Fungsi untuk membuat item pesanan
  Widget _buildOrderItem(String name, String price, String imagePath) {
    return Row(
      children: [
        Image.asset(
          imagePath,
          width: 60,
          height: 60,
          fit: BoxFit.contain,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              Text('Total: $price'),
              const Text('Topping: Rp. 0'),
            ],
          ),
        ),
        Text(price),
      ],
    );
  }

  // Fungsi untuk menampilkan total ringkasan pembayaran
  Widget _buildTotalSummary() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Subtotal:...................Rp. 31.000'),
        Text('PPN (10%):...............Rp. 310'),
        Text('Discount:..................Rp. 0', style: TextStyle(color: Colors.green)),
        Text(
          'TOTAL: ...................Rp. 31.310',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
