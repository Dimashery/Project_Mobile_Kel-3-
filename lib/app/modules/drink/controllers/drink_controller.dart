import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DrinkController extends GetxController {
  // Reactive variables untuk jumlah minuman
  var esTehQty = 0.obs;  // Jumlah untuk Es Teh
  var esJerukQty = 0.obs; // Jumlah untuk Es Jeruk

  // Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Method untuk menambah jumlah
  void incrementEsTeh() {
    esTehQty++;
  }

  void decrementEsTeh() {
    if (esTehQty > 0) esTehQty--;
  }

  void incrementEsJeruk() {
    esJerukQty++;
  }

  void decrementEsJeruk() {
    if (esJerukQty > 0) esJerukQty--;
  }

  // Method untuk menambahkan pesanan ke Firestore
  void addToMyOrder() async {
    try {
      if (esTehQty.value > 0) {
        await _firestore.collection('orders').add({
          'itemName': 'Es Teh',
          'price': 'Rp. 5.000',
          'quantity': esTehQty.value,
          'timestamp': FieldValue.serverTimestamp(),
          'status': 'pending',
        });
      }

      if (esJerukQty.value > 0) {
        await _firestore.collection('orders').add({
          'itemName': 'Es Jeruk',
          'price': 'Rp. 7.000',
          'quantity': esJerukQty.value,
          'timestamp': FieldValue.serverTimestamp(),
          'status': 'pending',
        });
      }

      Get.snackbar('Pesanan Ditambahkan', 'Pesanan minuman Anda telah ditambahkan ke My Order');
      goToStartToBuy();
    } catch (e) {
      print("Error menambahkan pesanan: $e");
      Get.snackbar('Error', 'Gagal menambahkan pesanan minuman');
    }
  }

  // Method untuk navigasi ke halaman My Order
  void goToStartToBuy() {
    Get.toNamed('/start_to_buy'); // Ganti dengan route yang sesuai jika perlu
  }
}
