import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';


class TransactionSuccessPage extends StatelessWidget {
  const TransactionSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, size: 100, color: Color.fromARGB(255, 0, 0, 0)),

            const SizedBox(height: 20),
            const Text('Your Payment is Complete', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
            const SizedBox(height: 20),

            GestureDetector(
                onTap: () {
                  Get.offNamed(AppRoutes.CHECK_ORDER);  // Kembali ke halaman Login
                },
                child: Container(
                  width: 250,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Text(
                      "Check Your Order",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
