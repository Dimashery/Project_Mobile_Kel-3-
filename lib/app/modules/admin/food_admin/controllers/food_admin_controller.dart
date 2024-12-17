import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FoodAdminController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var foodItems = <Map<String, dynamic>>[].obs;

  // Fetch all food items from 'orders' collection
  void fetchFoodItems() async {
    try {
      final snapshot = await _firestore
          .collection('orders')
          .where('id', isEqualTo: 'Food')
          .get();

      foodItems.assignAll(snapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        data['docId'] = doc.id; // Add document ID for editing or deleting
        return data;
      }).toList());
    } catch (e) {
      print("Error fetching food items: $e");
    }
  }

  // Add new food item
  void addFoodItem(String name, String description, String price, String imageUrl) async {
    try {
      await _firestore.collection('orders').add({
        'id': 'Food',
        'itemName': name,
        'description': description,
        'price': price,
        'imageUrl': imageUrl,
        'status': 'pending', // Default status
        'timestamp': FieldValue.serverTimestamp(),
      });
      fetchFoodItems();
    } catch (e) {
      print("Error adding food item: $e");
    }
  }

  // Update food item
  void updateFoodItem(String docId, String name, String description, String price, String imageUrl) async {
    try {
      await _firestore.collection('orders').doc(docId).update({
        'itemName': name,
        'description': description,
        'price': price,
        'imageUrl': imageUrl,
      });
      fetchFoodItems();
    } catch (e) {
      print("Error updating food item: $e");
    }
  }

  // Delete food item
  void deleteFoodItem(String docId) async {
    try {
      await _firestore.collection('orders').doc(docId).delete();
      fetchFoodItems();
    } catch (e) {
      print("Error deleting food item: $e");
    }
  }
}
