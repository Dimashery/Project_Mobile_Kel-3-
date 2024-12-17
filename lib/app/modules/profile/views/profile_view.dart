import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());

    // Get screen width for responsiveness
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
           onPressed: () => Get.toNamed('/home'),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Section
              Row(
                children: [
                  Obx(() => GestureDetector(
                    onTap: () {
                      controller.pickImage();
                    },
                    child: CircleAvatar(
                      radius: screenWidth * 0.08,
                      backgroundColor: Colors.grey[300],
                      backgroundImage: controller.profileImageUrl.value.isNotEmpty
                          ? NetworkImage(controller.profileImageUrl.value)
                          : const AssetImage('assets/images/default_avatar.png') as ImageProvider,
                    ),
                  )),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Obx(() => Text(
                                controller.userName.value,
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              )),
                            ),
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.black, size: 20),
                              onPressed: controller.goToEditProfile, // Navigates to Edit Profile
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Obx(() => Text(
                          controller.userLocation.value,
                          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                        )),
                        const SizedBox(height: 4),
                        Obx(() => Text(
                          controller.userPhone.value,
                          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                        )),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),

              // MyAccount Section
              const Text(
                'My Account',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(height: 15),

              // List of Menu Items
              ListTile(
                title: const Text('Your Orders'),
                onTap: () => controller.navigateTo('/check-order'),
              ),
              ListTile(
                title: const Text('Favorite Menu'),
                onTap: () => controller.navigateTo('/favorite'),
              ),
              ListTile(
                title: const Text('History'),
                onTap: () => controller.navigateTo('/history'),
              ),
              ListTile(
                title: const Text('Language'),
                onTap: () => controller.navigateTo('/language'),
              ),
              ListTile(
                title: const Text('Notification'),
                onTap: () => controller.navigateTo('/notification'),
              ),
              ListTile(
                title: const Text('Account Security'),
                onTap: () => controller.navigateTo('/account_security'),
              ),
              ListTile(
                title: const Text('Invite Your Get Free Voucher'),
                onTap: () => controller.navigateTo('/free_voucher'),
              ),
              ListTile(
                title: const Text('Give Us Rating'),
                onTap: () => controller.navigateTo('/give_rating'),
              ),
              ListTile(
                title: const Text('Account Settings'),
                onTap: () => controller.navigateTo('/account_settings'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
