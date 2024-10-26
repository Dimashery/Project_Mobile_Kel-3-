import 'package:get/get.dart';

class FoodController extends GetxController {
  // Reactive variables untuk jumlah makanan
  var indomieGorengQty = 1.obs; // Quantity for Indomie Goreng
  var nasiGorengQty = 1.obs;    // Quantity for Nasi Goreng

  // Method untuk menambah quantity
  void addIndomieGoreng() {
    indomieGorengQty++;
  }

  void removeIndomieGoreng() {
    if (indomieGorengQty > 1) indomieGorengQty--;
  }

  void addNasiGoreng() {
    nasiGorengQty++;
  }

  void removeNasiGoreng() {
    if (nasiGorengQty > 1) nasiGorengQty--;
  }

  // Method untuk navigasi
  void goToStartToBuy() {
    Get.toNamed('/start_to_buy'); // Ganti dengan route yang sesuai jika perlu
  }
}
