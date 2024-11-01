import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CoffeeController extends GetxController {
  var kopiTubrukQty = 0.obs;
  var cappucinoQty = 0.obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void incrementKopiTubruk() {
    kopiTubrukQty++;
  }

  void decrementKopiTubruk() {
    if (kopiTubrukQty > 0) {
      kopiTubrukQty--;
    }
  }

  void incrementCappucino() {
    cappucinoQty++;
  }

  void decrementCappucino() {
    if (cappucinoQty > 0) {
      cappucinoQty--;
    }
  }

  // Method to save order to Firestore
  void addToMyOrder() async {
    try {
      if (kopiTubrukQty.value > 0) {
        await _firestore.collection('orders').add({
          'itemName': 'Kopi Tubruk',
          'price': 'Rp. 7.000',
          'quantity': kopiTubrukQty.value,
          'timestamp': FieldValue.serverTimestamp(),
          'status': 'pending',
        });
      }

      if (cappucinoQty.value > 0) {
        await _firestore.collection('orders').add({
          'itemName': 'Cappucino',
          'price': 'Rp. 10.000',
          'quantity': cappucinoQty.value,
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

  void goToStartToBuy() {
    Get.toNamed('/start_to_buy');
  }
}
