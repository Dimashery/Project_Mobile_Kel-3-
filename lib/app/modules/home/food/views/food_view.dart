import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_routes.dart';

class FoodView extends StatefulWidget {
  @override
  _FoodViewState createState() => _FoodViewState();
}

class _FoodViewState extends State<FoodView> {
  int _indomieGorengQty = 1; // Quantity for Indomie Goreng
  int _nasiGorengQty = 1;    // Quantity for Nasi Goreng

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Get.back(); // Navigasi ke halaman sebelumnya
            },
          ),
          title: LinearProgressIndicator(
            value: 0.5, // Progress bar (opsional)
            backgroundColor: Colors.grey[300],
            color: Colors.black,
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center, // Posisi di tengah
            children: [
              // Memposisikan tulisan Food's Menu di tengah
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Food's Menu",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 60),
              
              // Memposisikan section makanan di tengah
              Center(
                child: Column(
                  children: [
                    // Indomie Goreng Section
                    _buildFoodItem(
                      imagePath: 'assets/images/food/indomie_goreng.png', // Placeholder for actual image
                      name: 'Indomie Goreng',
                      description: 'Indomie Goreng dengan Telur',
                      price: 'Rp. 15.000',
                      quantity: _indomieGorengQty,
                      onAdd: () {
                        setState(() {
                          _indomieGorengQty++;
                        });
                      },
                      onRemove: () {
                        setState(() {
                          if (_indomieGorengQty > 1) _indomieGorengQty--;
                        });
                      },
                    ),
                    SizedBox(height: 20),

                    // Nasi Goreng Section
                    _buildFoodItem(
                      imagePath: 'assets/images/food/nasi_goreng.png', // Placeholder for actual image
                      name: 'Nasi Goreng',
                      description: 'Nasi Goreng dengan Telur',
                      price: 'Rp. 16.000',
                      quantity: _nasiGorengQty,
                      onAdd: () {
                        setState(() {
                          _nasiGorengQty++;
                        });
                      },
                      onRemove: () {
                        setState(() {
                          if (_nasiGorengQty > 1) _nasiGorengQty--;
                        });
                      },
                    ),
                  ],
                ),
              ),
              
              Spacer(),

              // Spacer digunakan untuk mengatur tombol agar tidak terlalu ke bawah
              SizedBox(height: 30),

              // ADD TO MY ORDER Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.START_TO_BUY); // Navigate back to Start_To_Buy page
                  },
                  child: Text('ADD TO MY ORDER', style: TextStyle(color: Colors.white,)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    textStyle: TextStyle(fontSize: 15),
                  ),
                ),
              ),
               SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  // Widget untuk membuat tampilan tiap makanan dengan gambar di kiri dan teks di kanan
  Widget _buildFoodItem({
  required String imagePath,
  required String name,
  required String description,
  required String price,
  required int quantity,
  required VoidCallback onAdd,
  required VoidCallback onRemove,
}) {
  return Container(
    height: 250,
    width: 1000,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(14),
      color: const Color.fromARGB(255, 243, 238, 197),
    ),
    padding: EdgeInsets.all(14),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        

        Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.fill,
            ),
          ),
        ),

        SizedBox(width: 10),
        
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Text(
                name,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(description),
              SizedBox(height: 10),
              Text(
                price,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              // Tombol tambah/kurang di bawah harga
              Row(
                children: [
                  Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                     
                    ),
                    child: IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: onRemove,
                      padding: EdgeInsets.zero,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    '$quantity',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(width: 10),

                  Container(
                    width: 25,
                    height: 25,

                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                     
                    ),
                    child: IconButton(
                      icon: Icon(Icons.add),
                      onPressed: onAdd,
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
}