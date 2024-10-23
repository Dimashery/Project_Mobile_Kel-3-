import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_routes.dart';

class PageStart extends StatefulWidget {
  const PageStart({super.key});

  @override
  PageStartState createState() => PageStartState();  // Nama class sekarang public tanpa underscore
}

class PageStartState extends State<PageStart> {  // Class sekarang public tanpa underscore
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Get.offNamed(AppRoutes.WELCOME_PAGE);  // Navigasi ke WelcomePage
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/images/logo/doi_coffee.png'),  // Tambahkan logo sesuai gambar yang diinginkan
      ),
    );
  }
}
