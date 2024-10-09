import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_routes.dart';

class DrinkView extends StatefulWidget {
  @override
  _DrinkViewState createState() => _DrinkViewState();
}

class _DrinkViewState extends State<DrinkView> {
  int _esTehQty = 1; // Quantity for Es Teh
  int _esJerukQty = 1; // Quantity for Es Jeruk

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
              // Memposisikan tulisan Drink's Menu di tengah
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Drink's Menu",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 60),

              // Memposisikan section minuman di tengah
              Center(
                child: Column(
                  children: [
                    // Es Teh Section
                    _buildDrinkItem(
                      imagePath: 'assets/images/drink/es_teh.png', // Placeholder for actual image
                      name: 'Es Teh',
                      description: 'Es Teh Manis Dingin',
                      price: 'Rp. 5.000',
                      quantity: _esTehQty,
                      onAdd: () {
                        setState(() {
                          _esTehQty++;
                        });
                      },
                      onRemove: () {
                        setState(() {
                          if (_esTehQty > 1) _esTehQty--;
                        });
                      },
                    ),
                    SizedBox(height: 20),

                    // Es Jeruk Section
                    _buildDrinkItem(
                      imagePath: 'assets/images/drink/es_jeruk.png', // Placeholder for actual image
                      name: 'Es Jeruk',
                      description: 'Es Jeruk Segar',
                      price: 'Rp. 7.000',
                      quantity: _esJerukQty,
                      onAdd: () {
                        setState(() {
                          _esJerukQty++;
                        });
                      },
                      onRemove: () {
                        setState(() {
                          if (_esJerukQty > 1) _esJerukQty--;
                        });
                      },
                    ),
                  ],
                ),
              ),

              Spacer(),

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

  // Widget untuk membuat tampilan tiap minuman dengan gambar di kiri dan teks di kanan
  Widget _buildDrinkItem({
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
          height: 190,
          width: 190,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.contain,
            ),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
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
