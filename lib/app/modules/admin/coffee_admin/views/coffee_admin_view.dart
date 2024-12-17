import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_routes.dart';
import '../controllers/coffee_admin_controller.dart';

class CoffeeAdminView extends StatelessWidget {
  const CoffeeAdminView({super.key});

  @override
  Widget build(BuildContext context) {
    final CoffeeAdminController controller = Get.put(CoffeeAdminController());

    // Call the fetch method to load the coffee items from Firestore
    controller.fetchCoffeeItems();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.offNamed(AppRoutes.HOME_ADMIN);
            },
          ),
          title: const Text("Coffee Admin"),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                _showAddCoffeeDialog(context, controller);
              },
            ),
          ],
        ),
        body: Obx(() {
          // Displaying the coffee items
          return ListView.builder(
            itemCount: controller.coffeeItems.length,
            itemBuilder: (context, index) {
              var coffee = controller.coffeeItems[index];
              return _buildCoffeeItemCard(context, coffee, controller);
            },
          );
        }),
      ),
    );
  }

  // Dialog for adding a new coffee item
  void _showAddCoffeeDialog(BuildContext context, CoffeeAdminController controller) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController priceController = TextEditingController();
    final TextEditingController imageUrlController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add New Coffee"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Coffee Name"),
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
                controller.addCoffeeItem(
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

  // Build individual coffee item card
  Widget _buildCoffeeItemCard(
      BuildContext context, Map<String, dynamic> coffee, CoffeeAdminController controller) {
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
                  image: NetworkImage(coffee['imageUrl']),
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
                    coffee['itemName'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(coffee['description']),
                  const SizedBox(height: 5),
                  Text(
                    "${coffee['price']}",
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
                _showEditCoffeeDialog(context, controller, coffee);
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                _showDeleteConfirmationDialog(context, controller, coffee['docId']);
              },
            ),
          ],
        ),
      ),
    );
  }

  // Dialog for editing a coffee item
  void _showEditCoffeeDialog(BuildContext context, CoffeeAdminController controller,
      Map<String, dynamic> coffee) {
    final TextEditingController nameController = TextEditingController(text: coffee['itemName']);
    final TextEditingController descriptionController =
        TextEditingController(text: coffee['description']);
    final TextEditingController priceController = TextEditingController(text: coffee['price']);
    final TextEditingController imageUrlController =
        TextEditingController(text: coffee['imageUrl']);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Coffee"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Coffee Name"),
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
                controller.updateCoffeeItem(
                  coffee['docId'],
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

  // Confirmation dialog for deleting a coffee item
  void _showDeleteConfirmationDialog(
      BuildContext context, CoffeeAdminController controller, String docId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete Coffee"),
          content: const Text("Are you sure you want to delete this coffee item?"),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                controller.deleteCoffeeItem(docId);
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
