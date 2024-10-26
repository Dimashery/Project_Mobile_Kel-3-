import 'package:get/get.dart';

class SoftDrinkController extends GetxController {
  // Reactive variables for quantities
  var cocaColaQty = 1.obs;
  var spriteQty = 1.obs;

  // Method to increase quantities
  void incrementCocaCola() {
    cocaColaQty++;
  }

  void incrementSprite() {
    spriteQty++;
  }

  // Method to decrease quantities
  void decrementCocaCola() {
    if (cocaColaQty > 1) {
      cocaColaQty--;
    }
  }

  void decrementSprite() {
    if (spriteQty > 1) {
      spriteQty--;
    }
  }
}
