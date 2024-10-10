import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_routes.dart';

class CoffeeView extends StatefulWidget {
  const CoffeeView({super.key});

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
            icon: const Icon(Icons.arrow_back),
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
              const Align(
                alignment: Alignment.center,
                child: Text(
                  "Coffee's Menu",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 60),

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
                    const SizedBox(height: 20),

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

              const Spacer(),
              const SizedBox(height: 30),

              // ADD TO MY ORDER Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.START_TO_BUY); // Navigate back to Start_To_Buy page
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    textStyle: const TextStyle(fontSize: 15),
                  ),
                  child: const Text('ADD TO MY ORDER', style: TextStyle(color: Colors.white,)),
                ),
              ),
              const SizedBox(height: 50),
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
    padding: const EdgeInsets.all(14),
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
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(description),
              const SizedBox(height: 10),
              Text(
                price,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              // Tombol tambah/kurang di bawah harga
              Row(
                children: [
                  Container(
                    width: 25,
                    height: 25,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                     
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: onRemove,
                      padding: EdgeInsets.zero,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '$quantity',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(width: 10),

                  Container(
                    width: 25,
                    height: 25,

                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                     
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.add),
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
