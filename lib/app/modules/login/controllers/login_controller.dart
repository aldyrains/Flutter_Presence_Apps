import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  void login() async {
    if (emailC.text.isNotEmpty && passC.text.isNotEmpty) {
      try {
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
            email: emailC.text, password: passC.text);
        print(userCredential);

        if (userCredential.user != null) {
          if (userCredential.user!.emailVerified == true) {
            Get.offAllNamed(Routes.HOME);
          } else {
            Get.defaultDialog(
              title: "Belum Verifikasi",
              middleText: "Kamu belum verifiasi akun ini. Lakukan verifikasi diemail kamu."
            );
          }
        }

      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Get.snackbar("Terjadi Kesalahan", "Email Tidak Terdaftar");
        } else if (e.code == 'wrong-password') {
          Get.snackbar("Terjadi Kesalahan", "Password Salah");
        }
      } catch (e) {
        Get.snackbar("Terjadi Kesalahan", "Email dan Password wajib diisi");
      }
    } else {
      Get.snackbar("Terjadi Kesalahan", "Tidak Dapat Login");
    }
  }
}
