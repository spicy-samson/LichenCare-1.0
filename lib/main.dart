import 'package:flutter/material.dart';
import 'package:lichen_care/pages/guest/home_sliders.dart';
import 'package:get/get.dart';
import 'package:lichen_care/pages/guest/login.dart';
import 'package:lichen_care/pages/guest/registration.dart';
import 'package:lichen_care/pages/user/home_page.dart';
import 'package:lichen_care/pages/user/lichenpedia.dart';
import 'package:lichen_care/pages/user/lichenHub.dart';
import 'package:lichen_care/pages/user/lichenCheck.dart';



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
      theme: ThemeData(
        fontFamily: 'ABeeZee',
        textTheme: Theme.of(context).textTheme.apply(fontFamily: 'ABeeZee'),
      ),
      home: HomePage(username: 'Tres',),
      routes: {
        '/login': (context) => LoginPage(),
        '/registration': (context) => RegistrationPage(),
        '/home': (context) => HomePage(username: 'Tres',),
        '/lichenpedia' : (context) => LichenPedia(),
        '/lichenHub' : (context) => LichenHub(), 
        '/lichenCheck' : (context) => LichenCheck(),
      },
    );
  }
}
