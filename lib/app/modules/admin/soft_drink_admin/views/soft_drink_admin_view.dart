import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_routes.dart';
import '../controllers/soft_drink_admin_controller.dart';

class SoftDrinkAdminView extends StatelessWidget {
  const SoftDrinkAdminView({super.key});

  @override
  Widget build(BuildContext context) {
    final SoftDrinkAdminController controller = Get.put(SoftDrinkAdminController());

    // Panggil metode fetch untuk memuat item soft drink dari Firestore
    controller.fetchSoftDrinkItems();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.offNamed(AppRoutes.HOME_ADMIN);
            },
          ),
          title: const Text("Soft Drink Admin"),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                _showAddSoftDrinkDialog(context, controller);
              },
            ),
          ],
        ),
        body: Obx(() {
          // Tampilkan daftar item soft drink
          return ListView.builder(
            itemCount: controller.softDrinkItems.length,
            itemBuilder: (context, index) {
              var softDrink = controller.softDrinkItems[index];
              return _buildSoftDrinkItemCard(context, softDrink, controller);
            },
          );
        }),
      ),
    );
  }

  // Dialog untuk menambahkan soft drink baru
  void _showAddSoftDrinkDialog(BuildContext context, SoftDrinkAdminController controller) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController priceController = TextEditingController();
    final TextEditingController imageUrlController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add New Soft Drink"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Soft Drink Name"),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: "Description"),
              ),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(labelText: "Price"),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: imageUrlController,
                decoration: const InputDecoration(labelText: "Image URL"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                controller.addSoftDrinkItem(
                  nameController.text,
                  descriptionController.text,
                  priceController.text,
                  imageUrlController.text,
                );
                Get.back();
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  // Widget untuk membangun kartu item soft drink
  Widget _buildSoftDrinkItemCard(
      BuildContext context, Map<String, dynamic> softDrink, SoftDrinkAdminController controller) {
    return Card(
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(softDrink['imageUrl']),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    softDrink['itemName'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(softDrink['description']),
                  const SizedBox(height: 5),
                  Text(
                    "${softDrink['price']}",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                _showEditSoftDrinkDialog(context, controller, softDrink);
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                _showDeleteConfirmationDialog(context, controller, softDrink['docId']);
              },
            ),
          ],
        ),
      ),
    );
  }

  // Dialog untuk mengedit soft drink
  void _showEditSoftDrinkDialog(BuildContext context, SoftDrinkAdminController controller,
      Map<String, dynamic> softDrink) {
    final TextEditingController nameController = TextEditingController(text: softDrink['itemName']);
    final TextEditingController descriptionController =
        TextEditingController(text: softDrink['description']);
    final TextEditingController priceController = TextEditingController(text: softDrink['price']);
    final TextEditingController imageUrlController =
        TextEditingController(text: softDrink['imageUrl']);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Soft Drink"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Soft Drink Name"),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: "Description"),
              ),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(labelText: "Price"),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: imageUrlController,
                decoration: const InputDecoration(labelText: "Image URL"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                controller.updateSoftDrinkItem(
                  softDrink['docId'],
                  nameController.text,
                  descriptionController.text,
                  priceController.text,
                  imageUrlController.text,
                );
                Get.back();
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  // Dialog konfirmasi untuk menghapus soft drink
  void _showDeleteConfirmationDialog(
      BuildContext context, SoftDrinkAdminController controller, String docId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete Soft Drink"),
          content: const Text("Are you sure you want to delete this soft drink item?"),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                controller.deleteSoftDrinkItem(docId);
                Get.back();
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }
}
