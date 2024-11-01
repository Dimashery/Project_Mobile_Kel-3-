import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SoftDrinkController extends GetxController {
  // Reactive variables for quantities
  var cocaColaQty = 0.obs;
  var fantaQty = 0.obs;

  // Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Method to increase quantities
  void incrementCocaCola() {
    cocaColaQty++;
  }

  void incrementFanta() {
    fantaQty++;
  }

  // Method to decrease quantities
  void decrementCocaCola() {
    if (cocaColaQty > 0) {
      cocaColaQty--;
    }
  }

  void decrementFanta() {
    if (fantaQty > 0) {
      fantaQty--;
    }
  }

  // Method to add order to Firestore
  void addToMyOrder() async {
    try {
      if (cocaColaQty.value > 0) {
        await _firestore.collection('orders').add({
          'itemName': 'Coca Cola',
          'price': 'Rp. 8.000',
          'quantity': cocaColaQty.value,
          'timestamp': FieldValue.serverTimestamp(),
          'status': 'pending',
        });
      }

      if (fantaQty.value > 0) {
        await _firestore.collection('orders').add({
          'itemName': 'Fanta',
          'price': 'Rp. 7.000',
          'quantity': fantaQty.value,
          'timestamp': FieldValue.serverTimestamp(),
          'status': 'pending',
        });
      }

      Get.snackbar('Pesanan Ditambahkan', 'Pesanan Anda telah ditambahkan ke My Order');
      goToStartToBuy();
    } catch (e) {
      print("Error adding order: $e");
      Get.snackbar('Error', 'Gagal menambahkan pesanan');
    }
  }

  // Method untuk navigasi ke halaman Start To Buy
  void goToStartToBuy() {
    Get.toNamed('/start_to_buy'); // Sesuaikan dengan route yang benar
  }
}
