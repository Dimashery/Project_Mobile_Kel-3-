import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.find<ProfileController>(); // Using Get.find to access the existing controller instance

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(), // Back to the previous screen
        ),
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
                        // Show dialog to choose between camera or gallery
                        _showImagePickerDialog(context, controller);
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

  // Show a dialog to let the user choose between camera or gallery
  void _showImagePickerDialog(BuildContext context, ProfileController controller) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pick Profile Image'),
        content: const Text('Choose an option to select your profile image.'),
        actions: [
          TextButton(
            onPressed: () {
              controller.pickImage(fromCamera: true); // Pass fromCamera as a named argument
              Navigator.of(context).pop();
            },
            child: const Text('Take Photo'),
          ),
          TextButton(
            onPressed: () {
              controller.pickImage(fromCamera: false); // Pass fromCamera as a named argument
              Navigator.of(context).pop();
            },
            child: const Text('Choose from Gallery'),
          ),
        ],
      ),
    );
  }
}