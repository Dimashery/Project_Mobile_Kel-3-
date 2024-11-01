import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';
import '../../order/controllers/my_order_controller.dart';

class PaymentController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? selectedPaymentMethod;

  // Mendapatkan instance MyOrderController untuk mengambil data pesanan
  final MyOrderController _orderController = Get.find<MyOrderController>();

  // Metode untuk memilih metode pembayaran
  void selectPaymentMethod(String? method) {
    selectedPaymentMethod = method;
    update();
  }

  // Fungsi untuk menyimpan metode pembayaran ke Firestore
  Future<void> savePaymentMethod(String orderId) async {
    if (selectedPaymentMethod == null) return;
    await _firestore.collection('payments').add({
      'paymentMethod': selectedPaymentMethod,
      'total': _orderController.getTotal(),
      'timestamp': FieldValue.serverTimestamp(),
      'orderId': orderId, // Menyimpan orderId di dokumen payments
    });
  }

  // Konfirmasi pembayaran dan simpan data ke Firestore
  void confirmPayment(String orderId) {
    Get.defaultDialog(
      title: "Konfirmasi Pembayaran",
      middleText: "Apakah Anda sudah memilih metode pembayaran dengan benar?",
      textCancel: "Belum",
      textConfirm: "Iya",
      confirmTextColor: Colors.white,
      onConfirm: () async {
        await savePaymentMethod(orderId); // Menyimpan metode pembayaran
        Get.back(); // Tutup dialog
        Get.toNamed(AppRoutes.TRANSACTION_SUCCESS);
      },
    );
  }

  // Mendapatkan total harga pesanan dari MyOrderController
  String getTotal() {
    return 'Rp. ${_orderController.getTotal().toStringAsFixed(0)}';
  }
}
