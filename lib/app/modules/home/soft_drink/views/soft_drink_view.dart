import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_routes.dart';

class SoftDrinkView extends StatefulWidget {
  @override
  _SoftDrinkViewState createState() => _SoftDrinkViewState();
}

class _SoftDrinkViewState extends State<SoftDrinkView> {
  int _cocaColaQty = 1; // Quantity for Coca Cola
  int _spriteQty = 1;   // Quantity for Sprite

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
            value: 1.0, // Progress bar
            backgroundColor: Colors.grey[300],
            color: Colors.black,
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Soft Drink's Menu",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 60),

              Center(
                child: Column(
                  children: [
                    // Coca Cola Section
                    _buildSoftDrinkItem(
                      imagePath: 'assets/images/soft_drink/coca_cola.png',
                      name: 'Coca Cola',
                      description: 'Minuman ringan bersoda',
                      price: 'Rp. 8.000',
                      quantity: _cocaColaQty,
                      onAdd: () {
                        setState(() {
                          _cocaColaQty++;
                        });
                      },
                      onRemove: () {
                        setState(() {
                          if (_cocaColaQty > 1) _cocaColaQty--;
                        });
                      },
                    ),
                    SizedBox(height: 20),

                    // Sprite Section
                    _buildSoftDrinkItem(
                      imagePath: 'assets/images/soft_drink/fanta.png',
                      name: 'Fanta',
                      description: 'Minuman ringan bersoda dengan rasa Jeruk',
                      price: 'Rp. 7.000',
                      quantity: _spriteQty,
                      onAdd: () {
                        setState(() {
                          _spriteQty++;
                        });
                      },
                      onRemove: () {
                        setState(() {
                          if (_spriteQty > 1) _spriteQty--;
                        });
                      },
                    ),
                  ],
                ),
              ),

              Spacer(),
              SizedBox(height: 30),

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

  Widget _buildSoftDrinkItem({
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
