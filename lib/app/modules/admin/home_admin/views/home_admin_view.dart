import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../routes/app_routes.dart';
import '../controllers/home_admin_controller.dart';

class HomeAdminView extends StatelessWidget {
  final controller = Get.find<HomeAdminController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Home'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(  
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Menu Navigation Section
              _buildMenuSection(context),
              SizedBox(height: 30),
              // What's New Section
              _buildProductSection('What\'s New?', controller.getWhatsNewProducts(), 'whats_new'),
              SizedBox(height: 30),
              // Favorite Menu Section
              _buildProductSection('Favorite Menu', controller.getFavoriteMenuProducts(), 'favorite_menu'),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddProductDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }

  // Helper function to build Menu navigation to Food Admin and Drink Admin
  Widget _buildMenuSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Admin Menu',
          style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        ListTile(
          title: Text('Food Admin'),
          leading: Icon(Icons.fastfood),
          onTap: () {
            Get.offNamed(AppRoutes.FOOD_ADMIN); // Navigate to Food Admin using Get.offNamed
          },
        ),
        ListTile(
          title: Text('Drink Admin'),
          leading: Icon(Icons.local_drink),
          onTap: () {
            Get.offNamed(AppRoutes.DRINK_ADMIN); // Navigate to Drink Admin using Get.offNamed
          },
        ),
        ListTile(
          title: Text('Snack Admin'),
          leading: Icon(Icons.restaurant_menu),
          onTap: () {
            Get.offNamed(AppRoutes.SNACK_ADMIN); // Navigate to Drink Admin using Get.offNamed
          },
        ),
        ListTile(
          title: Text('Coffee Admin'),
          leading: Icon(Icons.local_cafe),
          onTap: () {
            Get.offNamed(AppRoutes.COFFEE_ADMIN); // Navigate to Drink Admin using Get.offNamed
          },
        ),
        ListTile(
          title: Text('Soft Drink Admin'),
          leading: Icon(Icons.local_bar),
          onTap: () {
            Get.offNamed(AppRoutes.SOFT_DRINK_ADMIN); // Navigate to Drink Admin using Get.offNamed
          },
        ),
      ],
    );
  }

  // Helper function to build product section (What's New or Favorite Menu)
  Widget _buildProductSection(
    String title,
    Stream<QuerySnapshot> stream,
    String collection,
  ) {
    return StreamBuilder<QuerySnapshot>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No products found in $title'));
        }

        final products = snapshot.data!.docs;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(title, style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
            ),
            Container(
              height: 300, // Set fixed height to avoid overflow
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return _buildProductItem(
                    product['name'],
                    'Rp. ${product['price']}',
                    product['description'],
                    product['imageUrl'],
                    product.id, // Passing product ID for editing and deleting
                    collection, // Passing collection name to identify the collection
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  // Helper function to create Product items with an edit icon
  Widget _buildProductItem(
    String name, String price, String description, String imagePath, String productId, String collection) {
    return Container(
      width: 270,
      margin: EdgeInsets.only(right: 9),
      child: Card(
        elevation: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 140,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(imagePath),
                  fit: BoxFit.contain,  // Ganti fit: BoxFit.cover jika perlu
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text(price, style: TextStyle(fontSize: 16)),
                  Text(description, style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    controller.deleteProduct(productId, collection);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.blue),
                  onPressed: () {
                    _showEditProductDialog(productId, collection);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Show Edit Product Dialog
  void _showEditProductDialog(String productId, String collection) {
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();
    final priceController = TextEditingController();
    final imageUrlController = TextEditingController();

    showDialog(
      context: Get.context!, // Use Get.context here to access context.
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Product'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(labelText: 'Description'),
                ),
                TextField(
                  controller: priceController,
                  decoration: InputDecoration(labelText: 'Price'),
                ),
                TextField(
                  controller: imageUrlController,
                  decoration: InputDecoration(labelText: 'Image URL'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                controller.updateProduct(
                  productId: productId,
                  name: nameController.text,
                  description: descriptionController.text,
                  price: priceController.text,
                  imageUrl: imageUrlController.text,
                  collection: collection,
                );
                Navigator.pop(context);
              },
              child: Text('Save Changes'),
            ),
          ],
        );
      },
    );
  }

  void _showAddProductDialog(BuildContext context) {
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();
    final priceController = TextEditingController();
    final imageUrlController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add New Product'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(controller: nameController, decoration: InputDecoration(labelText: 'Name')),
                TextField(controller: descriptionController, decoration: InputDecoration(labelText: 'Description')),
                TextField(controller: priceController, decoration: InputDecoration(labelText: 'Price')),
                TextField(controller: imageUrlController, decoration: InputDecoration(labelText: 'Image URL')),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
            ElevatedButton(
              onPressed: () {
                controller.addWhatsNewProduct(
                  name: nameController.text,
                  description: descriptionController.text,
                  price: priceController.text,
                  imageUrl: imageUrlController.text,
                );
                Navigator.pop(context);
              },
              child: Text('Add Product'),
            ),
          ],
        );
      },
    );
  }
}
