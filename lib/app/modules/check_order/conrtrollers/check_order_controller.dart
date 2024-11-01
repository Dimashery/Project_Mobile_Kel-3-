import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../routes/app_routes.dart';

class CheckOrderController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var ongoingOrders = <CoffeeOrder>[].obs;
  var completedOrders = <CoffeeOrder>[].obs; // New list for completed orders
  var _orderCount = 0.obs; // Menyimpan jumlah total pesanan

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  void goBack() {
    Get.toNamed('/profile');
  }

  void buyAgain() {
    Get.offNamed(AppRoutes.START_TO_BUY);
  }

  // Mengambil data pesanan dari Firestore
  Future<void> fetchOrders() async {
    try {
      final QuerySnapshot snapshot = await _firestore.collection('orders').get();
      ongoingOrders.value = snapshot.docs.map((doc) => CoffeeOrder.fromDocument(doc)).toList();
      _orderCount.value = ongoingOrders.length; // Mengupdate jumlah pesanan
    } catch (e) {
      print("Error fetching orders: $e");
      ongoingOrders.value = [];
    }
  }

  // Menandai pesanan sebagai selesai
  void completeOrder(CoffeeOrder order) {
    ongoingOrders.remove(order);
    completedOrders.add(order);
    // Optionally, you can update Firestore if needed
  }

  // Mengambil jumlah total pesanan
  int getOrderCount() {
    return _orderCount.value;
  }
}

// Model untuk CoffeeOrder
class CoffeeOrder {
  final String id;
  final String itemName;
  final String price;
  final int quantity;
  final String status;

  CoffeeOrder({
    required this.id,
    required this.itemName,
    required this.price,
    required this.quantity,
    required this.status,
  });

  factory CoffeeOrder.fromDocument(DocumentSnapshot doc) {
    return CoffeeOrder(
      id: doc.id,
      itemName: doc['itemName'] ?? '',
      price: doc['price'] ?? '',
      quantity: doc['quantity'] ?? 0,
      status: doc['status'] ?? '',
    );
  }
}
