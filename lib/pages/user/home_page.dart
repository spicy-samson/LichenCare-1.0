import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  final int _currentIndex = 0;
  bool navigatorHidden = false;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF4E9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF4E9),
        title: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: SvgPicture.asset(
            'assets/svgs/LichenCare main branding.svg',
            width: w * 0.1,
            height: h * 0.05,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        toolbarHeight: 80.0,
      ),

      // Body
      body: Listener(
        onPointerMove: (pointer){
                        // print(pointer.delta);
            if(pointer.delta.dy == 0){
              return;
            }
            if(pointer.delta.dy < 0){
              // scrolls down
              setState(() {
                navigatorHidden = true;
              });
            }else{
              // scrolls up
              setState(() {
                navigatorHidden = false;
              });
            }
          },
        child: SingleChildScrollView(
          child: Column(
            children: [
              // First set of content
              Container(
                padding: EdgeInsets.only(
                    left: w * 0.1, right: w * 0.1, bottom: (w * 0.1)),
                child: Column(
                  children: [
                    SvgPicture.asset(
                      'assets/svgs/LichenCheck_image.svg',
                      width: w * 0.3,
                      height: h * 0.27,
                    ), // Replace with your image path
                    SizedBox(height: h * 0.025),
                    const Text(
                      'Dermatology powered by Machine Learning',
                      style:
                          TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: h * 0.02),
                    const Text(
                      "Machine Learning's trend is rising, and LichenCare saw this technology as the cornerstone in achieving improved healthcare quality outcomes. Have yourself a Lichen Planus detector that can give an additional layer of screening.",
                      style: TextStyle(fontSize: 17.0),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: h * 0.03),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/lichenCheck');
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFFFF7F50)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: const BorderSide(
                                color: Colors.white,
                                width: 2.0), // Add the white border here
                          ),
                        ),
                      ),
                      child: const Text(
                        'Scan Now',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      
              // Second set of content
              Container(
                padding: EdgeInsets.only(
                    left: w * 0.1, right: w * 0.1, bottom: (w * 0.1)),
                child: Column(
                  children: [
                    SvgPicture.asset(
                      'assets/svgs/Lichenpedia_image.svg',
                      width: w * 0.3,
                      height: h * 0.33,
                    ), // Replace with your image path
                    SizedBox(height: h * 0.017),
                    const Text(
                      'Learn Lichen Planus in just a few taps',
                      style:
                          TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: h * 0.020),
                    const Text(
                      "LichenCare extends its function as a support system by providing a library of educational resources on Lichen Planus skin condition including its multiple variants. This allows patients to make an informed decision and explore the skin condition with ease.",
                      style: TextStyle(fontSize: 17.0),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: h * 0.03),
                    Container(
                      // Adjust the padding
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/lichenpedia');
                        },
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xFFFF7F50)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: const BorderSide(
                                  color: Colors.white,
                                  width: 2.0), // Add the white border here
                            ),
                          ),
                        ),
                        child: const Text(
                          'Browse Now',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      
              //Third set of content
              Container(
                padding: EdgeInsets.only(
                    left: w * 0.1, right: w * 0.1, bottom: (w * 0.1)),
                child: Column(
                  children: [
                    SvgPicture.asset(
                      'assets/svgs/Lichenhub_image.svg',
                      width: w * 0.3,
                      height: h * 0.33,
                    ), // Replace with your image path
                    SizedBox(height: h * 0.010),
                    const Text(
                      'Connecting Lichen Planus Warriors',
                      style:
                          TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: h * 0.025),
                    const Text(
                      "LichenCare aspires to unite Lichen Planus patients with a community that shares a bond of support and care. A feature that illuminates the rare skin condition and empowers patients to openly exchange their experiences in battling the condition.",
                      style: TextStyle(fontSize: 17.0),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: h * 0.03),
                    Container(
                      // Adjust the padding
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/lichenHub');
                        },
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xFFFF7F50)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: const BorderSide(
                                  color: Colors.white,
                                  width: 2.0), // Add the white border here
                            ),
                          ),
                        ),
                        child: const Text(
                          'Join Now',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
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
                padding: EdgeInsets.only(
                    left: w * 0.1, right: w * 0.1, bottom: (w * 0.1)),
                child: Column(
                  children: [
                    SvgPicture.asset(
                      'assets/svgs/AboutUs_image.svg',
                      width: w * 0.3,
                      height: h * 0.33,
                    ),
                    SizedBox(height: h * 0.025),
                    const Text(
                      'The Future of Healthcare has arrived!',
                      style:
                          TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: h * 0.025),
                    const Text(
                      "Having an instant second opinion through information leads to improved clinical outcomes. The utilization of modern technology allows LichenCare to provide healthcare support for patients with Lichen Planus.",
                      style: TextStyle(fontSize: 17.0),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: h * 0.020),
                    Container(
                      // Adjust the padding
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/profile/about_us');
                        },
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xFFFF7F50)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: const BorderSide(
                                  color: Colors.white,
                                  width: 2.0), // Add the white border here
                            ),
                          ),
                        ),
                        child: const Text(
                          'Learn More',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // Floating action button
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: (navigatorHidden)? null : _lichenCheckBtn(context),

      // Bottom navigation bar
      bottomNavigationBar: (navigatorHidden)? null : _bottomNavBar(context),
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
        backgroundColor: const Color(0xFFFFF4E9),
        onPressed: () {},
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
      ),
    );
  }

  BottomNavigationBar _bottomNavBar(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: const Color(0xFF66D7D1),
      selectedItemColor: Colors.white,
      unselectedItemColor: const Color.fromARGB(94, 0, 0, 0),
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
        const BottomNavigationBarItem(
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
            // Navigator.pushReplacementNamed(context, '/home');
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
