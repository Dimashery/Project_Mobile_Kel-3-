import 'package:get/get.dart';
import '../../../routes/app_routes.dart';

class CheckOrderController extends GetxController {
  // Method untuk menavigasi kembali
  void goBack() {
    Get.back();
  }

  // Method untuk melakukan pembelian lagi
  void buyAgain() {
    Get.offNamed(AppRoutes.START_TO_BUY);
  }

  // Contoh fungsi untuk mendapatkan total order
  String getTotalOrder() {
    return 'Rp. 31.310'; // Ganti dengan logika perhitungan yang sesuai
  }

  // Contoh fungsi untuk mendapatkan status pesanan
  String getOrderStatus() {
    return 'Ongoing'; // Ganti dengan status yang sesuai
  }
}
