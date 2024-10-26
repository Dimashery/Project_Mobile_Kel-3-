import 'package:get/get.dart';

class CoffeeController extends GetxController {
  // Reactive variable untuk jumlah kopi
  var kopiTubrukQty = 1.obs;
  var esTaroQty = 1.obs;

  // Method untuk menambah kuantitas
  void incrementKopiTubruk() {
    kopiTubrukQty++;
  }

  void incrementEsTaro() {
    esTaroQty++;
  }

  // Method untuk mengurangi kuantitas
  void decrementKopiTubruk() {
    if (kopiTubrukQty > 1) {
      kopiTubrukQty--;
    }
  }

  void decrementEsTaro() {
    if (esTaroQty > 1) {
      esTaroQty--;
    }
  }
}
