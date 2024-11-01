import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileController extends GetxController {
  var profileImageUrl = ''.obs; // Observable untuk URL gambar di Firebase

  final FirebaseStorage storage = FirebaseStorage.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Method untuk mengambil gambar dari galeri
  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      await _uploadImage(File(image.path));
    }
  }

  // Method untuk mengunggah gambar ke Firebase Storage
  Future<void> _uploadImage(File file) async {
    try {
      // Ambil User ID dari autentikasi
      final userId = FirebaseAuth.instance.currentUser!.uid; // Ambil User ID

      // Gunakan User ID untuk menentukan dokumen yang sesuai
      final ref = storage.ref().child('profile_images/$userId/${DateTime.now().toString()}.jpg');
      await ref.putFile(file);
      final url = await ref.getDownloadURL();
      profileImageUrl.value = url;

      // Simpan URL gambar di Firestore dengan User ID
      await firestore.collection('users').doc(userId).update({
        'profileImageUrl': url,
      });
    } catch (e) {
      Get.snackbar('Error', 'Failed to upload image: $e');
    }
  }

  // Method untuk mengambil URL gambar dari Firestore saat profil dimuat
  Future<void> loadProfileImage() async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid; // Ambil User ID
      final userDoc = await firestore.collection('users').doc(userId).get();
      profileImageUrl.value = userDoc['profileImageUrl'] ?? '';
    } catch (e) {
      Get.snackbar('Error', 'Failed to load profile image: $e');
    }
  }

  // Method untuk navigasi
  void navigateTo(String route) {
    Get.toNamed(route);
  }

  void goBack() {
    Get.toNamed('/home');
  }
}
