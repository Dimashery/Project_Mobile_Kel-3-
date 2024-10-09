import 'package:doi_coffee/app/routes/app_routes.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  void navigateToStartToBuy() {
    print('Navigating to StartToBuy...');
    Get.toNamed(AppRoutes.START_TO_BUY); // Pastikan ini menggunakan nama rute yang benar
  }
}
