import 'package:flutter/material.dart';
import 'package:lichen_care/pages/guest/home_sliders.dart';
import 'package:get/get.dart';
import 'package:lichen_care/pages/guest/login.dart';
import 'package:lichen_care/pages/guest/registration.dart';
import 'package:lichen_care/pages/user/home_page.dart';
import 'package:lichen_care/pages/user/lichenpedia.dart';
import 'package:lichen_care/pages/user/lichenHub.dart';
import 'package:lichen_care/pages/user/lichenCheck.dart';
import 'package:lichen_care/pages/user/profile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  //Root of Application
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'LichenCare',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'ABeeZee',
        textTheme: Theme.of(context).textTheme.apply(fontFamily: 'ABeeZee'),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: const Color(0xFFFF7F50), // Orange color
        ),
      ),
      home: MyCarousel(),
      routes: {
        '/login': (context) => LoginPage(),
        '/registration': (context) => RegistrationPage(),
        '/home': (context) => HomePage(),
        '/lichenpedia': (context) => LichenPedia(),
        '/lichenHub': (context) => LichenHub(),
        '/lichenCheck': (context) => LichenCheck(),
        '/profile': (context) => Profile(),
      },
    );
  }
}
