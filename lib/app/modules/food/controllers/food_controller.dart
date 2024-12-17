import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FoodController extends GetxController {
  var foodMenu = <Map<String, dynamic>>[].obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    loadFoodMenu();
  }

  void loadFoodMenu() async {
    try {
      // Hanya ambil makanan dengan id "Food"
      QuerySnapshot snapshot = await _firestore
          .collection('orders')
          .where('id', isEqualTo: 'Food')
          .get();

      foodMenu.value = snapshot.docs.map((doc) {
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
      print("Error loading food menu: $e");
      Get.snackbar('Error', 'Gagal memuat menu makanan');
    }
  }

  void updateQuantity(String docId, bool isAdd) {
    int index = foodMenu.indexWhere((item) => item["docId"] == docId);
    if (index != -1) {
      foodMenu[index]["quantity"] = isAdd
          ? foodMenu[index]["quantity"] + 1
          : (foodMenu[index]["quantity"] > 0
              ? foodMenu[index]["quantity"] - 1
              : 0);
      foodMenu.refresh();
    }
  }

  void addToMyOrder() async {
    try {
      for (var item in foodMenu) {
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

  void goToStartToBuy() {
    Get.toNamed('/start_to_buy');
  }
}
