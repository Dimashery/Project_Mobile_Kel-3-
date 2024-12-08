import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/food_controller.dart';

class FoodView extends StatelessWidget {
  const FoodView({super.key});

  @override
  Widget build(BuildContext context) {
    // Mendapatkan instance controller
    final FoodController controller = Get.put(FoodController());

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
            value: 0.5, // Progress bar
            backgroundColor: Colors.grey[300],
            color: Colors.black,
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Judul menu makanan
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Food's Menu",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // Indomie Goreng Section
                Obx(() => buildFoodItem(
                  context, // Pass context here
                  imagePath: 'assets/images/food/indomie_goreng.png',
                  name: 'Indomie Goreng',
                  description: 'Indomie Goreng dengan Telur',
                  price: 'Rp. 15.000',
                  quantity: controller.indomieGorengQty.value,
                  onAdd: controller.addIndomieGoreng,
                  onRemove: controller.removeIndomieGoreng,
                )),
                const SizedBox(height: 20),

                // Nasi Goreng Section
                Obx(() => buildFoodItem(
                  context, // Pass context here
                  imagePath: 'assets/images/food/nasi_goreng.png',
                  name: 'Nasi Goreng',
                  description: 'Nasi Goreng dengan Telur',
                  price: 'Rp. 16.000',
                  quantity: controller.nasiGorengQty.value,
                  onAdd: controller.addNasiGoreng,
                  onRemove: controller.removeNasiGoreng,
                )),

                const SizedBox(height: 30),

                // Tombol ADD TO MY ORDER
                Center(
                  child: ElevatedButton(
                    onPressed: controller.addToMyOrder, // Mengubah ini
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      textStyle: const TextStyle(fontSize: 15),
                    ),
                    child: const Text(
                      'ADD TO MY ORDER',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget untuk membuat tampilan tiap makanan dengan gambar di kiri dan teks di kanan
  Widget buildFoodItem(
    BuildContext context, {
    required String imagePath,
    required String name,
    required String description,
    required String price,
    required int quantity,
    required VoidCallback onAdd,
    required VoidCallback onRemove,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: const Color.fromARGB(255, 243, 238, 197),
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Menampilkan gambar dengan ukuran responsif
          Container(
            width: MediaQuery.of(context).size.width * 0.3,
            height: MediaQuery.of(context).size.width * 0.2,
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
                const SizedBox(height: 10),
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
