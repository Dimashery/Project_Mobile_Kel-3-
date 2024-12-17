import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DrinkAdminController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var drinkItems = <Map<String, dynamic>>[].obs;

  // Fetch all drink items from 'orders' collection
  void fetchDrinkItems() async {
    try {
      final snapshot = await _firestore
          .collection('orders')
          .where('id', isEqualTo: 'Drink')
          .get();

      drinkItems.assignAll(snapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        data['docId'] = doc.id; // Add document ID for editing or deleting
        return data;
      }).toList());
    } catch (e) {
      print("Error fetching drink items: $e");
    }
  }

  // Add new drink item
  void addDrinkItem(String name, String description, String price, String imageUrl) async {
    try {
      await _firestore.collection('orders').add({
        'id': 'Drink',
        'itemName': name,
        'description': description,
        'price': price,
        'imageUrl': imageUrl,
        'status': 'pending', // Default status
        'timestamp': FieldValue.serverTimestamp(),
      });
      fetchDrinkItems();
    } catch (e) {
      print("Error adding drink item: $e");
    }
  }

  // Update drink item
  void updateDrinkItem(String docId, String name, String description, String price, String imageUrl) async {
    try {
      await _firestore.collection('orders').doc(docId).update({
        'itemName': name,
        'description': description,
        'price': price,
        'imageUrl': imageUrl,
      });
      fetchDrinkItems();
    } catch (e) {
      print("Error updating drink item: $e");
    }
  }

  // Delete drink item
  void deleteDrinkItem(String docId) async {
    try {
      await _firestore.collection('orders').doc(docId).delete();
      fetchDrinkItems();
    } catch (e) {
      print("Error deleting drink item: $e");
    }
  }
}
