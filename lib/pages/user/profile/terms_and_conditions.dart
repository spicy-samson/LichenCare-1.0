import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TermsAndConditions extends StatelessWidget {
  int _currentIndex = 4;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    double scaleFactor = h / 1080;

    return Scaffold(
      backgroundColor: Color(0xFFFFF4E9),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFFFFF4E9),
        title: Padding(
          padding: EdgeInsets.only(top: h * 0.04, right: w * 0.15),
          child: SvgPicture.asset(
            'assets/svgs/profileSection/profileAppBars/terms_and_conditions(copy).svg',
            width: w * 0.1,
            height: h * 0.8,
          ),
        ),
        elevation: 0,
        toolbarHeight: 80.0,
      ),

      // Body
      // Body
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'LichenCare Terms of Use',
              style: TextStyle(
                fontSize: 22 * scaleFactor,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Effective as of: November 20, 2023',
              style: TextStyle(
                fontSize: 20 * scaleFactor,
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Introduction\n'
              'Welcome to LichenCare! Please read these Terms of Use (“Terms”) carefully as they govern your use (which includes access to) LichenCare’s personalized services for the classification of the Cutaneous Lichen Planus skin disease, including the in-app features (LichenCheck, Lichenpedia, LichenHub) that incorporate or link to these Terms (collectively, the “LichenCare Service”). LichenCare mobile application and LichenCare external services or APIs use experimental Artificial Intelligence (“AI”) technology to offer general information for general educational purposes (“Services”), subject to your reading, understanding, and agreement with all of these terms and conditions (“Terms”).\n'
              '\n'
              'LichenCare may modify these Terms at any time, and such modifications shall be effective immediately upon posting the updated Terms on our app. External entities that use our APIs are wholly responsible for ensuring that our updated Terms are presented and acknowledged by users.\n'
              '\n'
              'If you A) do not agree with all the Terms bar none, or if B) you are under the age of fourteen (14), or if C) you have or belong to any of the contraindications as stated below, do not use LichenCare and our Services. Please review all of the Terms carefully before proceeding.',
            ),
            SizedBox(height: 20),
            // Continue adding the rest of your terms and conditions content here
          ],
        ),
      ),

      // Floating action button
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _lichenCheckBtn(context),

      // Bottom navigation bar
      bottomNavigationBar: _bottomNavBar(context),
    );
  }

  Container _lichenCheckBtn(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle, // Make the container a circle
        border: Border.all(
          color: const Color(0xFFFF7F50), // Set the border color
          width: 3.0, // Set the border width
        ),
      ),
      child: FloatingActionButton(
        child: IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/lichenCheck');
          },
          icon: SvgPicture.asset(
            'assets/svgs/bottomNavBar/LichenCheck_icon.svg',
            width: 32, // Set the width to adjust the size of the icon
            height: 32, // Set the height to adjust the size of the icon
          ),
        ),
        backgroundColor: Color(0xFFFFF4E9),
        onPressed: () {},
      ),
    );
  }

  BottomNavigationBar _bottomNavBar(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Color(0xFF66D7D1),
      selectedItemColor: Colors.white,
      unselectedItemColor: Color.fromARGB(94, 0, 0, 0),
      selectedFontSize: 12,
      unselectedFontSize: 12,
      currentIndex: _currentIndex,
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/svgs/bottomNavBar/Home_icon.svg',
            width: 32,
            height: 32,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/svgs/bottomNavBar/Lichenpedia_icon.svg',
            width: 32,
            height: 32,
          ),
          label: 'Lichenpedia',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add, size: 32),
          label: 'LichenCheck',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/svgs/bottomNavBar/LichenHub_icon.svg',
            width: 32,
            height: 32,
          ),
          label: 'LichenHub',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/svgs/bottomNavBar/UserProfile_icon.svg',
            width: 32,
            height: 32,
          ),
          label: 'Profile',
        ),
      ],
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushReplacementNamed(context, '/home');
            break;
          case 1:
            Navigator.pushReplacementNamed(context, '/lichenpedia');
            break;
          case 2:
            Navigator.pushReplacementNamed(context, '/lichenCheck');
            break;
          case 3:
            Navigator.pushReplacementNamed(context, '/lichenHub');
            break;
          case 4:
            Navigator.pushReplacementNamed(context, '/profile');
            break;
        }
      },
    );
  }
}

Color primaryforegroundColor = const Color(0xFFFF7F50);
