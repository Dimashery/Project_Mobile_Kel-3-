import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doi_coffee/app/modules/profile/views/edit_profile.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfileController extends GetxController {
  final userName = ''.obs;
  final userLocation = ''.obs;
  final userPhone = ''.obs;
  final profileImageUrl = ''.obs;

  final nameController = TextEditingController();
  final locationController = TextEditingController();
  final phoneController = TextEditingController();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    listenToProfileChanges(); // Start listening for real-time updates
  }

  // Listen to real-time changes in Firestore
  void listenToProfileChanges() {
    final currentUser = _auth.currentUser;
    if (currentUser != null) {
      String userId = currentUser.uid;

      firestore.collection('profiles').doc(userId).snapshots().listen((userDoc) {
        if (userDoc.exists) {
          userName.value = userDoc['name'] ?? '';
          userLocation.value = userDoc['location'] ?? '';
          userPhone.value = userDoc['phone'] ?? '';
          profileImageUrl.value = userDoc['profileImageUrl'] ?? '';

          // Update the text controllers for editing profile
          nameController.text = userName.value;
          locationController.text = userLocation.value;
          phoneController.text = userPhone.value;
        }
      });
    }
  }

  void goBack() {
    Get.back();
  }

  void goToEditProfile() {
    Get.to(() => const EditProfileView());
  }

  // Navigation handler
  void navigateTo(String route) {
    Get.toNamed(route);
  }

  // Request permission for gallery and camera access
  Future<void> requestPermission(Permission permission) async {
    PermissionStatus status = await permission.request();

    if (status.isGranted) {
      print("Permission granted");
    } else if (status.isDenied) {
      print("Permission denied");
    } else if (status.isPermanentlyDenied) {
      openAppSettings(); // Open settings to allow the user to enable permissions manually
    }
  }

  // Show a dialog to choose between gallery and camera
  void chooseImageSource() async {
    // Request permission for gallery and camera
    await requestPermission(Permission.photos); // Request permission for photos
    await requestPermission(Permission.camera); // Request permission for camera if taking a picture

    showDialog(
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          title: Text('Choose Image Source'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera),
                title: Text('Take a Photo'),
                onTap: () {
                  Navigator.pop(context);
                  pickImage(fromCamera: true); // Use camera
                },
              ),
              ListTile(
                leading: Icon(Icons.photo),
                title: Text('Choose from Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  pickImage(fromCamera: false); // Use gallery
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Pick and upload profile image (either from gallery or camera)
  void pickImage({required bool fromCamera}) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = fromCamera
        ? await picker.pickImage(source: ImageSource.camera)
        : await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final currentUser = _auth.currentUser;
      if (currentUser != null) {
        String userId = currentUser.uid;
        final uploadTask = storage.ref('profile_images/$userId/${file.path.split('/').last}').putFile(file);
        final snapshot = await uploadTask;
        profileImageUrl.value = await snapshot.ref.getDownloadURL();
        updateProfileImageInFirestore(profileImageUrl.value);
      }
    }
  }

  // Save profile data to Firestore
  void saveProfile() async {
    final currentUser = _auth.currentUser;
    if (currentUser != null) {
      String userId = currentUser.uid;
      userName.value = nameController.text;
      userLocation.value = locationController.text;
      userPhone.value = phoneController.text;

      await firestore.collection('profiles').doc(userId).set({
        'name': userName.value,
        'location': userLocation.value,
        'phone': userPhone.value,
        'profileImageUrl': profileImageUrl.value,
      });
      Get.back();
    }
  }

  // Update profile image URL only in Firestore
  void updateProfileImageInFirestore(String url) async {
    final currentUser = _auth.currentUser;
    if (currentUser != null) {
      String userId = currentUser.uid;
      await firestore.collection('profiles').doc(userId).update({
        'profileImageUrl': url,
      });
    }
  }
}