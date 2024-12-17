import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CheckOrderController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var ongoingOrders = <CoffeeOrder>[].obs; // List for ongoing orders
  var completedOrders = <CoffeeOrder>[].obs; // List for completed orders
  var _orderCount = 0.obs; // Keeps track of total order count

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  void goBack() {
    Get.toNamed('/profile');
  }

  void buyAgain() {
    Get.toNamed('/start_to_buy');
  }

  void fetchOrders() {
    print("Setting up real-time listener for orders...");
  
    _firestore
        .collection('payments')
        .where('status', isEqualTo: 'ongoing') // Filter for ongoing status
        .orderBy('timestamp', descending: true) // Order by newest first
        .snapshots() // Real-time listener
        .listen((QuerySnapshot snapshot) {
      print("Orders updated: ${snapshot.docs.length}");
      
      // Map Firestore data to CoffeeOrder model
      ongoingOrders.value = snapshot.docs
          .map((doc) => CoffeeOrder.fromDocument(doc))
          .toList();
      
      print("Orders mapped: ${ongoingOrders.length}");
      _orderCount.value = ongoingOrders.length; // Update order count
    }, onError: (error) {
      print("Error fetching real-time orders: $error");
      ongoingOrders.value = [];
    });
  }

  // Mark order as complete
  void completeOrder(CoffeeOrder order) {
    ongoingOrders.remove(order);
    completedOrders.add(order);
    // Update Firestore if needed (optional)
  }

  // Get total number of orders
  int getOrderCount() {
    return _orderCount.value;
  }

  // Add new order (example function)
  void addOrder() async {
    await _firestore.collection('payments').add({
      'itemNames': ['Espresso', 'Cappuccino'],
      'paymentMethod': 'Cash',
      'status': 'ongoing',
      'timestamp': Timestamp.now(),
      'total': 50000,
    });
    print("Order added!");
  }
}

// CoffeeOrder model
class CoffeeOrder {
  final String id;
  final List<String> itemNames;
  final String paymentMethod;
  final String status;
  final DateTime timestamp;
  final int total;

  CoffeeOrder({
    required this.id,
    required this.itemNames,
    required this.paymentMethod,
    required this.status,
    required this.timestamp,
    required this.total,
  });

  factory CoffeeOrder.fromDocument(DocumentSnapshot doc) {
    print("Document Data: ${doc.data()}");
    
    return CoffeeOrder(
      id: doc.id,
      itemNames: List<String>.from(doc['itemNames'] ?? []),
      paymentMethod: doc['paymentMethod'] ?? '',
      status: doc['status'] ?? '',
      timestamp: doc['timestamp'] != null ? (doc['timestamp'] as Timestamp).toDate() : DateTime.now(),
      total: (doc['total'] as num).toInt(), // Convert `double` or `int` to `int`
    );
  }
}
