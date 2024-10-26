import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  var profileImage = ''.obs; // Menggunakan observable untuk menyimpan path gambar

  // Metode untuk mengambil gambar dari galeri atau kamera
  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery); // Mengambil dari galeri

    if (image != null) {
      profileImage.value = image.path; // Menyimpan path gambar
    }
  }

  // Metode untuk navigasi
  void navigateTo(String route) {
    Get.toNamed(route);
  }

  // Metode untuk kembali
  void goBack() {
    Get.back();
  }
}
