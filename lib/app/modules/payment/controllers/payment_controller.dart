import 'package:get/get.dart';
import '../../../routes/app_routes.dart';

class PaymentController extends GetxController {
  String? selectedPaymentMethod; // Menyimpan metode pembayaran yang dipilih

  // Metode untuk memilih pembayaran
  void selectPaymentMethod(String? method) {
    selectedPaymentMethod = method;
    update(); // Memperbarui tampilan setelah memilih metode
  }

  // Metode untuk mengonfirmasi pembayaran
  void confirmPayment() {
    // Logika untuk memproses pembayaran (jika ada)
    Get.toNamed(AppRoutes.TRANSACTION_SUCCESS); // Arahkan ke halaman transaksi berhasil
  }

  // Mendapatkan total harga
  String getTotal() {
    return 'Rp. 31.310'; // Ganti dengan perhitungan total yang sesuai jika perlu
  }
}
