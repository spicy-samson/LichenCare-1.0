import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';

class LichenPediaVarContent extends StatefulWidget {
  @override
  _LichenPediaVarContentState createState() => _LichenPediaVarContentState();
}

class _LichenPediaVarContentState extends State<LichenPediaVarContent> {
  final int _currentIndex = 1;

  get _controller => null;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

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

      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Center(
                child: GestureDetector(
                  onTap: () {
                    // Scroll to the specific content
                    _scrollToContent();
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(left: 35.0, right: 35),
                    child: Text(
                      'Cutaneous Lichen Planus',
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.w900),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              const Padding(
                padding: EdgeInsets.only(left: 45, right: 45.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'The hallmarks of cutaneous LP are purple or violet, polygonal, shiny, flat-topped, firm, papules, and plaques with white streaks (Wickham striae) (40). Wickham striae are best visualized by dermscopy. The cutaneous lesions may vary in size from several millimeters to more than one centimeter.',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 55.0, right: 35),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '· Papules and polygonal plagues are shiny, flat-topped, and firm on palpation.',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        '· The plagues are crossed by fine white lines called Wickham striae',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        '· Hypertrophic lichen planus can be a scaly and pruritic rash.',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        '· Atrophic lichen planus is a rare annular variant with an atrophic centre.',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        '· Annular lichen planus describes the development of violaceous plaques with central clearing often involving penis, scrotum, and intretriginous areas.',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 90),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 35.0),
                  child: Text(
                    'Sub-Types of Cutaneous Lichen Planus',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 55.0),
                  child: Text(
                    '1. Annular Lichen Planus',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 55.0, right: 35),
                  child: Text(
                    'Characterized by a ring-shaped or annular plaques on the skin',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset(
                      'assets/imgs/annular1.png',
                    ),
                    Image.asset(
                      'assets/imgs/annular2.png',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 55.0),
                  child: Text(
                    '2. Hypertrophic Lichen Planus',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 55.0, right: 35),
                  child: Text(
                    'Lesions are thick and more raised compared to the usual form.',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset(
                      'assets/imgs/hyper1.png',
                    ),
                    Image.asset(
                      'assets/imgs/hyper2.png',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              const SizedBox(height: 25),
              const Center(
                child: Padding(
                  padding: EdgeInsets.only(left: 35.0, right: 35),
                  child: Text(
                    'Mucosal Lichen Planus',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900),
                    textAlign: TextAlign
                        .center, // Center align the text within the Text widget
                  ),
                ),
              ),
              const SizedBox(height: 25),
              const Padding(
                padding: EdgeInsets.only(left: 45, right: 45.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        'Often known as Oral Lichen Planus, the typical lesions are painful and persistent erosions (erosive LP) or diffuse erythema and peeling of the mucosa (desquamative LP). Common features of this variant also include a common pattern of painless white streaks in a lacy or fern-like pattern (Wickham striae) and localized inflammation of the gums adjacent to amalgam fillings.',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w300)),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset(
                      'assets/imgs/mucosal1.png',
                    ),
                    Image.asset(
                      'assets/imgs/mucosal2.png',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 85),
              Padding(
                padding: const EdgeInsets.only(left: 45.0, right: 45),
                child: Container(
                  // Adjust the padding
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/lichenpedia_variant');
                    },
                    child: Text(
                      'Go back to the list',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xFFFF7F50)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
              ),
              const SizedBox(height: 100)
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

  void _scrollToContent() {
    // Define the position you want to scroll to
    const double targetScrollPosition = 200.0; // Adjust this value as needed

    // Scroll to the specific position with animation
    _controller.animateTo(
      targetScrollPosition,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
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
