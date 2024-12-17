import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SnackController extends GetxController {
  var snackMenu = <Map<String, dynamic>>[].obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    loadSnackMenu();
  }

  // Fetch snack menu from Firestore where 'id' is 'Snack'
  void loadSnackMenu() async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('orders')
          .where('id', isEqualTo: 'Snack')
          .get();

      snackMenu.value = snapshot.docs.map((doc) {
        return {
          "docId": doc.id,
          "itemName": doc["itemName"],
          "price": doc["price"],
          "imageUrl": doc["imageUrl"],
          "description": doc["description"],
          "quantity": 0, // Default quantity
        };
      }).toList();
    } catch (e) {
      print("Error loading snack menu: $e");
      Get.snackbar('Error', 'Gagal memuat menu snack');
    }
  }

  // Update quantity of snack item
  void updateQuantity(String docId, bool isAdd) {
    int index = snackMenu.indexWhere((item) => item["docId"] == docId);
    if (index != -1) {
      snackMenu[index]["quantity"] = isAdd
          ? snackMenu[index]["quantity"] + 1
          : (snackMenu[index]["quantity"] > 0
              ? snackMenu[index]["quantity"] - 1
              : 0);
      snackMenu.refresh();
    }
  }

  // Add snack items to My Order
  void addToMyOrder() async {
    try {
      for (var item in snackMenu) {
        if (item["quantity"] > 0) {
          await _firestore.collection('orders').add({
            'itemName': item["itemName"],
            'price': item["price"],
            'quantity': item["quantity"],
            'status': 'active',
            'timestamp': FieldValue.serverTimestamp(),
          });
        }
      }
      Get.snackbar('Pesanan Ditambahkan', 'Pesanan Anda telah ditambahkan ke My Order');
      goToStartToBuy();
    } catch (e) {
      print("Error adding order: $e");
      Get.snackbar('Error', 'Gagal menambahkan pesanan');
    }
  }

  // Navigation to 'Start to Buy' page
  void goToStartToBuy() {
    Get.toNamed('/start_to_buy');
  }
}
