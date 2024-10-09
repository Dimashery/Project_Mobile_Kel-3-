import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Your App',
      initialRoute: AppPages.INITIAL, // Gunakan INITIAL dari AppPages
      getPages: AppPages.pages, // Menggunakan rute yang sudah didefinisikan
    );
  }
}
