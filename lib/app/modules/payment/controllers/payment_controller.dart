import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class PaymentController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var selectedPaymentMethod = RxnString();
  var completedOrders = <OrderItem>[].obs;

  StreamSubscription? _completedOrdersSubscription;

  @override
  void onInit() {
    super.onInit();
    streamCompletedOrders();
  }

  // Stream untuk mendengarkan pesanan yang statusnya 'completed'
  void streamCompletedOrders() {
    final now = DateTime.now();
    final startOfCurrentHour = DateTime(now.year, now.month, now.day, now.hour);

    // Pastikan stream sebelumnya dibatalkan
    _completedOrdersSubscription?.cancel();

    _completedOrdersSubscription = _firestore
        .collection('orders')
        .where('status', isEqualTo: 'completed')
        .where('timestamp',
            isGreaterThanOrEqualTo: Timestamp.fromDate(startOfCurrentHour))
        .orderBy('timestamp', descending: true)
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      completedOrders.value =
          snapshot.docs.map((doc) => OrderItem.fromDocument(doc)).toList();
    });
  }

  // Memilih metode pembayaran
  void selectPaymentMethod(String? method) {
    selectedPaymentMethod.value = method;
  }

  // Mengubah semua pesanan yang statusnya 'completed' menjadi 'done'
  Future<void> updateAllCompletedOrdersToDone() async {
    final completedOrdersSnapshot = await _firestore
        .collection('orders')
        .where('status', isEqualTo: 'completed')
        .get();

    for (var doc in completedOrdersSnapshot.docs) {
      await _firestore.collection('orders').doc(doc.id).update({
        'status': 'done',
      });
    }
  }

  // Menambahkan data pembayaran ke Firestore
  Future<void> addPaymentData() async {
    try {
      final totalAmount = _getTotal();

      // Menambahkan data pembayaran ke collection payments
      await _firestore.collection('payments').add({
        'paymentMethod': selectedPaymentMethod.value,
        'timestamp': FieldValue.serverTimestamp(),
        'total': totalAmount,
        'itemNames': completedOrders.map((item) => item.name).toList(),
        'status': 'ongoing', // Menambahkan field status
      });

      // Menambahkan status 'done' ke semua pesanan yang sudah diselesaikan
      await updateAllCompletedOrdersToDone();

      // Memperbarui stream
      streamCompletedOrders();

      // Navigasi ke halaman sukses
      Get.toNamed('/transaction-success');
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to process payment: $e',
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  // Mendapatkan total dari pesanan yang statusnya 'completed'
  double _getTotal() {
    return completedOrders.fold(
      0,
      (sum, item) => sum + (item.price * item.quantity),
    );
  }

  String getTotal() {
    return 'Rp. ${_getTotal().toStringAsFixed(0)}';
  }

  @override
  void onClose() {
    _completedOrdersSubscription?.cancel(); // Pastikan stream dihentikan
    super.onClose();
  }
}

// Model OrderItem
class OrderItem {
  final String id;
  final String name;
  final double price;
  final int quantity;
  final String status;

  OrderItem({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.status,
  });

  // Factory untuk mapping dokumen Firestore
  factory OrderItem.fromDocument(DocumentSnapshot doc) {
    return OrderItem(
      id: doc.id,
      name: doc['itemName'] ?? '',
      price: _parsePrice(doc['price'] ?? '0'),
      quantity: doc['quantity']?.toInt() ?? 1,
      status: doc['status'] ?? 'completed',
    );
  }

  // Helper untuk parsing harga
  static double _parsePrice(String price) {
    final cleanedPrice = price.replaceAll('Rp. ', '').replaceAll('.', '');
    return double.tryParse(cleanedPrice) ?? 0.0;
  }
}
