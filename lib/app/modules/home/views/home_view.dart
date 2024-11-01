// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';
import '../../profile/controllers/profile_controller.dart';


class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {

    final ProfileController profileController = Get.find<ProfileController>();
    
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Profile Section
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 30),
                    // Profile Section
                    Obx(() => CircleAvatar(
                          radius: 40,
                          backgroundImage: profileController
                                  .profileImageUrl.value.isNotEmpty
                              ? NetworkImage(
                                  profileController.profileImageUrl.value)
                              : AssetImage('assets/images/default_avatar.png')
                                  as ImageProvider,
                        )),
                    SizedBox(height: 10),
                    Text(
                      'Malang, Indonesia',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Hi, Fulana',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.START_TO_BUY);
                      },
                      child: Text('Start to Buy'),
                    ),
                  ],
                ),
                SizedBox(height: 20), // Space before Category section

                // Category Section
                _buildCategorySection(),

                SizedBox(height: 50),

                // What's New Section
                _buildWhatsNewSection(),

                SizedBox(height: 50),

                // Favorite Menu Section
                _buildFavoriteMenuSection(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 0, // Index aktif
          onTap: (index) {
            switch (index) {
              case 0:
                Get.toNamed(AppRoutes.HOME);
                break;
              case 2:
                Get.toNamed(AppRoutes.MY_ORDER);
                break;
              case 3:
                Get.toNamed(AppRoutes.PROFILE);
                break;
            }
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home, color: Colors.black), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.card_giftcard, color: Colors.black),
                label: 'Voucher'),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart, color: Colors.black),
                label: 'My Order'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person, color: Colors.black),
                label: 'Profile'),
          ],
        ),
      ),
    );
  }

  // Helper function to build Category section
  Widget _buildCategorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Category',
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20),
        Container(
          height: 90,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildCategoryItem('Food', Icons.fastfood, AppRoutes.FOOD),
              SizedBox(width: 20),
              _buildCategoryItem('Drink', Icons.local_drink, AppRoutes.DRINK),
              SizedBox(width: 20),
              _buildCategoryItem(
                  'Snack', Icons.restaurant_menu, AppRoutes.SNACK),
              SizedBox(width: 20),
              _buildCategoryItem('Coffee', Icons.local_cafe, AppRoutes.COFFEE),
              SizedBox(width: 20),
              _buildCategoryItem(
                  'Soft Drink', Icons.local_bar, AppRoutes.SOFT_DRINK),
            ],
          ),
        ),
      ],
    );
  }

  // Helper function to build What's New section
  Widget _buildWhatsNewSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'What\'s New?',
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20),
        Container(
          height: 250,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildProductItem('Kopi Tubruk', 'Rp. 12.000', 'Normal / Regular',
                  'assets/images/kopi_tubruk.jpg'),
              SizedBox(width: 30),
              _buildProductItem('Es Taro', 'Rp. 15.000', 'Normal / Regular',
                  'assets/images/es_taro.jpg'),
            ],
          ),
        ),
      ],
    );
  }

  // Helper function to build Favorite Menu section
  Widget _buildFavoriteMenuSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Favorite Menu',
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20),
        Container(
          height: 250,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildProductItem('Tempe Mendoan', 'Rp. 10.000',
                  'Normal / Regular', 'assets/images/tempe_mendoan.jpg'),
              SizedBox(width: 20),
              _buildProductItem('Nasi Goreng', 'Rp. 16.000', 'Normal / Regular',
                  'assets/images/nasi_goreng.jpg'),
            ],
          ),
        ),
      ],
    );
  }

  // Helper function to create Category items
  Widget _buildCategoryItem(String title, IconData icon, String route) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(route);
      },
      child: Column(
        children: [
          SizedBox(width: 70),
          CircleAvatar(
            radius: 30,
            child: Icon(icon, size: 28),
          ),
          SizedBox(height: 10),
          Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  // Helper function to create Product items
  Widget _buildProductItem(
      String name, String price, String description, String imagePath) {
    return Container(
      width: 270,
      margin: EdgeInsets.only(right: 9),
      child: Card(
        elevation: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 140,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(price, style: TextStyle(fontSize: 16)),
                  Text(
                    description,
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
