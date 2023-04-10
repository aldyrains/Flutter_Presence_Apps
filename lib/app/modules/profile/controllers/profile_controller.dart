import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_presence_apps/app/routes/app_pages.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
 FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxBool isLoading = false.obs;

  Stream <DocumentSnapshot<Map<String , dynamic>>> streamUser() async* {
    String uid = auth.currentUser!.uid;

    yield* firestore.collection("pegawai").doc(uid).snapshots();
  }
  
  void logout() async {
     await auth.signOut();
            Get.offAllNamed(Routes.LOGIN);
  }
}
