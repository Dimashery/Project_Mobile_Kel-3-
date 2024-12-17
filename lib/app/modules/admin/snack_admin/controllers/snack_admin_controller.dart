import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SnackAdminController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var snackItems = <Map<String, dynamic>>[].obs;

  // Fetch all snack items from 'orders' collection where 'id' is 'Snack'
  void fetchSnackItems() async {
    try {
      final snapshot = await _firestore
          .collection('orders')
          .where('id', isEqualTo: 'Snack')
          .get();

      snackItems.assignAll(snapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        data['docId'] = doc.id; // Add document ID for editing or deleting
        return data;
      }).toList());
    } catch (e) {
      print("Error fetching snack items: $e");
    }
  }

  // Add new snack item
  void addSnackItem(String name, String description, String price, String imageUrl) async {
    try {
      await _firestore.collection('orders').add({
        'id': 'Snack',
        'itemName': name,
        'description': description,
        'price': price,
        'imageUrl': imageUrl,
        'status': 'pending',
        'timestamp': FieldValue.serverTimestamp(),
      });
      fetchSnackItems();
    } catch (e) {
      print("Error adding snack item: $e");
    }
  }

  // Update snack item
  void updateSnackItem(String docId, String name, String description, String price, String imageUrl) async {
    try {
      await _firestore.collection('orders').doc(docId).update({
        'itemName': name,
        'description': description,
        'price': price,
        'imageUrl': imageUrl,
      });
      fetchSnackItems();
    } catch (e) {
      print("Error updating snack item: $e");
    }
  }

  // Delete snack item
  void deleteSnackItem(String docId) async {
    try {
      await _firestore.collection('orders').doc(docId).delete();
      fetchSnackItems();
    } catch (e) {
      print("Error deleting snack item: $e");
    }
  }
}
