import 'package:get/get.dart';

class StartToBuy2Controller extends GetxController {
  // Method untuk navigasi ke halaman yang berbeda
  void navigateTo(String route) {
    Get.toNamed(route);
  }

  // Optional: Method untuk mengambil ringkasan order jika diperlukan
  String getOrderSummary() {
    return '1 x Indomie Goreng - Rp. 15.000\n1 x Nasi Goreng - Rp. 16.000\nTotal: Rp. 31.310';
  }
}
