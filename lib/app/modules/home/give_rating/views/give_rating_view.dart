import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GiveRatingView extends StatelessWidget {
  const GiveRatingView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Give Us Rating',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RatingPage(),
    );
  }
}

class RatingPage extends StatelessWidget {
  const RatingPage({super.key});

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
                  'assets/images/vector/rating.png', // Ganti dengan path gambar lokal Anda
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 20),
              // Teks "Give Us Rating"
              const Text(
                'Give Us Rating',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 30),
              
              
              // Tombol "Give Us The Rating"
              SizedBox(
                width: 250,
                height: 50,
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
                    'Give Us The Rating',
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
