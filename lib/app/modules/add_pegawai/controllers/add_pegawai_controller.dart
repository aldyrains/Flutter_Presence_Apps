import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;

class AddPegawaiController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isLoadingAddPegawai = false.obs;
  TextEditingController nipC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController passAdminC = TextEditingController();

  Future<void> addPegawai() async {
    if (nipC.text.isNotEmpty &&
        nameC.text.isNotEmpty &&
        emailC.text.isNotEmpty) {
      isLoading.value = true;

      ///Function untuk registrasi email dan password admin , dokumentasi lengkap di https://firebase.flutter.dev/docs/auth/usage/#registration
      Get.defaultDialog(
          title: "Validasi Admin",
          content: Column(
            children: [
              Text("Masukan password untuk validasi admin!"),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: passAdminC,
                autocorrect: false,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
              )
            ],
          ),
          actions: [
            OutlinedButton(
              onPressed: () {
                isLoading.value = false;
                Get.back();
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
                onPressed: () async {
                  await prosesAddPegawai();
                  isLoading.value = false;
                },
                child: Text('Add Pegawai'))
          ]);
      //
    } else {
      isLoading.value = false;
      Get.snackbar("Terjadi Kesalahan", "NIP , Nama Dan Email harus Diisi");
    }
  }

  Future<void> prosesAddPegawai() async {
    if (passAdminC.text.isNotEmpty) {
      isLoadingAddPegawai.value = true;
      try {
        String emailAdmin = auth.currentUser!.email!;
        UserCredential userCredentialAdmin = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailAdmin, password: passAdminC.text);

        UserCredential pegawaiCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailC.text, password: "password");
        if (pegawaiCredential.user != null) {
          String uid = pegawaiCredential.user!.uid;

          await firestore.collection("pegawai").doc(uid).set({
            "nip": nipC.text,
            "name": nameC.text,
            "email": emailC.text,
            "uid": uid,
            "role" :"pegawai",
            "createdAt": DateTime.now().toIso8601String()
          });

          await pegawaiCredential.user!.sendEmailVerification();

          await auth.signOut();

          UserCredential userCredentialAdmin = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: emailAdmin, password: passAdminC.text);
          Get.back(); //tutup dialog
          Get.back(); //back to home
          Get.snackbar("Berhasil", "Berhasil menambahkan pegawai");
          // current user = null
          isLoadingAddPegawai.value = false;
        }

        print(pegawaiCredential);
      } on FirebaseAuthException catch (e) {
        isLoadingAddPegawai.value = false;
        if (e.code == 'weak-password') {
          Get.snackbar('Terjadi Kesalahan', 'Password Terlalu Singkat');
        } else if (e.code == 'email-already-in-use') {
          Get.snackbar('Terjadi Kesalahan',
              'Pegawai sudah ada. Kamu tidak bisa menambahkan pegawai');
        } else if (e.code == 'wrong-password') {
          Get.snackbar(
              'Terjadi Kesalahan', 'Admin tidak dapat login. password salah');
        } else {
          Get.snackbar(
              'Terjadi Kesalahan', 'Admin tidak dapat login. password salah');
        }
      } catch (e) {
        isLoadingAddPegawai.value = false;
        Get.snackbar('Terjadi Kesalahan', 'Tidak dapat menambahkan pegawai');
      }
    } else {
      Get.snackbar(
          "Terjadi Kesalahan", "Password wajib diisi untuk keperluan validasi");
    }
  }
}
