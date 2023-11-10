import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LichenPediaArchive extends StatefulWidget {
  @override
  _LichenPediaArchiveState createState() => _LichenPediaArchiveState();
}

class _LichenPediaArchiveState extends State<LichenPediaArchive> {
  final int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    double scaleFactor = h/1080 * 0.9;
    return Scaffold(
      backgroundColor: const Color(0xFFFFF4E9),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFFFFF4E9),
        title: Padding(
          padding: EdgeInsets.only(top: h * 0.05, right: w * 0.5),
          child: SvgPicture.asset(
            'assets/svgs/#2 - lichenpedia.svg',
            width: w * 0.1,
            height: h * 0.047,
          ),
        ),
        elevation: 0,
        toolbarHeight: 80.0,
      ),

      // Body
      body: Container(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                'Research Archive',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () {
                  launchUrlString(
                    'https://www.aafp.org/pubs/afp/issues/2011/0701/p53.html',
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        'assets/svgs/researchbook_icon.svg',
                        width: 150,
                        height: 100,
                      ),
                       Padding(
                        padding: EdgeInsets.only(
                          left: 10.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Diagnosis and treatment of lichen planus',
                              style: TextStyle(
                                fontSize: 18*scaleFactor,
                                fontWeight: FontWeight.w300,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            Text(
                              'RP Usatine, M Tinitigan - American family',
                              style: TextStyle(
                                fontSize: 18*scaleFactor,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text(
                              'physician ... than 50 percent of women',
                              style: TextStyle(
                                fontSize: 18*scaleFactor,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text(
                              'with oral lichen planus have undiagnosed',
                              style: TextStyle(
                                fontSize: 18*scaleFactor,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text(
                              'vulvar lichen planus. ..., widespread oral',
                              style: TextStyle(
                                fontSize: 18*scaleFactor,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text(
                              'lichen planus and for lichen planus',
                              style: TextStyle(
                                fontSize: 18*scaleFactor,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text(
                              'involving other mucocutaneous sites. ...',
                              style: TextStyle(
                                fontSize: 18*scaleFactor,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () {
                  launchUrlString(
                      'https://jamanetwork.com/journals/jamadermatology/article-abstract/526872');
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        'assets/svgs/researchbook_icon.svg',
                        width: 150,
                        height: 100,
                      ),
                       Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'The variations and cause of lichen planus',
                              style: TextStyle(
                                fontSize: 18*scaleFactor,
                                fontWeight: FontWeight.w300,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            Text(
                              'J Altman, HO Perry - Archives of',
                              style: TextStyle(
                                fontSize: 18*scaleFactor,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text(
                              'Dermatology, 1961... lichen planus and its',
                              style: TextStyle(
                                fontSize: 18*scaleFactor,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text(
                              'variations. Most of the previous statistical',
                              style: TextStyle(
                                fontSize: 18*scaleFactor,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text(
                              'studies date back to the American',
                              style: TextStyle(
                                fontSize: 18*scaleFactor,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text(
                              'Dermatologic Association symposium on',
                              style: TextStyle(
                                fontSize: 18*scaleFactor,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text(
                              'lichen planus... patients with lichen',
                              style: TextStyle(
                                fontSize: 18*scaleFactor,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text(
                              'planus. He...',
                              style: TextStyle(
                                fontSize: 18*scaleFactor,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () {
                  launchUrlString(
                      'https://onlinelibrary.wiley.com/doi/abs/10.1111/j.1600-0714.2010.00946.x');
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        'assets/svgs/researchbook_icon.svg',
                        width: 150,
                        height: 100,
                      ),
                       Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pathogenesis of oral lichen planus - a',
                              style: TextStyle(
                                fontSize: 18*scaleFactor,
                                fontWeight: FontWeight.w300,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            Text(
                              'review',
                              style: TextStyle(
                                fontSize: 18*scaleFactor,
                                fontWeight: FontWeight.w300,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            Text(
                              'Mr Roopashree, RV Gondhalekar...',
                              style: TextStyle(
                                fontSize: 18*scaleFactor,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text(
                              'Journal of Oral... The various hypothesis',
                              style: TextStyle(
                                fontSize: 18*scaleFactor,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text(
                              'proposed for pathogenesis of oral ',
                              style: TextStyle(
                                fontSize: 18*scaleFactor,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text(
                              'lichen planus are discussed in...',
                              style: TextStyle(
                                fontSize: 18*scaleFactor,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text(
                              'defining lichen planus as a true',
                              style: TextStyle(
                                fontSize: 18*scaleFactor,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text(
                              'autoimmune disease. An early event in',
                              style: TextStyle(
                                fontSize: 18*scaleFactor,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text(
                              'lichen planus lesion ...',
                              style: TextStyle(
                                fontSize: 18*scaleFactor,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
               ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
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
                        'Go back',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),

      // Floating action button
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _lichenCheckBtn(context),

      // Bottom navigation ba()
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
            // Navigator.of(context).pushNamed(
            //     '/lichenpedia'); // Navigate to the 'lichenpedia' route
            break;
          case 2:
            Navigator.of(context).pushNamed(
                '/lichencheck'); // Navigate to the 'lichencheck' route
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
}

Widget _buildTextWithDivider(String text) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(
          left: 30.0,
          bottom: 6,
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      if (text != 'Variants of Lichen Planus')
        const Divider(
          color: Colors.black,
        ),
    ],
  );
}
