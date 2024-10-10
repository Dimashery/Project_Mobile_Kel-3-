import 'package:flutter/material.dart';
import '../../../../routes/app_routes.dart';
import 'package:get/get.dart';


class CheckOrderPage extends StatelessWidget {
  const CheckOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Order'),
      ),
      body: Column(
        children: [
          const ListTile(
            title: Text('BCA Virtual Account'),
            subtitle: Text('Rp 31.310'),
          ),
          const ListTile(
            title: Text('1 x Indomie Goreng'),
            subtitle: Text('Rp 15.000'),
          ),
          const ListTile(
            title: Text('1 x Nasi Goreng'),
            subtitle: Text('Rp 16.000'),
          ),
          const ListTile(
            title: Text('Location'),
            subtitle: Text('Jl. Sengkaling, Malang'),
          ),



          ElevatedButton(
            onPressed: () {
                Get.toNamed(AppRoutes.START_TO_BUY);

              // Action to add more orders
            },
            child: const Text('Buy Again'),
          ),
        ],
      ),
    );
  }
}
