import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:patrimonie/firebase_options.dart';
import 'package:patrimonie/page/anasayfa.dart';
import 'package:patrimonie/page/harita.dart';
import 'package:patrimonie/page/navbar/nav_controller.dart';
import 'package:patrimonie/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: const MyBottomNavBar(),
    );
  }
}
