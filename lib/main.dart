import 'package:flutter/material.dart';
import 'package:lichen_care/pages/home_sliders.dart';
import 'package:get/get.dart';
import 'package:lichen_care/pages/login.dart';
import 'package:lichen_care/pages/registration.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'LichenCare',
      debugShowCheckedModeBanner: false,
      home: MyCarousel(),
      routes: {
      '/login': (context) => LoginPage(),
      '/registration': (context) => RegistrationPage() // your login page
    // ... other routes
  },
    );
  }
}
