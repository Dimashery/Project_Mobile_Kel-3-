import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeAdminController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch all products from 'what's_new' collection
  Stream<QuerySnapshot> getWhatsNewProducts() {
    return _firestore.collection('whats_new').snapshots();
  }

  // Fetch all products from 'favorite_menu' collection
  Stream<QuerySnapshot> getFavoriteMenuProducts() {
    return _firestore.collection('favorite_menu').snapshots();
  }

  // Add product to 'whats_new'
  Future<void> addWhatsNewProduct({
    required String name,
    required String description,
    required String price,
    required String imageUrl,
  }) async {
    await _firestore.collection('whats_new').add({
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
    });
  }

  // Add product to 'favorite_menu'
  Future<void> addFavoriteMenuProduct({
    required String name,
    required String description,
    required String price,
    required String imageUrl,
  }) async {
    await _firestore.collection('favorite_menu').add({
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
    });
  }

  // Update existing product
  Future<void> updateProduct({
    required String productId,
    required String name,
    required String description,
    required String price,
    required String imageUrl,
    required String collection,
  }) async {
    await _firestore.collection(collection).doc(productId).update({
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
    });
  }

  // Delete product from either 'what's_new' or 'favorite_menu'
  Future<void> deleteProduct(String productId, String collection) async {
    await _firestore.collection(collection).doc(productId).delete();
  }
}
