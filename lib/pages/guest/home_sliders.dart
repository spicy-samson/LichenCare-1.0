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
        color: Color(0xFFFFF4E9),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              'assets/svgs/LichenCare main logo.svg',
              width: w * 0.2,
              height: h * 0.3,
            ),
            SvgPicture.asset(
              'assets/svgs/LichenCare main branding.svg',
              width: w * 0.15,
              height: h * 0.08,
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "WELCOME, MY FRIEND!",
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 25),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              padding: const EdgeInsets.only(
                left: 35,
                right: 35,
              ),
              child: const Text(
                'I am LichenCare, your AI friend that will help you identify and analyze your Lichen Planus condition. By the way, I am still a work in progress, so, please be gentle to me. I am not made to replace dermatologists but rather just be a support system and I make no guarantees to the accuracy of my results. I would still recommend to check for your doctor for further and actual medical advice.',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontFamily: 'ABeeZee',
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 60,
            ),
          ],
        ),
      ),
      Container(
        color: Color(0xFFFFF4E9),
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
                  Navigator.of(context).pushNamed('/registration/');
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color(0xFFFF7F50)), // Background color
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: const BorderSide(
                          color: Colors.white,
                          width:
                              1.0), // Border color and width // Border radius
                    ),
                  ),
                  foregroundColor: MaterialStateProperty.all<Color>(
                      Colors.white), // Text color
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                ),
                child: const Text(
                  'GET STARTED!',
                  style: TextStyle(fontSize: 20, fontFamily: 'Questrial'),
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
        color: Color(0xFFFFF4E9),
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
                  'Catalyzing quality clinical outcomes through innovative healthcare technology.',
                  style: TextStyle(fontSize: 23, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/registration/');
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color(0xFFFF7F50)), // Background color
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: const BorderSide(
                          color: Colors.white,
                          width:
                              1.0), // Border color and width // Border radius
                    ),
                  ),
                  foregroundColor: MaterialStateProperty.all<Color>(
                      Colors.white), // Text color
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                ),
                child: const Text(
                  'GET STARTED!',
                  style: TextStyle(fontSize: 20, fontFamily: 'ABeeZee'),
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
                  color: _currentIndex == entry.key
                      ? Color(0xFFFF7F50)
                      : Colors.white,
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
            top: (3.65 / 4) * h,
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
