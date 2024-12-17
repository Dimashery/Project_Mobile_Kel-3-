import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CoffeeAdminController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var coffeeItems = <Map<String, dynamic>>[].obs;

  // Fetch all coffee items from 'orders' collection
  void fetchCoffeeItems() async {
    try {
      final snapshot = await _firestore
          .collection('orders')
          .where('id', isEqualTo: 'Coffee')
          .get();

      coffeeItems.assignAll(snapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        data['docId'] = doc.id; // Add document ID for editing or deleting
        return data;
      }).toList());
    } catch (e) {
      print("Error fetching coffee items: $e");
    }
  }

  // Add new coffee item
  void addCoffeeItem(String name, String description, String price, String imageUrl) async {
    try {
      await _firestore.collection('orders').add({
        'id': 'Coffee',
        'itemName': name,
        'description': description,
        'price': price,
        'imageUrl': imageUrl,
        'status': 'pending', // Default status
        'timestamp': FieldValue.serverTimestamp(),
      });
      fetchCoffeeItems();
    } catch (e) {
      print("Error adding coffee item: $e");
    }
  }

  // Update coffee item
  void updateCoffeeItem(String docId, String name, String description, String price, String imageUrl) async {
    try {
      await _firestore.collection('orders').doc(docId).update({
        'itemName': name,
        'description': description,
        'price': price,
        'imageUrl': imageUrl,
      });
      fetchCoffeeItems();
    } catch (e) {
      print("Error updating coffee item: $e");
    }
  }

  // Delete coffee item
  void deleteCoffeeItem(String docId) async {
    try {
      await _firestore.collection('orders').doc(docId).delete();
      fetchCoffeeItems();
    } catch (e) {
      print("Error deleting coffee item: $e");
    }
  }
}
