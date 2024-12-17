import 'package:get/get.dart';
import '../controllers/food_admin_controller.dart';

class FoodAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FoodAdminController());
  }
}
