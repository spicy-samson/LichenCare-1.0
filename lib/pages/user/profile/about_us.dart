import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AboutUs extends StatelessWidget {
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
          padding: EdgeInsets.only(top: h * 0.04, right: w * 0.45),
          child: SvgPicture.asset(
            'assets/svgs/profileSection/profileAppBars/about_us(copy).svg',
            width: w * 0.1,
            height: h * 0.8,
          ),
        ),
        elevation: 0,
        toolbarHeight: 80.0,
      ),

      // Body
      body: ListView(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(fontSize: 14, color: Colors.black),
                      children: [
                        TextSpan(
                          text:
                              "Unlocking dermatological wisdom through information, guiding everyone with clinical decisions.",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 25),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(fontSize: 14, color: Colors.black),
                      children: [
                        TextSpan(
                          text: "WHO ARE WE?",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 25),

                  // Team members
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              height: 162 * scaleFactor,
                              width: 162 * scaleFactor,
                              child: Image.asset(
                                'assets/imgs/jb_pic.png', // replace with your image path
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: RichText(
                                  textAlign: TextAlign.start,
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black),
                                    children: [
                                      TextSpan(
                                        text: "John Benidick D. Redondo\n",
                                        style: TextStyle(
                                          fontSize: 20 * scaleFactor,
                                          fontWeight: FontWeight.w900,
                                          height: 1.5,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "Project Manager\n",
                                        style: TextStyle(
                                          fontSize: 18 * scaleFactor,
                                          fontWeight: FontWeight.w700,
                                          height: 1.3,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "johnbenidickredondo@gmail.com\n",
                                        style: TextStyle(
                                          fontSize: 18 * scaleFactor,
                                          height: 1.3,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "+639150734583\n",
                                        style: TextStyle(
                                          fontSize: 18 * scaleFactor,
                                          height: 1.3,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 13),
                        Row(
                          children: [
                            SizedBox(
                              height: 160 * scaleFactor,
                              width: 160 * scaleFactor,
                              child: Image.asset(
                                'assets/imgs/third.JPG', // replace with your image path
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: RichText(
                                  textAlign: TextAlign.start,
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black),
                                    children: [
                                      TextSpan(
                                        text: "Paulino Edsel G. Samson\n",
                                        style: TextStyle(
                                          fontSize: 20 * scaleFactor,
                                          fontWeight: FontWeight.w900,
                                          height: 1.5,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "Fullstack Developer\n",
                                        style: TextStyle(
                                          fontSize: 18 * scaleFactor,
                                          fontWeight: FontWeight.w700,
                                          height: 1.3,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "iamzedthird@gmail.com\n",
                                        style: TextStyle(
                                          fontSize: 18 * scaleFactor,
                                          height: 1.3,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "+639453313393\n",
                                        style: TextStyle(
                                          fontSize: 18 * scaleFactor,
                                          height: 1.3,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 13),
                        Row(
                          children: [
                            SizedBox(
                              height: 160 * scaleFactor,
                              width: 160 * scaleFactor,
                              child: Image.asset(
                                'assets/imgs/hannah.jpg', // replace with your image path
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: RichText(
                                  textAlign: TextAlign.start,
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black),
                                    children: [
                                      TextSpan(
                                        text: "Hyasmin Hannah R. Barcelona\n",
                                        style: TextStyle(
                                          fontSize: 20 * scaleFactor,
                                          fontWeight: FontWeight.w900,
                                          height: 1.5,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "UI/UX Manager\n",
                                        style: TextStyle(
                                          fontSize: 18 * scaleFactor,
                                          fontWeight: FontWeight.w700,
                                          height: 1.3,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "hyasminbarcelona@gmail.com\n",
                                        style: TextStyle(
                                          fontSize: 18 * scaleFactor,
                                          height: 1.3,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "+639478200314\n",
                                        style: TextStyle(
                                          fontSize: 18 * scaleFactor,
                                          height: 1.3,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: RichText(
                            textAlign: TextAlign.justify,
                            text: TextSpan(
                               style: TextStyle(
                                      fontSize: 20 * scaleFactor,
                                      color: Colors.black,
                                      height: 1.3),
                              children: const [
                                WidgetSpan(child: SizedBox(width: 20.0)),
                                TextSpan(
                                  text:
                                      "The LichenCare team are Fourth Year Information Technology students that aim to utilize Machine Learning as an indispensable tool in the field of health informatics. They believe that AI must only be used as an aid and should not be intended to replace humans in their respective field.",
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                        children: [
                          const WidgetSpan(child: SizedBox(width: 20.0)),
                          TextSpan(
                            text:
                                "The LichenCare mobile application is a tool that is meant for everyone especially and gives significant assistance for patients specifically those with Lichen Planus as it allows them to make informed decisions. It is a platform that offers healthcare support and brings everyone together to share their knowledge and experiences with others to make the disease known for everybody.",
                            style: TextStyle(
                                fontSize: 20 * scaleFactor,
                                color: Colors.black,
                                height: 1.3),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                        children: [
                          const WidgetSpan(child: SizedBox(width: 20.0)),
                          TextSpan(
                            text:
                                "This healthcare support platform aims to greatly improve the identification and dissemination of medical information with a system application that offers various healthcare features that assist patients in understanding Lichen Planus. Along its way, it is an initiative to inspire developers to explore more with the ever-growing field of Machine Learning and Deep Learning to create an endless variety of concepts.",
                            style: TextStyle(
                                fontSize: 20 * scaleFactor,
                                color: Colors.black,
                                height: 1.3),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text:
                                "For inquiries, concerns and questions you can contact us at bsitcapstoneproject143@gmail.com.",
                            style: TextStyle(
                                fontSize: 18 * scaleFactor,
                                color: Colors.black,
                                fontStyle: FontStyle.italic),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "LichenCare © 2023. All rights reserved.",
                            style: TextStyle(
                              fontSize: 18 * scaleFactor,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                ],
              ),
            ),
          ),
        ],
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
