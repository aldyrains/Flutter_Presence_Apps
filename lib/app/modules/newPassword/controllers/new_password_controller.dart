import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_presence_apps/app/routes/app_pages.dart';
import 'package:get/get.dart';

class NewPasswordController extends GetxController {
  TextEditingController newPassC = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  void newPassword() async {
    if (newPassC.text.isNotEmpty) {
      if (newPassC.text != 'password') {
        try {
          String email = auth.currentUser!.email!;
          await auth.currentUser!.updatePassword(newPassC.text);

          await auth.signOut();

          await auth.signInWithEmailAndPassword(
              email: email, password: newPassC.text);

          Get.offAllNamed(Routes.HOME);
          
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            Get.snackbar(
                "Terjadi Kesalahan", "Password lemah , minimal 6 karakter.");
          }
        } catch (e) {
          Get.snackbar("Terjadi Kesalahan",
              "Tidak dapat membuat password baru. hubungi admin / customer service.");
        }
        // Get.offAllNamed(Routes.LOGIN); *Jika ingin langsung di kembalikan ke login
      } else {
        Get.snackbar("Terjadi Kesalahan", "Jangan Gunakan Password Default");
      }
    } else {
      Get.snackbar("Terjadi Kesalahan", "Password Baru Wajib Diisi");
    }
  }
}
