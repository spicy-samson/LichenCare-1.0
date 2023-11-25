import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int _currentIndex = 4;
  User? user;
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
          padding: EdgeInsets.only(top: h * 0.02, right: w * 0.45),
          child: SvgPicture.asset(
            'assets/svgs/profileSection/profile(copy).svg',
            width: w * 0.1,
            height: h * 0.8,
          ),
        ),
        elevation: 0,
        toolbarHeight: 60.0,
      ),

      // Body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              buildCustomDivider(2, Colors.grey),
              Padding(
                padding: const EdgeInsets.all(12),
                child: buildRow(
                    'Account', 'assets/svgs/profileSection/account_icon.svg',
                    () {
                  Navigator.of(context).pushNamed('/profile/account');
                }),
              ),
              buildCustomDivider(2, Colors.grey),
              Padding(
                padding: const EdgeInsets.all(12),
                child: buildRow('Scan History',
                    'assets/svgs/profileSection/scan history_icon.svg', () {
                  Navigator.of(context).pushNamed('/profile/scan_history');
                }),
              ),
              buildCustomDivider(2, Colors.grey),
              Padding(
                padding: const EdgeInsets.all(12),
                child: buildRow(
                    'Feedback', 'assets/svgs/profileSection/feedback_icon.svg',
                    () {
                  Navigator.of(context).pushNamed('/profile/user_feedback');
                }),
              ),
              buildCustomDivider(2, Colors.grey),
              Padding(
                padding: const EdgeInsets.all(12),
                child: buildRow(
                    'About us', 'assets/svgs/profileSection/about us_icon.svg',
                    () {
                  Navigator.of(context).pushNamed('/profile/about_us');
                }),
              ),
              buildCustomDivider(2, Colors.grey),
              Padding(
                padding: const EdgeInsets.all(12),
                child: buildRow('Terms and Conditions',
                    'assets/svgs/profileSection/terms and conditions_icon.svg',
                    () {
                  Navigator.of(context)
                      .pushNamed('/profile/terms_and_conditions');
                }),
              ),
              buildCustomDivider(2, Colors.grey),
              Padding(
                padding: const EdgeInsets.all(12),
                child: buildRow('Privacy Policy',
                    'assets/svgs/profileSection/privacy policy_icon.svg', () {
                  Navigator.of(context).pushNamed('/profile/privacy_policy');
                }),
              ),
              buildCustomDivider(2, Colors.grey),
              Padding(
                padding: const EdgeInsets.all(12),
                child: buildRow(
                  'Logout',
                  'assets/svgs/profileSection/logout_icon.svg',
                  () {
                    _showLogoutConfirmationDialog();
                  },
                ),
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

      // Set the local user variable to null after signing out
      setState(() {
        user = null;
      });

      Navigator.of(context)
          .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
    } catch (e) {
      debugPrint("Error while signing out: $e");
    }
  }

  void _showLogoutConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 16),
                Text(
                  "Are you sure you want to log out?",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          color: Colors.black, // Set the text color to orange
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                        _signOut(); // Call your logout function
                      },
                      child: Text(
                        "Logout",
                        style: TextStyle(
                          color: const Color(
                              0xFFFF7F50), // Set the text color to orange
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
