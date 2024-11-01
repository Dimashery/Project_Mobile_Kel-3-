import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var historyOrders = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchHistoryOrders();
  }

  void fetchHistoryOrders() {
    _firestore.collection('orders').snapshots().listen((snapshot) {
      historyOrders.clear();
      for (var orderDoc in snapshot.docs) {
        var orderData = orderDoc.data();

        // Tambahkan data pesanan tanpa menghitung total price
        historyOrders.add({
          "itemName": orderData['itemName'],
          "price": orderData['price'],
          "quantity": orderData['quantity'],
          "status": orderData['status'],
          "timestamp": orderData['timestamp'],
        });
      }
    });
  }
}
