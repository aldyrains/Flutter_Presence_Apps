import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_presence_apps/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: Routes.LOGIN,
      getPages: AppPages.Routes,
    )
  );
}

