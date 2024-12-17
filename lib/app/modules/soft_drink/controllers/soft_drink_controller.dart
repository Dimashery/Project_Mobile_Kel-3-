import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SoftDrinkController extends GetxController {
  var softDrinkMenu = <Map<String, dynamic>>[].obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    loadSoftDrinkMenu();
  }

  void loadSoftDrinkMenu() async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('orders')
          .where('id', isEqualTo: 'SoftDrink')
          .get();

      softDrinkMenu.value = snapshot.docs.map((doc) {
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
      print("Error loading soft drink menu: $e");
      Get.snackbar('Error', 'Gagal memuat menu soft drink');
    }
  }

  void updateQuantity(String docId, bool isAdd) {
    int index = softDrinkMenu.indexWhere((item) => item["docId"] == docId);
    if (index != -1) {
      softDrinkMenu[index]["quantity"] = isAdd
          ? softDrinkMenu[index]["quantity"] + 1
          : (softDrinkMenu[index]["quantity"] > 0
              ? softDrinkMenu[index]["quantity"] - 1
              : 0);
      softDrinkMenu.refresh();
    }
  }

  void addToMyOrder() async {
    try {
      for (var item in softDrinkMenu) {
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
