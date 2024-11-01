import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FoodController extends GetxController {
  // Reactive variables untuk jumlah makanan
  var indomieGorengQty = 0.obs; // Quantity for Indomie Goreng
  var nasiGorengQty = 0.obs;    // Quantity for Nasi Goreng

  // Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Method untuk menambah quantity
  void addIndomieGoreng() {
    indomieGorengQty++;
  }


  void removeIndomieGoreng() {
    if (indomieGorengQty > 0) indomieGorengQty--;
  }

  void addNasiGoreng() {
    nasiGorengQty++;
  }

  void removeNasiGoreng() {
    if (nasiGorengQty > 0) nasiGorengQty--;
  }

  // Method untuk menambahkan pesanan ke Firestore
  void addToMyOrder() async {
    try {
      if (indomieGorengQty.value > 0) {
        await _firestore.collection('orders').add({
          'itemName': 'Indomie Goreng',
          'price': 'Rp. 15.000',
          'quantity': indomieGorengQty.value,
          'timestamp': FieldValue.serverTimestamp(),
          'status': 'pending',
        });
      }

      if (nasiGorengQty.value > 0) {
        await _firestore.collection('orders').add({
          'itemName': 'Nasi Goreng',
          'price': 'Rp. 16.000',
          'quantity': nasiGorengQty.value,
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

  // Method untuk navigasi
  void goToStartToBuy() {
    Get.toNamed('/start_to_buy'); // Ganti dengan route yang sesuai jika perlu
  }
}
