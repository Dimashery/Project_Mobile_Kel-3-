import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_routes.dart';
import '../controllers/food_admin_controller.dart';

class FoodAdminView extends StatelessWidget {
  const FoodAdminView({super.key});

  @override
  Widget build(BuildContext context) {
    final FoodAdminController controller = Get.put(FoodAdminController());

    // Fetch the food items when the page is loaded
    controller.fetchFoodItems();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.offNamed(AppRoutes.HOME_ADMIN);
            },
          ),
          title: const Text("Food Admin"),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                _showAddFoodDialog(context, controller);
              },
            ),
          ],
        ),
        body: Obx(() {
          // Displaying food items in a list
          return ListView.builder(
            itemCount: controller.foodItems.length,
            itemBuilder: (context, index) {
              var food = controller.foodItems[index];
              return _buildFoodItemCard(context, food, controller);
            },
          );
        }),
      ),
    );
  }

  // Dialog to add a new food item
  void _showAddFoodDialog(BuildContext context, FoodAdminController controller) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController priceController = TextEditingController();
    final TextEditingController imageUrlController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add New Food"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Food Name"),
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
                controller.addFoodItem(
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

  // Build individual food item card
  Widget _buildFoodItemCard(BuildContext context, Map<String, dynamic> food,
      FoodAdminController controller) {
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
                  image: NetworkImage(food['imageUrl']),
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
                    food['itemName'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(food['description']),
                  const SizedBox(height: 5),
                  Text(
                    "${food['price']}",
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
                _showEditFoodDialog(context, controller, food);
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                _showDeleteConfirmationDialog(context, controller, food['docId']);
              },
            ),
          ],
        ),
      ),
    );
  }

  // Dialog to edit a food item
  void _showEditFoodDialog(BuildContext context, FoodAdminController controller,
      Map<String, dynamic> food) {
    final TextEditingController nameController = TextEditingController(text: food['itemName']);
    final TextEditingController descriptionController =
        TextEditingController(text: food['description']);
    final TextEditingController priceController = TextEditingController(text: food['price']);
    final TextEditingController imageUrlController =
        TextEditingController(text: food['imageUrl']);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Food"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Food Name"),
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
                controller.updateFoodItem(
                  food['docId'],
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

  // Confirmation dialog to delete a food item
  void _showDeleteConfirmationDialog(
      BuildContext context, FoodAdminController controller, String docId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete Food"),
          content: const Text("Are you sure you want to delete this food item?"),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                controller.deleteFoodItem(docId);
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
