import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:lichen_care/helpers/helpers.dart';
import 'package:carousel_slider/carousel_slider.dart';

class LichenPedia extends StatefulWidget {
  @override
  _LichenPediaState createState() => _LichenPediaState();
}

class _LichenPediaState extends State<LichenPedia> {
  final int _currentIndex = 1;
  int currentSection = 0;

  Map<String, GlobalKey> scrollKeys = {
    "Table": GlobalKey(),
    "Overview": GlobalKey(),
    "Photos": GlobalKey(),
    "Causes": GlobalKey(),
    "Symptoms": GlobalKey(),
    "Treatments": GlobalKey(),
    "Diagnosis": GlobalKey(),
    "Oral": GlobalKey(),
  };

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
          padding: EdgeInsets.only(top: h * 0.06, right: w * 0.42),
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
      body: GestureDetector(
        onVerticalDragEnd: (details) {
          double swipeSensitivity = 0.1;
          if (details.primaryVelocity! > swipeSensitivity) {
            // swiped down
            if (currentSection != 0) {
              currentSection -= 1;
              _onArrowDownPressed(
                  scrollKeys[scrollKeys.keys.elementAt(currentSection)]!);
            }
          }
          if (details.primaryVelocity! < -swipeSensitivity) {
            // swiped up
            if (currentSection < scrollKeys.length - 1) {
              currentSection += 1;
              _onArrowDownPressed(
                  scrollKeys[scrollKeys.keys.elementAt(currentSection)]!);
            }
          }
        },
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: h - (140),
                  child: Column(children: [
                    SizedBox(key: scrollKeys["Table"], height: 15),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                          padding: EdgeInsets.only(
                              left: 35.0 * scaleFactor,
                              right: 35 * scaleFactor),
                          child: richText(
                            'Welcome to Lichenpedia, your passport to Lichen Planus knowledge. Here, you\'ll find a treasure trove of educational resources, carefully curated to help you understand and navigate the complexities of this unique skin condition, Lichenpedia is your go-to-destination!',
                            fontSize: 20 * (scaleFactor),
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic,
                          )),
                    ),
                    SizedBox(height: 10 * scaleFactor),
                    RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                        style: TextStyle(
                          color: Colors.black,
                          // fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          fontSize: 50 * (scaleFactor),
                        ),
                        children: [TextSpan(text: 'Lichen Planus')],
                      ),
                    ),
                    SizedBox(height: 15 * scaleFactor),
                    Expanded(
                      child: Container(
                        width: 320,
                        decoration: BoxDecoration(
                          color: Color(0xFFFF7F50),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 0.0),
                          child: Column(
                            children: [
                              Flexible(
                                child: listViewCategory("Overview"),
                              ),
                              Flexible(
                                child: listViewCategory("Photos"),
                              ),
                              Flexible(
                                child: listViewCategory("Causes"),
                              ),
                              Flexible(
                                child: listViewCategory("Symptoms"),
                              ),
                              Flexible(
                                child: listViewCategory("Treatments"),
                              ),
                              Flexible(
                                child: listViewCategory("Diagnosis"),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20 * scaleFactor),
                    Padding(
                      padding: const EdgeInsets.only(left: 45.0, right: 45),
                      child: Container(
                        // Adjust the padding
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed('/lichenpedia/lichenpedia_variant');
                          },
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 20 * scaleFactor),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color(0xFFFF7F50)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: const BorderSide(
                                    color: Colors.white,
                                    width: 2.0), // Add the white border here
                              ),
                            ),
                          ),
                          child: const Text(
                            'Variants of Lichen Planus',
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              currentSection += 1;
                              _onArrowDownPressed(scrollKeys["Overview"]!);
                            },
                            icon: const Icon(Icons.keyboard_arrow_down,
                                color: Color(0xFFFF7F50)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ]),
                ),
                SizedBox(
                  height: h - (140),
                  child: Column(
                    children: [
                      Padding(
                        key: scrollKeys["Overview"],
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                currentSection -= 1;
                                _onArrowDownPressed(scrollKeys["Table"]!);
                              },
                              icon: const Icon(Icons.keyboard_arrow_up,
                                  color: Color(0xFFFF7F50)),
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            currentSection -= 1;
                            _onArrowDownPressed(scrollKeys["Table"]!);
                          },
                          child: const Text(
                            'Table of Contents',
                            style: TextStyle(
                              color: Color(0xFFFF7F50),
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15 * scaleFactor,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                            padding: EdgeInsets.only(
                                left: 35.0 * scaleFactor,
                                right: 35 * scaleFactor),
                            child: richText('What is Lichen Planus?',
                                fontSize: 22 * scaleFactor,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.italic)),
                      ),
                      SizedBox(height: 20 * scaleFactor),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 35.0 * scaleFactor,
                              right: 35 * scaleFactor),
                          child: richText(
                            'The term Lichen Planus (LP) or pronounced as (like-en play-nes) stems from the Greek word “leichen”, which means “tree moss”, and the Latin word “planus”, which means “flat”, which aptly describes the surface of the cutaneous lesion. Lichen Planus is an uncommon skin disorder that presents as an itchy rash that appears as flat-topped, itchy, purple-colored bumps of the skin. While LP is a non-contagious skin disease, it can affect any part of the body of the person with it and is most commonly found on the wrists, ankles, lower back, and mouth. LP belongs to a group of chronic inflammatory skin conditions with characteristic clinical and histopathologic findings, ranging from common to rare called lichenoid dermatoses. Commonly, the LP presents many variants in morphology and location also exist.',
                            fontSize: 20 * scaleFactor,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            currentSection += 1;
                            _onArrowDownPressed(scrollKeys["Photos"]!);
                          },
                          child: const Text(
                            'Photos of Lichen Planus',
                            style: TextStyle(
                              color: Color(0xFFFF7F50),
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                currentSection += 1;
                                _onArrowDownPressed(scrollKeys["Photos"]!);
                              },
                              icon: const Icon(Icons.keyboard_arrow_down,
                                  color: Color(0xFFFF7F50)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: h - 140,
                  child: Column(children: [
                    Padding(
                      key: scrollKeys["Photos"],
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              currentSection -= 1;
                              _onArrowDownPressed(scrollKeys["Overview"]!);
                            },
                            icon: const Icon(Icons.keyboard_arrow_up,
                                color: Color(0xFFFF7F50)),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          currentSection -= 1;
                          _onArrowDownPressed(scrollKeys["Overview"]!);
                        },
                        child: const Text(
                          'Overview of Lichen Planus',
                          style: TextStyle(
                            color: Color(0xFFFF7F50),
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15 * scaleFactor),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 35.0 * scaleFactor, right: 35 * scaleFactor),
                        child: Text(
                          'How does Lichen Planus affect my body?',
                          style: TextStyle(
                              fontSize: 22 * scaleFactor,
                              fontWeight: FontWeight.w900,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                    SizedBox(height: 15 * scaleFactor),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 35.0 * scaleFactor, right: 35 * scaleFactor),
                        child: Column(
                          children: [
                            richText(
                              'Lichen Planus commonly affects the skin around a person’s wrists and elbows (flexor surfaces), the back of your hands (dorsal surfaces), and the fronts of your lower legs. About half of all people who have lichen planus develop oral lichen planus, which affects the skin inside of your mouth and your tongue. The lesions on the body of a person with lichen planus usually start as tiny, raised dots (papules) that are about the size of the tip of a pin (0.4 millimeters [mm]). They may grow up to the width of a pencil (1 centimeter [cm]).',
                              fontSize: 20 * scaleFactor,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10 * scaleFactor),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 35.0),
                        child: Text(
                          'Photos',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5 * scaleFactor),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: CarouselSlider(
                        options: CarouselOptions(
                          height: 200 * scaleFactor,
                          enlargeCenterPage: true,
                          enableInfiniteScroll: true,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          scrollDirection: Axis.horizontal,
                        ),
                        items: [
                          [
                            'assets/imgs/lichenpedia_image1.png',
                            'assets/imgs/lichenpedia_image2.png'
                          ],
                          [
                            'assets/imgs/lichenpedia_image2.png',
                            'assets/imgs/lichenpedia_image1.png'
                          ],
                          // Add nalang -- by TWO ang pag add example:

                          //  uncomment nalang this [
                          //   'assets/imgs/lichenpedia_image2.png',
                          //   'assets/imgs/lichenpedia_image1.png'
                          // ],
                        ].map((itemList) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: itemList.map((item) {
                                  return SizedBox(
                                    width: 190 * scaleFactor,
                                    child: Image.asset(
                                      item,
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                }).toList(),
                              );
                            },
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: 5 * scaleFactor),
                    const Spacer(),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          currentSection += 1;
                          _onArrowDownPressed(scrollKeys["Causes"]!);
                        },
                        child: const Text(
                          'Causes of Lichen Planus',
                          style: TextStyle(
                            color: Color(0xFFFF7F50),
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              currentSection += 1;
                              _onArrowDownPressed(scrollKeys["Causes"]!);
                            },
                            icon: const Icon(Icons.keyboard_arrow_down,
                                color: Color(0xFFFF7F50)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ]),
                ),
                SizedBox(
                  height: h - 140,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 5,
                        key: scrollKeys["Causes"],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                currentSection -= 1;
                                _onArrowDownPressed(scrollKeys["Photos"]!);
                              },
                              icon: const Icon(Icons.keyboard_arrow_up,
                                  color: Color(0xFFFF7F50)),
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            currentSection -= 1;
                            _onArrowDownPressed(scrollKeys["Photos"]!);
                          },
                          child: const Text(
                            'Photos of Lichen Planus',
                            style: TextStyle(
                              color: Color(0xFFFF7F50),
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15 * scaleFactor),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 35.0 * scaleFactor,
                              right: 35 * scaleFactor),
                          child: Text(
                            'Causes of Lichen Planus',
                            style: TextStyle(
                                fontSize: 24 * scaleFactor,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                      ),
                      SizedBox(height: 15 * scaleFactor),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 35.0 * scaleFactor,
                              right: 35 * scaleFactor),
                          child: richText(
                            'The exact cause of Lichen Planus is not known, but the following are the possible causes that can contribute to the occurrence of the skin condition:',
                            fontSize: 20 * scaleFactor,
                          ),
                        ),
                      ),
                      SizedBox(height: 15 * scaleFactor),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                            padding: EdgeInsets.only(
                                left: 35.0 * scaleFactor,
                                right: 35 * scaleFactor),
                            child: richText('Systemic Viral Infection',
                                fontSize: 21 * scaleFactor,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.italic)),
                      ),
                      SizedBox(height: 15 * scaleFactor),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 35.0 * scaleFactor,
                              right: 35 * scaleFactor),
                          child: richText(
                            'While having Hepatitis C is not fully associated with having Lichen Planus, some studies have been done to understand the exact mechanism and the relationship between the two conditions. Hepatitis C infection can lead to immune system dysregulation where it becomes overactive resulting in various autoimmune reactions modifying self-antigens on the surface of basal keratinocytes.',
                            fontSize: 20 * scaleFactor,
                          ),
                        ),
                      ),
                      SizedBox(height: 15 * scaleFactor),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                            padding: EdgeInsets.only(
                                left: 35.0 * scaleFactor,
                                right: 35 * scaleFactor),
                            child: richText("Genetic Predisposition",
                                fontSize: 21 * scaleFactor,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.italic)),
                      ),
                      SizedBox(height: 15 * scaleFactor),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 35.0 * scaleFactor,
                              right: 35 * scaleFactor),
                          child: richText(
                            'A person’s genetic makeup can be a possible reason, as it can sometimes run in families because certain genetic factors may make individuals more susceptible to developing the skin condition.',
                            fontSize: 20 * scaleFactor,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            currentSection += 1;
                            _onArrowDownPressed(scrollKeys["Symptoms"]!);
                          },
                          child: const Text(
                            'Symptoms of Lichen Planus',
                            style: TextStyle(
                              color: Color(0xFFFF7F50),
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                currentSection += 1;
                                _onArrowDownPressed(scrollKeys["Symptoms"]!);
                              },
                              icon: const Icon(Icons.keyboard_arrow_down,
                                  color: Color(0xFFFF7F50)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                SizedBox(
                    height: h - 140,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 5,
                          key: scrollKeys["Symptoms"],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  currentSection -= 1;
                                  _onArrowDownPressed(scrollKeys["Causes"]!);
                                },
                                icon: const Icon(Icons.keyboard_arrow_up,
                                    color: Color(0xFFFF7F50)),
                              ),
                            ],
                          ),
                        ),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              currentSection -= 1;
                              _onArrowDownPressed(scrollKeys["Causes"]!);
                            },
                            child: const Text(
                              'Causes of Lichen Planus',
                              style: TextStyle(
                                color: Color(0xFFFF7F50),
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 35.0 * scaleFactor,
                                right: 35 * scaleFactor),
                            child: Text(
                              'Symptoms of Lichen Planus',
                              style: TextStyle(
                                  fontSize: 24 * scaleFactor,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                        ),
                        SizedBox(height: 15 * scaleFactor),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 35.0 * scaleFactor,
                                right: 35 * scaleFactor),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                richText(
                                  'A variety of symptoms of lichen planus can be seen depending on the parts of an individual\'s body affected and its specificity. The following are the common symptoms of Lichen Planus from different parts of the body:',
                                  fontSize: 20 * scaleFactor,
                                ),
                                SizedBox(height: 15 * scaleFactor),
                                richText("Skin",
                                    fontSize: 21 * scaleFactor,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FontStyle.italic),
                                SizedBox(height: 10 * scaleFactor),
                                richText(
                                  'The primary symptoms often involve the presence of shiny, red or purple raised bumps on the skin. These bumps are typically solid and can vary in their level of itchiness, ranging from mild to intense. An individual may experience a few or numerous of theses bumps. Additionally, there is a noticeable fine white lines or scales accompanying the bumps. While they can appear on various parts of the body, they are most frequently found on the wrists, arms, back and ankles.',
                                  fontSize: 20 * scaleFactor,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Spacer(),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              currentSection += 1;
                              _onArrowDownPressed(scrollKeys["Treatments"]!);
                            },
                            child: const Text(
                              'Treatments of Lichen Planus',
                              style: TextStyle(
                                color: Color(0xFFFF7F50),
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  currentSection += 1;
                                  _onArrowDownPressed(
                                      scrollKeys["Treatments"]!);
                                },
                                icon: const Icon(Icons.keyboard_arrow_down,
                                    color: Color(0xFFFF7F50)),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    )),
                SizedBox(
                  height: h - 140,
                  child: Column(children: [
                    Padding(
                      key: scrollKeys["Treatments"],
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              currentSection -= 1;
                              _onArrowDownPressed(scrollKeys["Symptoms"]!);
                            },
                            icon: const Icon(Icons.keyboard_arrow_up,
                                color: Color(0xFFFF7F50)),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          currentSection -= 1;
                          _onArrowDownPressed(scrollKeys["Symptoms"]!);
                        },
                        child: const Text(
                          'Symptoms of Lichen Planus',
                          style: TextStyle(
                            color: Color(0xFFFF7F50),
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 35.0 * scaleFactor, right: 35 * scaleFactor),
                        child: Text('Treatments of Lichen Planus',
                            style: TextStyle(
                                fontSize: 26 * scaleFactor,
                                fontWeight: FontWeight.w900)),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                          padding: EdgeInsets.only(
                              left: 35.0 * scaleFactor,
                              right: 35 * scaleFactor),
                          child: richText("General Measures",
                              fontSize: 21 * scaleFactor,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.italic)),
                    ),
                    SizedBox(height: 15 * scaleFactor),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 45.0 * scaleFactor, right: 35 * scaleFactor),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '· Avoidance of soap and shower gel that will exacerbate scaling',
                              style: TextStyle(
                                fontSize: 20 * scaleFactor,
                              ),
                            ),
                            Text(
                              '· Avoidance of UV light',
                              style: TextStyle(
                                fontSize: 20 * scaleFactor,
                              ),
                            ),
                            Text(
                              '· Use of emollients regularly',
                              style: TextStyle(
                                fontSize: 20 * scaleFactor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 15 * scaleFactor),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                          padding: EdgeInsets.only(
                              left: 35.0 * scaleFactor,
                              right: 35 * scaleFactor),
                          child: richText(
                              "Specific Measures (Topical Treatments)",
                              fontSize: 21 * scaleFactor,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.italic)),
                    ),
                    SizedBox(height: 15 * scaleFactor),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 45.0 * scaleFactor, right: 35 * scaleFactor),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '· Topical corticosteroids, such as clobetasol, for mild to moderate cutaneous involvement',
                              style: TextStyle(
                                fontSize: 20 * scaleFactor,
                              ),
                            ),
                            Text(
                              '· Topical tacrolimus can be useful for sites of skin atrophy, but not ideal for areas with active lesions and erosions',
                              style: TextStyle(
                                fontSize: 20 * scaleFactor,
                              ),
                            ),
                            Text(
                              '· Topical budesonide for oral GVHD Moisturizers and antihistamines for itch.',
                              style: TextStyle(
                                fontSize: 20 * scaleFactor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 15 * scaleFactor),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                          padding: EdgeInsets.only(
                              left: 35.0 * scaleFactor,
                              right: 35 * scaleFactor),
                          child: richText(
                              "Specific Measures (Systematic Treatments)",
                              fontSize: 21 * scaleFactor,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.italic)),
                    ),
                    SizedBox(height: 15 * scaleFactor),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 35.0, right: 35),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '· Oral corticosteroids, a common treatment for acute asthma flare-ups',
                              style: TextStyle(
                                fontSize: 20 * scaleFactor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          currentSection += 1;
                          _onArrowDownPressed(scrollKeys["Diagnosis"]!);
                        },
                        child: const Text(
                          'Diagnosis of Lichen Planus',
                          style: TextStyle(
                            color: Color(0xFFFF7F50),
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              currentSection += 1;
                              _onArrowDownPressed(scrollKeys["Diagnosis"]!);
                            },
                            icon: const Icon(Icons.keyboard_arrow_down,
                                color: Color(0xFFFF7F50)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20)
                  ]),
                ),
                SizedBox(
                  height: h - 140,
                  child: Column(children: [
                    SizedBox(
                      height: 5,
                      key: scrollKeys["Diagnosis"],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              currentSection -= 1;
                              _onArrowDownPressed(scrollKeys["Treatments"]!);
                            },
                            icon: const Icon(Icons.keyboard_arrow_up,
                                color: Color(0xFFFF7F50)),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          currentSection -= 1;
                          _onArrowDownPressed(scrollKeys["Treatments"]!);
                        },
                        child: const Text(
                          'Treatments of Lichen Planus',
                          style: TextStyle(
                            color: Color(0xFFFF7F50),
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 35.0 * scaleFactor, right: 35 * scaleFactor),
                        child: Text(
                          'Diagnosis of Lichen Planus',
                          style: TextStyle(
                              fontSize: 28 * scaleFactor,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                    SizedBox(height: 15 * scaleFactor),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                          padding: EdgeInsets.only(
                              left: 35.0 * scaleFactor,
                              right: 35 * scaleFactor),
                          child: richText('How is Lichen Planus diagnosed?',
                              fontSize: 22 * scaleFactor,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.italic)),
                    ),
                    SizedBox(height: 15 * scaleFactor),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 35.0 * scaleFactor, right: 35 * scaleFactor),
                        child: richText(
                          'Lichen planus is usually diagnosed by your healthcare provider through a symptom assessment and physical examination. They\'ll often search for key features, referred to as the "Six Ps," to confirm the diagnosis:',
                          fontSize: 20 * scaleFactor,
                        ),
                      ),
                    ),
                    SizedBox(height: 15 * scaleFactor),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 55.0 * scaleFactor, right: 45 * scaleFactor),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '1. Prutitic (They\'re itchy).',
                              style: TextStyle(
                                fontSize: 20 * scaleFactor,
                              ),
                            ),
                            Text(
                              '2. Polygonal (Your rash shape has many sharp angles)',
                              style: TextStyle(
                                fontSize: 20 * scaleFactor,
                              ),
                            ),
                            Text(
                              '3. Planar (The top is flat).',
                              style: TextStyle(
                                fontSize: 20 * scaleFactor,
                              ),
                            ),
                            Text(
                              '4. Purple (They present a purplish color)',
                              style: TextStyle(
                                fontSize: 20 * scaleFactor,
                              ),
                            ),
                            Text(
                              '5. Papules (presence of bumps)',
                              style: TextStyle(
                                fontSize: 20 * scaleFactor,
                              ),
                            ),
                            Text(
                              '6. Plagues (raised, discolored, patches)',
                              style: TextStyle(
                                fontSize: 20 * scaleFactor,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 15 * scaleFactor),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 35.0 * scaleFactor, right: 35 * scaleFactor),
                        child: richText(
                          'If there\'s any doubt, your healtcare provider may perform the following tests:',
                          fontSize: 22 * scaleFactor,
                        ),
                      ),
                    ),
                    SizedBox(height: 15 * scaleFactor),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 35.0 * scaleFactor, right: 35 * scaleFactor),
                        child: richText(
                          'Allergy test. An allergy test can determine if you have an allergy that\'s causing your lichen planus flare-up',
                          fontSize: 22 * scaleFactor,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              currentSection += 1;
                              _onArrowDownPressed(scrollKeys["Oral"]!);
                            },
                            icon: const Icon(Icons.keyboard_arrow_down,
                                color: Color(0xFFFF7F50)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ]),
                ),
                SizedBox(
                  height: 5,
                  key: scrollKeys["Oral"],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          currentSection -= 1;
                          _onArrowDownPressed(scrollKeys["Diagnosis"]!);
                        },
                        icon: const Icon(Icons.keyboard_arrow_up,
                            color: Color(0xFFFF7F50)),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 35.0 * scaleFactor, right: 35 * scaleFactor),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        richText(
                          '· For oral lichen planus, stop smoking, avoid alcohol, maintain good oral hygiene, and avoid any foods that seem to irritate your mouth.',
                          fontSize: 20 * scaleFactor,
                        ),
                        SizedBox(height: 15 * scaleFactor),
                        richText(
                          'Lichen Planus is not a dangerous disease, and it usually goes away on its own. However, in some people, it may come back.',
                          fontSize: 20 * scaleFactor,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: () {
                    currentSection = 1;
                    _onArrowDownPressed(scrollKeys["Overview"]!);
                  },
                  child: const Center(
                    child: Text(
                      'Jump to Overview',
                      style: TextStyle(
                        color: Color(0xFFFF7F50),
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          currentSection = 1;
                          _onArrowDownPressed(scrollKeys["Overview"]!);
                        },
                        icon: const Icon(
                            Icons.keyboard_double_arrow_up_outlined,
                            color: Color(0xFFFF7F50)),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(left: 35.0, right: 35),
                    child: Text(
                      'Discover more about Lichen Planus',
                      style: TextStyle(
                          fontSize: 26 * scaleFactor,
                          fontWeight: FontWeight.w900),
                      textAlign: TextAlign
                          .center, // Center align the text within the Text widget
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.only(left: 45.0, right: 45),
                  child: Container(
                    // Adjust the padding
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed('/lichenpedia/lichenpedia_vault');
                      },
                      child: Text(
                        'Explore Lichen Planus through Online Videos',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20 * scaleFactor),
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
                ),
                SizedBox(height: 25 * scaleFactor),
                Padding(
                  padding: const EdgeInsets.only(left: 45.0, right: 45),
                  child: Container(
                    // Adjust the padding
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed('/lichenpedia/lichenpedia_archive');
                      },
                      child: Text(
                        'Discover Lichen Planus through Academic Publications',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.symmetric(
                              horizontal: 15, vertical: 20 * scaleFactor),
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
                ),
                SizedBox(height: 25 * scaleFactor),
                Padding(
                  padding: const EdgeInsets.only(left: 45.0, right: 45),
                  child: Container(
                    // Adjust the padding
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed('/lichenpedia/lichenpedia_reference');
                      },
                      child: Text(
                        ' See References and Sources                ',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.symmetric(
                              horizontal: 15, vertical: 20 * scaleFactor),
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
                ),
                const SizedBox(height: 105),
              ],
            ),
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

  void _onArrowDownPressed(GlobalKey scrollkey) {
    Scrollable.ensureVisible(scrollkey.currentContext!,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  Widget listViewCategory(String category) {
    return TextButton(
      style: TextButton.styleFrom(
          shape: LinearBorder.bottom(
              side: (category == "Diagnosis")
                  ? BorderSide.none
                  : const BorderSide(width: 2.0, color: Colors.black12))),
      onPressed: () {
        currentSection = scrollKeys.keys.toList().indexOf(category);
        _onArrowDownPressed(scrollKeys[category]!);
      },
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 25, right: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                category,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
