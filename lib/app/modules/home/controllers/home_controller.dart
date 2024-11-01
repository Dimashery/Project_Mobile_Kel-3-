import 'dart:io';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

class HomeController extends GetxController {
  final FirebaseStorage storage = FirebaseStorage.instance;

  void navigateToStartToBuy() {
    // ignore: avoid_print
    print('Navigating to StartToBuy...');
    Get.toNamed('/start_to_buy'); // Pastikan ini menggunakan nama rute yang benar
  }

  // Fungsi untuk mengunggah gambar
  Future<void> uploadImage(String imagePath) async {
    try {
      // Mendapatkan nama file dari path
      String fileName = path.basename(imagePath);
      // Referensi ke lokasi penyimpanan
      Reference ref = storage.ref().child('profile_images/$fileName');

      // Mengunggah file
      await ref.putFile(File(imagePath));

      // Mendapatkan URL download
      String downloadUrl = await ref.getDownloadURL();

      // Anda dapat menyimpan downloadUrl ke database atau melakukan tindakan lain
      print('Image uploaded: $downloadUrl');

      // Optionally, update the UI or notify the user
      Get.snackbar('Success', 'Profile image updated successfully!');
    } catch (e) {
      print('Error uploading image: $e');
      Get.snackbar('Error', 'Failed to upload image: $e');
    }
  }
}
