import 'package:get/get.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lichen_care/pages/guest/login.dart';
import 'package:lichen_care/pages/user/profile.dart';
import 'package:lichen_care/pages/user/home_page.dart';
import 'package:lichen_care/pages/user/lichenHub.dart';
import 'package:lichen_care/pages/user/lichenpedia.dart';
import 'package:lichen_care/pages/user/lichenCheck.dart';
import 'package:lichen_care/pages/guest/home_sliders.dart';
import 'package:lichen_care/pages/guest/registration.dart';
import 'package:lichen_care/pages/user/lichenpedia/lichenpedia_vault.dart';
import 'package:lichen_care/pages/user/lichenpedia/lichenpedia_archives.dart';
import 'package:lichen_care/pages/user/lichenpedia/lichenpedia_variants.dart';
import 'package:lichen_care/pages/user/lichenpedia/lichenpedia_reference.dart';

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
        textTheme: Theme.of(context).textTheme.apply(fontFamily: 'ABeeZee',),
      ),
      home: MyCarousel(),
      routes: {
        '/login': (context) => LoginPage(),
        '/registration': (context) => RegistrationPage(),
        '/home': (context) => HomePage(),
        '/lichenpedia': (context) => LichenPedia(),
        '/lichenpedia_archive': (context) => LichenPediaArchive(),
        '/lichenpedia_variant': (context) => LichenPediaVariant(),
        '/lichenpedia_vault': (context) => LichenPediaVault(),
        '/lichenpedia_reference': (context) => LichenPediaReferences(),
        '/lichenHub': (context) => LichenHub(),
        '/lichenCheck': (context) => LichenCheck(),
        '/profile': (context) => Profile(),
      },
    );
  }
}


class NoTransitionsBuilder extends PageTransitionsBuilder {
  const NoTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T>? route,
    BuildContext? context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget? child,
  ) {
    // only return the child without warping it with animations
    return child!;
  }
}