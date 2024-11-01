import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SnackController extends GetxController {
  // Reactive variables untuk jumlah snack
  var tempeMendoanQty = 0.obs;
  var kentangGorengQty = 0.obs;

  // Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Method untuk menambah quantity
  void incrementTempeMendoan() {
    tempeMendoanQty++;
  }

  void incrementKentangGoreng() {
    kentangGorengQty++;
  }

  // Method untuk mengurangi quantity
  void decrementTempeMendoan() {
    if (tempeMendoanQty > 0) {
      tempeMendoanQty--;
    }
  }

  void decrementKentangGoreng() {
    if (kentangGorengQty > 0) {
      kentangGorengQty--;
    }
  }

  // Method untuk menambahkan pesanan ke Firestore
  void addToMyOrder() async {
    try {
      if (tempeMendoanQty.value > 0) {
        await _firestore.collection('orders').add({
          'itemName': 'Tempe Mendoan',
          'price': 'Rp. 10.000',
          'quantity': tempeMendoanQty.value,
          'timestamp': FieldValue.serverTimestamp(),
          'status': 'pending',
        });
      }

      if (kentangGorengQty.value > 0) {
        await _firestore.collection('orders').add({
          'itemName': 'Kentang Goreng',
          'price': 'Rp. 8.000',
          'quantity': kentangGorengQty.value,
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
