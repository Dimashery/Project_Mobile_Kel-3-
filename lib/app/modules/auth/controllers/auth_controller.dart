import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Method untuk registrasi pengguna
  Future<void> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String userId = userCredential.user!.uid;

      // Menyimpan data pengguna ke Firestore
      await _firestore.collection('users').doc(userId).set({
        'email': email,
        'profileImageUrl': '',
      });

      print('User signed up: $userId');
    } catch (e) {
      print('Error signing up: $e');
      Get.snackbar('Error', 'Failed to sign up: $e');
    }
  }

  // Method untuk login pengguna
  Future<void> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Mendapatkan User ID
      String userId = userCredential.user!.uid;
      print('User signed in: $userId');

      // Anda dapat mengarahkan pengguna ke halaman profil atau lainnya
      // Get.toNamed('/profile'); // Ganti sesuai dengan rute Anda
    } catch (e) {
      print('Error signing in: $e');
      Get.snackbar('Error', 'Failed to sign in: $e');
    }
  }
}
