import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(  // SafeArea added here
      child: Scaffold(
        
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center, // Center-align content horizontally
              children: [
                // Profile Section (Centered)
                Column(
                  mainAxisAlignment: MainAxisAlignment.center, // Center-align vertically
                  children: [
                    // Circular Profile Picture
                    SizedBox(height: 30),

                    CircleAvatar(
                      radius: 40, // Set radius for the circular profile picture
                      backgroundImage: AssetImage('assets/images/profile.jpg'), // Replace with the actual image path
                    ),
                    SizedBox(height: 10), // Space between profile picture and location

                    // Location Text
                    Text(
                      'Malang, Indonesia',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 4),

                    // Greeting Text
                    Text(
                      'Hi, Fulana',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),

                    // Start to Buy Button
                    ElevatedButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.START_TO_BUY);
                      },
                      child: Text('Start to Buy'),
                    ),
                  ],
                ),

                SizedBox(height: 10),

                // Category Section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // Align Category text to the left
                  children: [
                    Text(
                      'Category',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    // Wrap Container with Expanded to allow it to take remaining space
                    Container(
                      height: 90,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          _buildCategoryItem('Food', Icons.fastfood, AppRoutes.FOOD),
                          SizedBox(width: 20), // Add space between category items
                          _buildCategoryItem('Drink', Icons.local_drink, AppRoutes.DRINK),
                          SizedBox(width: 20), // Add space between category items
                          _buildCategoryItem('Snack', Icons.restaurant_menu, AppRoutes.SNACK),
                          SizedBox(width: 20), // Add space between category items
                          _buildCategoryItem('Coffee', Icons.local_cafe, AppRoutes.COFFEE),
                          SizedBox(width: 20), // Add space between category items
                          _buildCategoryItem('Soft Drink', Icons.local_bar, AppRoutes.SOFT_DRINK),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50),

                // What's New Section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
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
                      height: 250, // Tinggi untuk card produk
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          _buildProductItem('Kopi Tubruk', 'Rp. 12.000', 'Normal / Regular', 'assets/images/kopi_tubruk.jpg'),
                          SizedBox(width: 30), // Spasi antar produk
                          _buildProductItem('Es Taro', 'Rp. 15.000', 'Normal / Regular', 'assets/images/es_taro.jpg'),
                          // Tambahkan produk lainnya jika perlu
                        ],
                      ),
                    ),

                  ],
                ),
                SizedBox(height: 50),


                // Favorite Menu Section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
                  children: [
                    SizedBox(height: 20), // Add space between "What's New?" and "Favorite Menu"
                    Text(
                      'Favorite Menu',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 250, // Same height as "What's New?" section for consistency
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          _buildProductItem('Tempe Mendoan', 'Rp. 10.000', 'Normal / Regular', 'assets/images/tempe_mendoan.jpg'),
                          SizedBox(width: 20), // Add space between product items
                          _buildProductItem('Nasi Goreng', 'Rp. 16.000', 'Normal / Regular', 'assets/images/nasi_goreng.jpg'),
                          // Tambahkan produk lain sesuai kebutuhan
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.black,),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.card_giftcard, color: Colors.black,),
              label: 'Voucher',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart, color: Colors.black,),
              label: 'My Order',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, color: Colors.black,),
              label: 'Profile',
            ),
          ],
          currentIndex: 0, // Set the current selected index
          selectedItemColor: const Color.fromARGB(255, 0, 0, 0),
          onTap: (int index) {
            // Add navigation functionality if needed
          },
        ),
      ),
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
          Text(title, style: TextStyle(fontWeight: FontWeight.bold),),
        ],
      ),
    );
  }

  // Helper function to create Product items
  Widget _buildProductItem(String name, String price, String description, String imagePath) {
  return Container(
    width: 270, // Lebar untuk card produk
    margin: EdgeInsets.only(right: 9),
    child: Card(
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gambar produk
          Container(
            height: 140,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imagePath), // Menambahkan gambar produk
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
                Text(price, style: TextStyle(fontSize: 16,),),
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
