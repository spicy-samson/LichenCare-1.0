import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:lichen_care/helpers/helpers.dart';

class LichenPediaReferences extends StatefulWidget {
  @override
  _LichenPediaReferencesState createState() => _LichenPediaReferencesState();
}

class _LichenPediaReferencesState extends State<LichenPediaReferences> {
  final int _currentIndex = 1;
  bool isSwipedDown = false;
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _photosPaddingKey = GlobalKey();

  void _onArrowDownPressed() {
    setState(() {
      isSwipedDown = !isSwipedDown;
    });

    if (isSwipedDown) {
      // Calculate the offset for scrolling to the "Photos" section
      double offset = _getOffsetToPhotosSection();
      _scrollController.animateTo(offset,
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    }
  }

  double _getOffsetToPhotosSection() {
    final RenderBox renderBox =
        _photosPaddingKey.currentContext?.findRenderObject() as RenderBox;
    if (renderBox != null) {
      final offset = renderBox.localToGlobal(Offset.zero);
      return offset.dy - 10; // Adjust as needed
    }
    return 0; // Handle the case where the render box is not available
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    double scaleFactor = h / 1080;
    return Scaffold(
      backgroundColor: const Color(0xFFFFF4E9),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFFFFF4E9),
        title: Padding(
          padding: EdgeInsets.only(top: h * 0.02, right: w * 0.42),
          child: SvgPicture.asset(
            'assets/svgs/#2 - lichenpedia.svg',
            width: w * 0.1,
            height: h * 0.6,
          ),
        ),
        elevation: 0,
        toolbarHeight: 80.0,
      ),

      // Body
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              'References',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                fontFamily: 'ABeeZee',
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 35.0, right: 35),
                child: RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 20 * scaleFactor,
                      fontFamily: 'ABeeZee',
                    ),
                    children: [
                      TextSpan(
                        text:
                            'Chen J., Oakley A., Liu J. (2023). Lichen Planus. DermNet. https://dermnetnz.org/topics/lichen-planus\n\n',
                      ),
                      TextSpan(
                        text:
                            'Singh A., Jarrett P., Mitchell G. (2022). Graft Versus Host Disease. DermNet. https://dermnetnz.org/topics/graft-versus-host-disease\n\n',
                      ),
                      TextSpan(
                        text:
                            'Bridges KH. Lichen Planus and Lichen Nitidus. In: Kelly A, Taylor SC, Lim HW, et al., eds. Taylor and Kelly\'s Dermatology for Skin of Color, 2nd Edition. McGraw Hill; 2016. \n\n',
                      ),
                      TextSpan(
                        text:
                            'Mangold AR, Pittelkow MR. Lichen Planus. In: Kang S, Amagai M, Bruckner AL, et al., eds. Fitzpatrick\'s Dermatology, 9th Edition. McGraw Hill; 2019.  \n\n',
                      ),
                      TextSpan(
                        text:
                            'Payette M., Weston G., Humphrey S., Yu J., Holland K. (2016). Lichen planus and other lichenoid dermatoses: Kids are not just little people. Clinics in Dermatology. https://pubmed.ncbi.nlm.nih.gov/26686015/ \n\n',
                      ),
                      TextSpan(
                        text:
                            'Boch K., Langan E., Kridin K., Zillikens D., Ludwig R., Bieber K. (2021). Lichen Planus. Insights in Dermatology. https://www.frontiersin.org/articles/10.3389/fmed.2021.737813/full?fbclid=IwAR1fXTaobmiSYrVeiQLW3IYjrrqd1Q9d_67ndXqRTt881cPlW54GW-B_Ipk \n\n',
                      ),
                      TextSpan(
                        text:
                            'Lichen Planus. (2018). John Hopkins Medicine. https://www.hopkinsmedicine.org/health/conditions-and-diseases/lichen-planus#:~:text=Lichen%20planus%20is%20a%20common,may%20cause%20burning%20or%20soreness. \n\n',
                      ),
                      TextSpan(
                        text:
                            'Lichen Planus (2022). Cleveland Clinic. https://my.clevelandclinic.org/health/diseases/17723-lichen-planus \n\n',
                      ),
                      TextSpan(
                        text:
                            'Oral Lichen Planus (2022). Cleveland Clinic. https://my.clevelandclinic.org/health/diseases/17875-oral-lichen-planus  \n\n',
                      ),
                      TextSpan(
                        text:
                            'American Academy of Oral Medicine. Oral Lichen Planus (https://www.aaom.com/oral-lichen-planus).  \n\n',
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(
                  EdgeInsets.symmetric(
                      horizontal: 20, vertical: 22 * scaleFactor),
                ),
                backgroundColor:
                    MaterialStateProperty.all<Color>(const Color(0xFFFF7F50)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: const BorderSide(
                      color: Colors.white,
                      width: 2.0,
                    ),
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
              height: 20,
            ),
          ],
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
