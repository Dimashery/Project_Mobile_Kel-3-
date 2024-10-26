import 'package:get/get.dart';

class SnackController extends GetxController {
  // Reactive variable untuk jumlah snack
  var tempeMendoanQty = 1.obs;
  var kentangGorengQty = 1.obs;

  // Method untuk menambah kuantitas
  void incrementTempeMendoan() {
    tempeMendoanQty++;
  }

  void incrementKentangGoreng() {
    kentangGorengQty++;
  }

  // Method untuk mengurangi kuantitas
  void decrementTempeMendoan() {
    if (tempeMendoanQty > 1) {
      tempeMendoanQty--;
    }
  }

  void decrementKentangGoreng() {
    if (kentangGorengQty > 1) {
      kentangGorengQty--;
    }
  }
}
