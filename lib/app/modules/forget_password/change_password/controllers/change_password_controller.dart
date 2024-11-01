import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewPasswordController {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  Future<void> updatePassword(BuildContext context, String email) async {
    String newPassword = newPasswordController.text;
    String confirmPassword = confirmPasswordController.text;

    if (newPassword == confirmPassword && newPassword.length >= 5) {
      try {
        User user = FirebaseAuth.instance.currentUser!;
        await user.updatePassword(newPassword);

        // Navigasi ke halaman menu berikutnya setelah berhasil mengupdate password
        Navigator.pushReplacementNamed(context, '/password-changed');
      } catch (e) {
        print(e);
        showTopSnackBar(context, 'Failed to update password');
      }
    } else {
      showTopSnackBar(context, 'Passwords do not match or are too short');
    }
  }

  void showTopSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: MediaQuery.of(context).size.height - 100),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
