import 'package:get/get.dart';

class MyOrderController extends GetxController {
  // Daftar pesanan (misalnya bisa ditambahkan dinamis di sini)
  List<OrderItem> orderItems = [
    OrderItem(name: 'Indomie Goreng', price: 'Rp. 15.000', imagePath: 'assets/images/food/indomie_goreng.png'),
    OrderItem(name: 'Nasi Goreng', price: 'Rp. 16.000', imagePath: 'assets/images/food/nasi_goreng.png'),
  ];

  String get location => 'Jl. Sengkaling, Malang'; // Lokasi yang dapat dikelola di sini

  void navigateTo(String route) {
    Get.toNamed(route);
  }

  double getSubtotal() {
    return 31000; // Hitung subtotal dari orderItems
  }

  double getTax() {
    return getSubtotal() * 0.1; // Hitung PPN 10%
  }

  double getDiscount() {
    return 0.0; // Hitung diskon jika ada
  }

  double getTotal() {
    return getSubtotal() + getTax() - getDiscount();
  }
}

// Kelas untuk menyimpan item pesanan
class OrderItem {
  final String name;
  final String price;
  final String imagePath;

  OrderItem({required this.name, required this.price, required this.imagePath});
}
