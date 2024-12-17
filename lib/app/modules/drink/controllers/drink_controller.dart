import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DrinkController extends GetxController {
  var drinkMenu = <Map<String, dynamic>>[].obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    loadDrinkMenu();
  }

  void loadDrinkMenu() async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('orders')
          .where('id', isEqualTo: 'Drink')
          .get();

      drinkMenu.value = snapshot.docs.map((doc) {
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
      print("Error loading drink menu: $e");
      Get.snackbar('Error', 'Gagal memuat menu minuman');
    }
  }

  void updateQuantity(String docId, bool isAdd) {
    int index = drinkMenu.indexWhere((item) => item["docId"] == docId);
    if (index != -1) {
      drinkMenu[index]["quantity"] = isAdd
          ? drinkMenu[index]["quantity"] + 1
          : (drinkMenu[index]["quantity"] > 0
              ? drinkMenu[index]["quantity"] - 1
              : 0);
      drinkMenu.refresh();
    }
  }

  void addToMyOrder() async {
    try {
      for (var item in drinkMenu) {
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
