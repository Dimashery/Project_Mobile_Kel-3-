import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.find<ProfileController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Profile Image with Edit Option
                    Obx(() => GestureDetector(
                      onTap: () {
                        controller.pickImage();
                      },
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey[300],
                        backgroundImage: controller.profileImageUrl.value.isNotEmpty
                            ? NetworkImage(controller.profileImageUrl.value)
                            : const AssetImage('assets/images/default_avatar.png') as ImageProvider,
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: CircleAvatar(
                            radius: 16,
                            backgroundColor: Colors.white,
                            child: const Icon(Icons.camera_alt, size: 16, color: Colors.grey),
                          ),
                        ),
                      ),
                    )),
                    const SizedBox(height: 20),
                    
                    // Name Field
                    TextField(
                      controller: controller.nameController,
                      decoration: const InputDecoration(labelText: "Name"),
                    ),
                    
                    // Location Field
                    TextField(
                      controller: controller.locationController,
                      decoration: const InputDecoration(labelText: "Location"),
                    ),
                    
                    // Phone Number Field
                    TextField(
                      controller: controller.phoneController,
                      decoration: const InputDecoration(labelText: "Phone Number"),
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Save Changes Button
                    ElevatedButton(
                      onPressed: controller.saveProfile,
                      child: const Text("Save Changes"),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
