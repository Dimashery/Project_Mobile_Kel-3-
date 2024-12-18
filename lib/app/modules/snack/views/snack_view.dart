import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/snack_controller.dart';

class SnackView extends StatelessWidget {
  const SnackView({super.key});

  @override
  Widget build(BuildContext context) {
    final SnackController controller = Get.put(SnackController());

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
            value: 0.75,
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
                    "Snack's Menu",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // Display snack items
                Obx(() {
                  return Column(
                    children: controller.snackMenu.map((snackItem) {
                      return buildSnackItem(
                        context,
                        imagePath: snackItem["imageUrl"],
                        name: snackItem["itemName"],
                        description: snackItem["description"],
                        price: snackItem["price"],
                        quantity: snackItem["quantity"],
                        onAdd: () => controller.updateQuantity(snackItem["docId"], true),
                        onRemove: () => controller.updateQuantity(snackItem["docId"], false),
                      );
                    }).toList(),
                  );
                }),

                const SizedBox(height: 30),

                Center(
                  child: ElevatedButton(
                    onPressed: controller.addToMyOrder, // Add to order
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

 // Widget to build each drink item
  Widget buildSnackItem(
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
        color: const Color.fromARGB(255, 243, 238, 197), // Light background
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Container(
            width: MediaQuery.of(context).size.width * 0.3,
            height: MediaQuery.of(context).size.width * 0.2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(imagePath),
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
                // Drink Name
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(description),
                const SizedBox(height: 10),
                // Price
                Text(
                  price,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                // Quantity adjustment row
                Row(
                  children: [
                    // Minus Button
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
                    // Quantity Text
                    Text(
                      '$quantity',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(width: 10),
                    // Plus Button
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
