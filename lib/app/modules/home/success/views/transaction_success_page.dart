import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_routes.dart';


class TransactionSuccessPage extends StatelessWidget {
  const TransactionSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, size: 100, color: Colors.green),

            const SizedBox(height: 20),
            const Text('Your Payment is Complete', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Get.toNamed(AppRoutes.CHECK_ORDER);
              },
              
              child: const Text('Check Your Order', style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
}
