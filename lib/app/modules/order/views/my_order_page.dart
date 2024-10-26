import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';

class MyOrderPage extends StatelessWidget {
  const MyOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
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
              // Kotak abu-abu di atas
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
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
              const SizedBox(height: 20),
              
              _buildOrderItem(
                context, // Meneruskan context
                'Indomie Goreng',
                'Rp. 15.000',
                'assets/images/food/indomie_goreng.png',
              ),
              const SizedBox(height: 10),
              _buildOrderItem(
                context, // Meneruskan context
                'Nasi Goreng',
                'Rp. 16.000',
                'assets/images/food/nasi_goreng.png',
              ),
              const SizedBox(height: 30),

              // Divider dengan tanda tambah
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Expanded(child: Divider(thickness: 1, color: Colors.black)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.START_TO_BUY2);
                      },
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

              _buildTotalSummary(),
              const SizedBox(height: 50),

              // Tombol Check Out
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.PAYMENT);
                  },
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

  // Fungsi untuk membuat item pesanan
  Widget _buildOrderItem(BuildContext context, String name, String price, String imagePath) {
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.2, // Lebar gambar responsif
          height: MediaQuery.of(context).size.width * 0.2,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
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
