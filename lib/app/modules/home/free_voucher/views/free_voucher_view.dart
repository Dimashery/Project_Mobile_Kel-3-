import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FreeVoucherView extends StatelessWidget {
  const FreeVoucherView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Free Voucher',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FreeVoucherPage(),
    );
  }
}

class FreeVoucherPage extends StatelessWidget {
  const FreeVoucherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.toNamed('/profile');
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Gambar ilustrasi
              SizedBox(
                height: 250,
                child: Image.asset(
                  'assets/images/vector/teman.png', // Ganti dengan path gambar lokal Anda
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 20),
              // Teks "Free Voucher"
              const Text(
                'Free Voucher',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              // Subteks
              const Text(
                'Invite Your Friend to Get Free Voucher :)',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'You can Invite with Scan QR or Click The Button Below',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black45,
                ),
              ),
              const SizedBox(height: 30),
              // Tombol "Invite Now"
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Aksi ketika tombol ditekan
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black, // Warna background tombol
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Invite Now',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
