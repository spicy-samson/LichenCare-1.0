import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int _currentIndex = 4;
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFFFFF4E9),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFFFFF4E9),
        title: Padding(
          padding: EdgeInsets.only(top: h * 0.05, right: w * 0.5),
          child: SvgPicture.asset(
            'assets/svgs/profileSection/profile(copy).svg',
            width: w * 0.1,
            height: h * 0.8,
          ),
        ),
        elevation: 0,
        toolbarHeight: 80.0,
      ),

      // Body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(height: h * 0.05),
              buildCustomDivider(2, Colors.grey),
              Padding(
                padding: const EdgeInsets.all(12),
                child: buildRow(
                    'Account', 'assets/svgs/profileSection/account_icon.svg',
                    () {
                  // Function to execute when the 'Account' row is clicked
                }),
              ),
              buildCustomDivider(2, Colors.grey),
              Padding(
                padding: const EdgeInsets.all(12),
                child: buildRow('Scan History',
                    'assets/svgs/profileSection/scan history_icon.svg', () {
                  // Function to execute when the 'Scan History' row is clicked
                }),
              ),
              buildCustomDivider(2, Colors.grey),
              Padding(
                padding: const EdgeInsets.all(12),
                child: buildRow(
                    'Feedback', 'assets/svgs/profileSection/feedback_icon.svg',
                    () {
                  // Function to execute when the 'Feedback' row is clicked
                }),
              ),
              buildCustomDivider(2, Colors.grey),
              Padding(
                padding: const EdgeInsets.all(12),
                child: buildRow(
                    'About us', 'assets/svgs/profileSection/about us_icon.svg',
                    () {
                  // Function to execute when the 'About us' row is clicked
                }),
              ),
              buildCustomDivider(2, Colors.grey),
              Padding(
                padding: const EdgeInsets.all(12),
                child: buildRow('Terms and conditions',
                    'assets/svgs/profileSection/terms and conditions_icon.svg',
                    () {
                  // Function to execute when the 'Terms and conditions' row is clicked
                }),
              ),
              buildCustomDivider(2, Colors.grey),
              Padding(
                padding: const EdgeInsets.all(12),
                child: buildRow('Privacy policy',
                    'assets/svgs/profileSection/privacy policy_icon.svg', () {
                  // Function to execute when the 'Privacy policy' row is clicked
                }),
              ),
              buildCustomDivider(2, Colors.grey),
              Padding(
                padding: const EdgeInsets.all(12),
                child: buildRow(
                    'Logout', 'assets/svgs/profileSection/logout_icon.svg', () {
                  _signOut();
                }),
              ),
              buildCustomDivider(2, Colors.grey),
            ],
          ),
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
          icon: Icon(
            Icons.home,
            size: 30,
            color: Color(0xFFFF7F50),
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
        // Handle navigation to different pages based on the index
        switch (index) {
          case 0:
            Navigator.of(context)
                .pushNamed('/home'); // Navigate to the 'home' route
            break;
          case 1:
            Navigator.of(context).pushNamed(
                '/lichenpedia'); // Navigate to the 'lichenpedia' route
            break;
          case 2:
            Navigator.of(context).pushNamed(
                '/lichenCheck'); // Navigate to the 'lichencheck' route
            break;
          case 3:
            Navigator.of(context)
                .pushNamed('/lichenHub'); // Navigate to the 'lichenhub' route
            break;
          case 4:
            Navigator.of(context)
                .pushNamed('/profile'); // Navigate to the 'profile' route
            break;
        }
      },
    );
  }

  Widget buildRow(String title, String svgPath, Function() onTap) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: onTap, // Assign the function to execute when the row is clicked
      child: Row(
        children: [
          // Left Part (SVG)
          SvgPicture.asset(
            svgPath,
            width: w * 0.05,
            height: h * 0.048,
          ),
          // Middle Part (Title)
          SizedBox(width: 20),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          // Right Part (Arrow Button)
          Spacer(), // Push the arrow button to the right
          Icon(Icons.arrow_forward_ios, color: Color(0xFFFF7F50)),
        ],
      ),
    );
  }

  Divider buildCustomDivider(double height, Color color) {
    return Divider(
      height: height,
      color: color,
    );
  }

  // Function to log out the user
  Future<void> _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
    } catch (e) {
      print("Error while signing out: $e");
    }
  }
}
