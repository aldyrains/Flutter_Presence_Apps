import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_presence_apps/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_presence_apps/app/routes/app_pages.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('homeView'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(Routes.PROFILE),
            icon: Icon(Icons.person),
          ),
        ],
      ),
      body: const Center(
          child: Text(
        'HomeView is Working',
        style: TextStyle(fontSize: 20),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (controller.isLoading.isFalse) {
            controller.isLoading.value = true;
            await FirebaseAuth.instance.signOut();
            controller.isLoading.value = false;
            Get.offAllNamed(Routes.LOGIN);
          }
        },
        child: controller.isLoading.isFalse ?Icon(Icons.logout_outlined) :CircularProgressIndicator(),
      ),
    );
  }
}
