import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  final String username;
  int _currentIndex = 2; // Initialize _currentIndex with the desired initial tab index

  HomePage({required this.username});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFFFFF4E9),
      appBar: AppBar(
        backgroundColor: Color(0xFFFFF4E9),
        title: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: SvgPicture.asset(
            'assets/svgs/LichenCare main branding.svg',
            width: w * 0.1,
            height: h * 0.06,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 80.0,
      ),

      // Body
      body: SingleChildScrollView(
        child: Column(
          children: [
            // First set of content
            Container(
              padding: EdgeInsets.all(w * 0.1),
              child: Column(
                children: [
                  SizedBox(height: h * 0.03),
                  Image.asset(
                      'assets/imgs/derma_1.jpg'), // Replace with your image path
                  SizedBox(height: h * 0.025),
                  Text(
                    'Dermatology powered by Machine Learning',
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: h * 0.02),
                  Text(
                    "Machine Learning's trend is rising, and LichenCare saw this technology as the cornerstone in achieving improved healthcare quality outcomes. Have yourself a Lichen Planus detector that can give an additional layer of screening.",
                    style: TextStyle(fontSize: 18.0),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: h * 0.03),
                  Container(
                    // Adjust the padding
                    child: ElevatedButton(
                      onPressed: () {
                        // Implement your Scan Now logic here
                      },
                      child: Text(
                        'Scan Now',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFFFF7F50)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(
                                color: Colors.white,
                                width: 2.0), // Add the white border here
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Second set of content
            Container(
              padding: EdgeInsets.all(w * 0.1),
              child: Column(
                children: [
                  Image.asset(
                      'assets/imgs/derma_1.jpg'), // Replace with your image path
                  SizedBox(height: h * 0.025),
                  Text(
                    'Learn Lichen Planus in just a few taps',
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: h * 0.020),
                  Text(
                    "LichenCare extends its function as a support system by providing a library of educational resources on Lichen Planus skin condition including its multiple variants. This allows patients to make an informed decision and explore the skin condition with ease.",
                    style: TextStyle(fontSize: 18.0),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.0),
                  Container(
                    // Adjust the padding
                    child: ElevatedButton(
                      onPressed: () {
                        // Implement your registration logic here
                      },
                      child: Text(
                        'Browse Now',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFFFF7F50)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(
                                color: Colors.white,
                                width: 2.0), // Add the white border here
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //Third set of content
            Container(
              padding: EdgeInsets.all(w * 0.1),
              child: Column(
                children: [
                  Image.asset(
                      'assets/imgs/derma_1.jpg'), // Replace with your image path
                  SizedBox(height: 16.0),
                  Text(
                    'Connecting Lichen Planus Warriors',
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: h * 0.025),
                  Text(
                    "LichenCare aspires to unite Lichen Planus patients with a community that shares a bond of support and care. A feature that illuminates the rare skin condition and empowers patients to openly exchange their experiences in battling the condition.",
                    style: TextStyle(fontSize: 18.0),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: h * 0.020),
                  Container(
                    // Adjust the padding
                    child: ElevatedButton(
                      onPressed: () {
                        // Implement your registration logic here
                      },
                      child: Text(
                        'Join Now',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFFFF7F50)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(
                                color: Colors.white,
                                width: 2.0), // Add the white border here
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: h * 0.03,
                  )
                ],
              ),
            ),

            //4th set of content
            Container(
              padding: EdgeInsets.all(w * 0.1),
              child: Column(
                children: [
                  SvgPicture.asset(
                    'assets/svgs/ABOUT_IMAGE.svg',
                    width: w * 0.3,
                    height: h * 0.33,
                  ),
                  SizedBox(height: h * 0.025),
                  Text(
                    'The Future of Healthcare has arrived!',
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: h * 0.025),
                  Text(
                    "Having an instant second opinion through information leads to improved clinical outcomes. The utilization of modern technology allows LichenCare to provide healthcare support for patients with Lichen Planus.",
                    style: TextStyle(fontSize: 18.0),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: h * 0.020),
                  Container(
                    // Adjust the padding
                    child: ElevatedButton(
                      onPressed: () {
                        // Implement your registration logic here
                      },
                      child: Text(
                        'Learn More',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFFFF7F50)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(
                                color: Colors.white,
                                width: 2.0), // Add the white border here
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: h * 0.03,
                  )
                ],
              ),
            ),
          ],
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
