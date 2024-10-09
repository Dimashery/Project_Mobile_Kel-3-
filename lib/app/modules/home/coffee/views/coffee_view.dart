import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_routes.dart';

class CoffeeView extends StatefulWidget {
  @override
  _CoffeeViewState createState() => _CoffeeViewState();
}

class _CoffeeViewState extends State<CoffeeView> {
  int _kopiTubrukQty = 1; // Quantity for Kopi Tubruk
  int _esTaroQty = 1;     // Quantity for Es Taro

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
            value: 0.7, // Progress bar (opsional)
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
              // Memposisikan tulisan Coffee's Menu di tengah
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Coffee's Menu",
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
                    // Kopi Tubruk Section
                    _buildCoffeeItem(
                      imagePath: 'assets/images/coffee/kopi_tubruk.png', // Ganti dengan path gambar yang sesuai
                      name: 'Kopi Tubruk',
                      description: 'Kopi Tubruk dengan rempah-rempah',
                      price: 'Rp. 7.000',
                      quantity: _kopiTubrukQty,
                      onAdd: () {
                        setState(() {
                          _kopiTubrukQty++;
                        });
                      },
                      onRemove: () {
                        setState(() {
                          if (_kopiTubrukQty > 1) _kopiTubrukQty--;
                        });
                      },
                    ),
                    SizedBox(height: 20),

                    // Es Taro Section
                    _buildCoffeeItem(
                      imagePath: 'assets/images/coffee/cappucino.png', // Ganti dengan path gambar yang sesuai
                      name: 'Cappucino',
                      description: 'Cappucino dengan cream dan manis yang pas',
                      price: 'Rp. 10.000',
                      quantity: _esTaroQty,
                      onAdd: () {
                        setState(() {
                          _esTaroQty++;
                        });
                      },
                      onRemove: () {
                        setState(() {
                          if (_esTaroQty > 1) _esTaroQty--;
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
  Widget _buildCoffeeItem({
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
              SizedBox(height: 20),
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
