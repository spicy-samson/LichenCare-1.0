import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LichenCheckPage extends StatelessWidget {
  int _currentIndex =
      2; // Initialize _currentIndex with the desired initial tab index

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFFFFF4E9),
      appBar: AppBar(
        backgroundColor: Color(0xFFFFF4E9),
        title: Padding(
          padding: EdgeInsets.only(top: h * 0.05, right: w * 0.5),
          child: SvgPicture.asset(
            'assets/svgs/#1 - lichencheck.svg',
            width: w * 0.1,
            height: h * 0.045,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 80.0,
      ),

      // Body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text('Lichen check page'),
              Text('Insert disclaimer here'),
            ],
          ),
        ),
      ),

      // Floating action button
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle, // Make the container a circle
          border: Border.all(
            color: const Color(0xFFFF7F50), // Set the border color
            width: 3.0, // Set the border width
          ),
        ),
        child: FloatingActionButton(
          onPressed: () {
            // Implement your add new post logic here
          },
          child: IconButton(
            onPressed: () {
              // Add functionality when the icon button is pressed
            },
            icon: SvgPicture.asset(
              'assets/svgs/bottomNavBar/LichenCheck_icon.svg',
              width: 32, // Set the width to adjust the size of the icon
              height: 32, // Set the height to adjust the size of the icon
            ),
          ),
          backgroundColor: Color(0xFFFFF4E9),
        ),
      ),

      // Bottom navigation bar
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Ensures equal spacing
        backgroundColor:
            Color(0xFF66D7D1), // Set the background color to #66D7D1
        selectedItemColor: Colors.white, // Selected item color
        unselectedItemColor:
            const Color.fromARGB(94, 0, 0, 0), // Unselected item color
        selectedFontSize: 12, // Adjust the font size for selected items
        unselectedFontSize: 12, // Adjust the font size for unselected items
        currentIndex: _currentIndex, // Set the current index as needed
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svgs/bottomNavBar/Lichenpedia_icon.svg',
              width: 32, // Set the width to adjust the size of the icon
              height: 32, // Set the height to adjust the size of the icon
            ),
            label: 'Lichenpedia',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svgs/bottomNavBar/LichenHub_icon.svg',
              width: 32, // Set the width to adjust the size of the icon
              height: 32, // Set the height to adjust the size of the icon
            ),
            label: 'LichenHub',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.add, size: 30), label: 'LichenCheck'),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svgs/bottomNavBar/Notification_icon.svg',
              width: 32, // Set the width to adjust the size of the icon
              height: 32, // Set the height to adjust the size of the icon
            ),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svgs/bottomNavBar/UserProfile_icon.svg',
              width: 32, // Set the width to adjust the size of the icon
              height: 32, // Set the height to adjust the size of the icon
            ),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          // Handle navigation to different pages based on the index
          // Set the _currentIndex state or navigate as needed
        },
      ),
    );
  }
}
