import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../routes/app_routes.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Profile Section with StreamBuilder
                StreamBuilder<DocumentSnapshot>(
                  stream: loadUserProfileStream(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text("Error loading profile data");
                    } else if (!snapshot.hasData || !snapshot.data!.exists) {
                      return Text("Profile data not found");
                    }

                    var userData = snapshot.data!.data() as Map<String, dynamic>;
                    String profileImageUrl = userData['profileImageUrl'] ?? 'assets/images/profile.jpg';
                    String location = userData['location'] ?? 'Location Unknown';
                    String name = userData['name'] ?? 'User';

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 30),
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: profileImageUrl.startsWith('http')
                              ? NetworkImage(profileImageUrl)
                              : AssetImage(profileImageUrl) as ImageProvider,
                        ),
                        SizedBox(height: 10),
                        Text(
                          location,
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Hi, $name',
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
                    );
                  },
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
          currentIndex: 0,
          onTap: (index) {
            switch (index) {
              case 0:
                Get.toNamed(AppRoutes.HOME);
                break;
              case 1:
                Get.toNamed(AppRoutes.FREE_VOUCHER);
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
            BottomNavigationBarItem(icon: Icon(Icons.home, color: Colors.black), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.card_giftcard, color: Colors.black), label: 'Voucher'),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart, color: Colors.black), label: 'My Order'),
            BottomNavigationBarItem(icon: Icon(Icons.person, color: Colors.black), label: 'Profile'),
          ],
        ),
      ),
    );
  }

  // Function to get user profile stream from Firestore
  Stream<DocumentSnapshot> loadUserProfileStream() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final String userId = auth.currentUser!.uid;
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    return firestore.collection('profiles').doc(userId).snapshots();
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
              _buildCategoryItem('Snack', Icons.restaurant_menu, AppRoutes.SNACK),
              SizedBox(width: 20),
              _buildCategoryItem('Coffee', Icons.local_cafe, AppRoutes.COFFEE),
              SizedBox(width: 20),
              _buildCategoryItem('Soft Drink', Icons.local_bar, AppRoutes.SOFT_DRINK),
            ],
          ),
        ),
      ],
    );
  }

  // Helper function to build What's New section
  Widget _buildWhatsNewSection() {
  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance.collection('whats_new').snapshots(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return CircularProgressIndicator();
      }
      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
        return Text('No products available');
      }

      final products = snapshot.data!.docs;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'What\'s New?',
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Container(
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return _buildProductItem(
                  product['name'],
                  'Rp. ${product['price']}',
                  product['description'],
                  product['imageUrl'],
                );
              },
            ),
          ),
        ],
      );
    },
  );
}


  // Helper function to build Favorite Menu section
   // Helper function to build Favorite Menu section
  Widget _buildFavoriteMenuSection() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('favorite_menu').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Text('No favorite menu items available');
        }

        final products = snapshot.data!.docs;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Favorite Menu', style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Container(
              height: 250,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return _buildProductItem(
                    product['name'],
                    'Rp. ${product['price']}',
                    product['description'],
                    product['imageUrl'],
                  );
                },
              ),
            ),
          ],
        );
      },
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
   // Helper function to create Product items
  Widget _buildProductItem(String name, String price, String description, String imagePath) {
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
                  image: NetworkImage(imagePath),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text(price, style: TextStyle(fontSize: 16)),
                  Text(description, style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}