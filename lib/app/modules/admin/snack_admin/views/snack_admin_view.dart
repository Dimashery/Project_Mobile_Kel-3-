import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_routes.dart';
import '../controllers/snack_admin_controller.dart';

class SnackAdminView extends StatelessWidget {
  const SnackAdminView({super.key});

  @override
  Widget build(BuildContext context) {
    final SnackAdminController controller = Get.put(SnackAdminController());

    // Call the fetch method to load the snack items from Firestore
    controller.fetchSnackItems();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.offNamed(AppRoutes.HOME_ADMIN);
            },
          ),
          title: const Text("Snack Admin"),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                _showAddSnackDialog(context, controller);
              },
            ),
          ],
        ),
        body: Obx(() {
          // Displaying the snack items
          return ListView.builder(
            itemCount: controller.snackItems.length,
            itemBuilder: (context, index) {
              var snack = controller.snackItems[index];
              return _buildSnackItemCard(context, snack, controller);
            },
          );
        }),
      ),
    );
  }

  // Dialog for adding a new snack item
  void _showAddSnackDialog(BuildContext context, SnackAdminController controller) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController priceController = TextEditingController();
    final TextEditingController imageUrlController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add New Snack"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Snack Name"),
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
                controller.addSnackItem(
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

  // Build individual snack item card
  Widget _buildSnackItemCard(
      BuildContext context, Map<String, dynamic> snack, SnackAdminController controller) {
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
                  image: NetworkImage(snack['imageUrl']),
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
                    snack['itemName'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(snack['description']),
                  const SizedBox(height: 5),
                  Text(
                    "${snack['price']}",
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
                _showEditSnackDialog(context, controller, snack);
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                _showDeleteConfirmationDialog(context, controller, snack['docId']);
              },
            ),
          ],
        ),
      ),
    );
  }

  // Dialog for editing a snack item
  void _showEditSnackDialog(BuildContext context, SnackAdminController controller,
      Map<String, dynamic> snack) {
    final TextEditingController nameController = TextEditingController(text: snack['itemName']);
    final TextEditingController descriptionController =
        TextEditingController(text: snack['description']);
    final TextEditingController priceController = TextEditingController(text: snack['price']);
    final TextEditingController imageUrlController =
        TextEditingController(text: snack['imageUrl']);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Snack"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Snack Name"),
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
                controller.updateSnackItem(
                  snack['docId'],
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

  // Confirmation dialog for deleting a snack item
  void _showDeleteConfirmationDialog(
      BuildContext context, SnackAdminController controller, String docId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete Snack"),
          content: const Text("Are you sure you want to delete this snack item?"),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                controller.deleteSnackItem(docId);
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
