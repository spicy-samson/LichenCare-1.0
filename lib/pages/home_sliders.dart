import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/svg.dart';

class MyCarousel extends StatefulWidget {
  @override
  _MyCarouselState createState() => _MyCarouselState();
}

class _MyCarouselState extends State<MyCarousel> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    List<Widget> _pages = [
      Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Welcome to',
              style: TextStyle(fontSize: 26, color: Colors.black),
            ),
            const Text(
              'LichenCare',
              style: TextStyle(fontSize: 48, color: Color(0xFF5CC9CD)),
            ),
            const SizedBox(
              height: 30,
            ),
            Image.asset(
              'assets/imgs/GaBu_logo1.png', // Replace with your image asset path
              width: w * 0.9,
              height: h * 0.3,
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.only(
                left: 35,
                right: 35,
              ),
              child: const Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontFamily: 'Questrial',
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: h * 0.15,
            ),
          ],
        ),
      ),
      Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/svgs/HOME PAGE IMAGE.svg',
                width: w * 0.3,
                height: h * 0.3,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.only(
                  left: 45,
                  right: 45,
                ),
                child: const Text(
                  'Unlocking dermatological wisdom through information, guiding everyone with clinical decisions.',
                  style: TextStyle(fontSize: 23, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/registration');
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color(0xFF5CC9CD)), // Background color
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: const BorderSide(
                          color: Colors.black,
                          width:
                              1.0), // Border color and width // Border radius
                    ),
                  ),
                  foregroundColor: MaterialStateProperty.all<Color>(
                      Colors.black), // Text color
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10), // Adjust padding as needed
                  ),
                ),
                child: const Text(
                  'Get Started',
                  style: TextStyle(
                    fontSize: 22, // Adjust the font size as needed
                  ),
                ),
                
              ),
              SizedBox(
              height: h * 0.13,
            ),
            ],
          ),
        ),
      ),
      Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/svgs/derma2.svg',
                width: w * 0.3,
                height: h * 0.3,
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.only(
                  left: 25,
                  right: 25,
                ),
                child: const Text(
                  'Catalyzing Quality Clinical Outcomes Through Innovative Healthcare Technology.',
                  style: TextStyle(fontSize: 23, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/registration');
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color(0xFF5CC9CD)), // Background color
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: const BorderSide(
                          color: Colors.black,
                          width:
                              1.0), // Border color and width // Border radius
                    ),
                  ),
                  foregroundColor: MaterialStateProperty.all<Color>(
                      Colors.black), // Text color
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10), // Adjust padding as needed
                  ),
                ),
                child: const Text(
                  'Know More!',
                  style: TextStyle(
                    fontSize: 22, // Adjust the font size as needed
                  ),
                ),
              ),
              SizedBox(
              height: h * 0.11,
            ),
            ],
          ),
        ),
      ),
    ];

    List<Widget> _buildPageIndicator() {
      return _pages.asMap().entries.map((entry) {
        return Container(
          width: 25, // Adjust the width as needed for the border
          height: 25, // Adjust the height as needed for the border
          margin: const EdgeInsets.symmetric(horizontal: 2),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      _currentIndex == entry.key ? Colors.black : Colors.white,
                ),
              ),
              Container(
                width: 18, // Adjust the width as needed for the border
                height: 18, // Adjust the height as needed for the border
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.grey, // Border color
                    width: 1, // Border width
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList();
    }

    return Scaffold(
      body: Stack(
        children: [
          CarouselSlider(
            items: _pages,
            options: CarouselOptions(
              height: h,
              viewportFraction: 1.0,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: (3.5 / 4) * h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildPageIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}
