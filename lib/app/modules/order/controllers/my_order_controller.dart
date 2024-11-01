import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyOrderController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var orderItems = <OrderItem>[].obs; // Observable list for real-time updates
  var location = 'Lokasi Anda'.obs;

  @override
  void onInit() {
    super.onInit();
    getMyOrders();
  }

  Future<void> getMyOrders() async {
    try {
      final QuerySnapshot snapshot = await _firestore.collection('orders').get();
      orderItems.value = snapshot.docs.map((doc) => OrderItem.fromDocument(doc)).toList();
    } catch (e) {
      print("Error fetching orders: $e");
      orderItems.value = [];
    }
  }

  Future<void> deleteOrderItem(String orderId) async {
    try {
      await _firestore.collection('orders').doc(orderId).delete();
      orderItems.removeWhere((item) => item.id == orderId);
    } catch (e) {
      print("Error deleting order item: $e");
    }
  }

  double getSubtotal() {
    return orderItems.fold(0, (sum, item) => sum + (item.price * item.quantity));
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

  OrderItem({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
  });

  factory OrderItem.fromDocument(DocumentSnapshot doc) {
    return OrderItem(
      id: doc.id,
      name: doc['itemName'] ?? '',
      price: _parsePrice(doc['price'] ?? '0'),
      quantity: doc['quantity']?.toInt() ?? 1,
    );
  }

  static double _parsePrice(String price) {
    final cleanedPrice = price.replaceAll('Rp. ', '').replaceAll('.', '');
    return double.tryParse(cleanedPrice) ?? 0.0;
  }
}
