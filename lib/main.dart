import 'package:doi_coffee/app/modules/auth/controllers/auth_controller.dart';
import 'package:doi_coffee/app/modules/order/controllers/my_order_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app/routes/app_pages.dart';
import 'app/modules/profile/controllers/profile_controller.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(ProfileController()); // Inisialisasi ProfileController
  Get.put(AuthController()); // Inisialisasi AuthController

  Get.put(MyOrderController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Do\'i Coffee',
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.pages,
    );
  }
}
