import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_routes.dart';
import '../controllers/drink_admin_controller.dart';

class DrinkAdminView extends StatelessWidget {
  const DrinkAdminView({super.key});

  @override
  Widget build(BuildContext context) {
    final DrinkAdminController controller = Get.put(DrinkAdminController());

    // Call the fetch method to load the drink items from Firestore
    controller.fetchDrinkItems();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.offNamed(AppRoutes.HOME_ADMIN);
            },
          ),
          title: const Text("Drink Admin"),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                _showAddDrinkDialog(context, controller);
              },
            ),
          ],
        ),
        body: Obx(() {
          // Displaying the drink items
          return ListView.builder(
            itemCount: controller.drinkItems.length,
            itemBuilder: (context, index) {
              var drink = controller.drinkItems[index];
              return _buildDrinkItemCard(context, drink, controller);
            },
          );
        }),
      ),
    );
  }

  // Dialog for adding a new drink item
  void _showAddDrinkDialog(
      BuildContext context, DrinkAdminController controller) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController priceController = TextEditingController();
    final TextEditingController imageUrlController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add New Drink"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Drink Name"),
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
                controller.addDrinkItem(
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

  // Build individual drink item card
  Widget _buildDrinkItemCard(BuildContext context, Map<String, dynamic> drink,
      DrinkAdminController controller) {
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
                  image: NetworkImage(drink['imageUrl']),
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
                    drink['itemName'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(drink['description']),
                  const SizedBox(height: 5),
                  Text(
                    "${drink['price']}",
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
                _showEditDrinkDialog(context, controller, drink);
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                _showDeleteConfirmationDialog(
                    context, controller, drink['docId']);
              },
            ),
          ],
        ),
      ),
    );
  }

  // Dialog for editing a drink item
  void _showEditDrinkDialog(BuildContext context,
      DrinkAdminController controller, Map<String, dynamic> drink) {
    final TextEditingController nameController =
        TextEditingController(text: drink['itemName']);
    final TextEditingController descriptionController =
        TextEditingController(text: drink['description']);
    final TextEditingController priceController =
        TextEditingController(text: drink['price']);
    final TextEditingController imageUrlController =
        TextEditingController(text: drink['imageUrl']);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Drink"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Drink Name"),
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
                controller.updateDrinkItem(
                  drink['docId'],
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

  // Confirmation dialog for deleting a drink item
  void _showDeleteConfirmationDialog(
      BuildContext context, DrinkAdminController controller, String docId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete Drink"),
          content:
              const Text("Are you sure you want to delete this drink item?"),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                controller.deleteDrinkItem(docId);
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
