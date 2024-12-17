import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class MyOrderController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var orderItems = <OrderItem>[].obs;
  var location = 'Lokasi Anda'.obs;

  @override
  void onInit() {
    super.onInit();
    clearPreviousOrders();
    streamMyOrders();
    streamUserLocation(); // Memulai stream lokasi pengguna
  }

  // Stream untuk mendengarkan perubahan lokasi pengguna
  void streamUserLocation() {
    final currentUser = _auth.currentUser;
    if (currentUser != null) {
      String userId = currentUser.uid;
      _firestore
          .collection('profiles')
          .doc(userId)
          .snapshots()
          .listen((userDoc) {
        if (userDoc.exists) {
          location.value = userDoc['location'] ?? 'Lokasi tidak tersedia';
        }
      });
    }
  }

  void clearPreviousOrders() {
    orderItems.clear();
    _firestore.collection('orders').get().then((snapshot) {
      for (var doc in snapshot.docs) {
        if (doc['status'] == 'active') {
          _firestore.collection('orders').doc(doc.id).delete();
        }
      }
    });
  }

  void streamMyOrders() {
    _firestore
        .collection('orders')
        .where('status', isEqualTo: "active")
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      orderItems.value =
          snapshot.docs.map((doc) => OrderItem.fromDocument(doc)).toList();
    });
  }

  Future<void> checkOutAndCompleteOrder() async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('orders')
          .where('status', isEqualTo: "active")
          .get();

      for (var doc in snapshot.docs) {
        await _firestore.collection('orders').doc(doc.id).update({
          'status': "completed",
        });
      }

      

      Get.snackbar(
        'Pesanan Diperbarui',
        'Pesanan aktif telah diselesaikan. Lanjutkan ke pembayaran.',
        snackPosition: SnackPosition.TOP,
      );

      Get.toNamed('/payment');
    } catch (e) {
      print("Error during checkout: $e");
      Get.snackbar(
        'Error',
        'Terjadi kesalahan saat memproses pesanan.',
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  Future<void> deleteOrder(String orderId) async {
    try {
      await _firestore.collection('orders').doc(orderId).delete();
      orderItems.removeWhere((item) => item.id == orderId);
      Get.snackbar(
        'Pesanan Dihapus',
        'Pesanan berhasil dihapus.',
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal menghapus pesanan.',
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  double getSubtotal() {
    return orderItems.fold(
        0, (sum, item) => sum + (item.price * item.quantity));
  }

  double getTax() => getSubtotal() * 0.1;
  double getDiscount() => 0;
  double getTotal() => getSubtotal() + getTax() - getDiscount();
}

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

  factory OrderItem.fromDocument(DocumentSnapshot doc) {
    return OrderItem(
      id: doc.id,
      name: doc['itemName'] ?? '',
      price: _parsePrice(doc['price'] ?? '0'),
      quantity: doc['quantity']?.toInt() ?? 1,
      status: doc['status'] ?? 'active',
    );
  }

  static double _parsePrice(String price) {
    final cleanedPrice = price.replaceAll('Rp. ', '').replaceAll('.', '');
    return double.tryParse(cleanedPrice) ?? 0.0;
  }
}
