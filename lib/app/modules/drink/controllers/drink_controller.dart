import 'package:get/get.dart';

class DrinkController extends GetxController {
  // Reactive variables for quantities
  var esTehQty = 1.obs;  // Quantity for Es Teh
  var esJerukQty = 1.obs; // Quantity for Es Jeruk

  // Method to increment quantity
  void incrementEsTeh() {
    esTehQty++;
  }

  void decrementEsTeh() {
    if (esTehQty > 1) esTehQty--;
  }

  void incrementEsJeruk() {
    esJerukQty++;
  }

  void decrementEsJeruk() {
    if (esJerukQty > 1) esJerukQty--;
  }
}
