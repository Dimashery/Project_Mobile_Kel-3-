import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';
import '../controllers/soft_drink_controller.dart';

class SoftDrinkView extends StatelessWidget {
  const SoftDrinkView({super.key});

  @override
  Widget build(BuildContext context) {
    // Mengambil instance dari SoftDrinkController
    final SoftDrinkController controller = Get.put(SoftDrinkController());

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
            },
          ),
          title: LinearProgressIndicator(
            value: 1.0,
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
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Soft Drink's Menu",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                Center(
                  child: Column(
                    children: [
                      // Coca Cola Section
                      Obx(() => _buildSoftDrinkItem(
                        context,
                        imagePath: 'assets/images/soft_drink/coca_cola.png',
                        name: 'Coca Cola',
                        description: 'Minuman ringan bersoda',
                        price: 'Rp. 8.000',
                        quantity: controller.cocaColaQty.value,
                        onAdd: controller.incrementCocaCola,
                        onRemove: controller.decrementCocaCola,
                      )),
                      const SizedBox(height: 20),

                      // Sprite Section
                      Obx(() => _buildSoftDrinkItem(
                        context,
                        imagePath: 'assets/images/soft_drink/fanta.png',
                        name: 'Fanta',
                        description: 'Minuman ringan bersoda dengan rasa Jeruk',
                        price: 'Rp. 7.000',
                        quantity: controller.spriteQty.value,
                        onAdd: controller.incrementSprite,
                        onRemove: controller.decrementSprite,
                      )),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.START_TO_BUY);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      textStyle: const TextStyle(fontSize: 15),
                    ),
                    child: const Text('ADD TO MY ORDER', style: TextStyle(color: Colors.white)),
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

  // Widget untuk membuat tampilan tiap minuman dengan gambar di kiri dan teks di kanan
  Widget _buildSoftDrinkItem(
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
          Container(
            width: MediaQuery.of(context).size.width * 0.3,
            height: MediaQuery.of(context).size.width * 0.2, // Lebar responsif gambar
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
