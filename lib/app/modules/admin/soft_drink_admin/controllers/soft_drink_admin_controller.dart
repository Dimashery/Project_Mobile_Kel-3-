import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SoftDrinkAdminController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var softDrinkItems = <Map<String, dynamic>>[].obs;

  // Fetch all soft drink items from 'orders' collection
  void fetchSoftDrinkItems() async {
    try {
      final snapshot = await _firestore
          .collection('orders')
          .where('id', isEqualTo: 'SoftDrink')
          .get();

      softDrinkItems.assignAll(snapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        data['docId'] = doc.id; // Add document ID for editing or deleting
        return data;
      }).toList());
    } catch (e) {
      print("Error fetching soft drink items: $e");
    }
  }

  // Add new soft drink item
  void addSoftDrinkItem(String name, String description, String price, String imageUrl) async {
    try {
      await _firestore.collection('orders').add({
        'id': 'SoftDrink',
        'itemName': name,
        'description': description,
        'price': price,
        'imageUrl': imageUrl,
        'status': 'pending', // Default status
        'timestamp': FieldValue.serverTimestamp(),
      });
      fetchSoftDrinkItems();
    } catch (e) {
      print("Error adding soft drink item: $e");
    }
  }

  // Update soft drink item
  void updateSoftDrinkItem(String docId, String name, String description, String price, String imageUrl) async {
    try {
      await _firestore.collection('orders').doc(docId).update({
        'itemName': name,
        'description': description,
        'price': price,
        'imageUrl': imageUrl,
      });
      fetchSoftDrinkItems();
    } catch (e) {
      print("Error updating soft drink item: $e");
    }
  }

  // Delete soft drink item
  void deleteSoftDrinkItem(String docId) async {
    try {
      await _firestore.collection('orders').doc(docId).delete();
      fetchSoftDrinkItems();
    } catch (e) {
      print("Error deleting soft drink item: $e");
    }
  }
}
