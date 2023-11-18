import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TermsAndConditions extends StatelessWidget {
  int _currentIndex = 4;
  Color secondaryForegroundColor = Color.fromARGB(255, 110, 189, 183);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    double scaleFactor = h / 1080;

    return Scaffold(
      backgroundColor: Color(0xFFFFF4E9),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFFFFF4E9),
        title: Padding(
          padding: EdgeInsets.only(top: h * 0.04, right: w * 0.15),
          child: SvgPicture.asset(
            'assets/svgs/profileSection/profileAppBars/terms_and_conditions(copy).svg',
            width: w * 0.1,
            height: h * 0.8,
          ),
        ),
        elevation: 0,
        toolbarHeight: 75.0,
      ),

      // Body
      body: Padding(
        padding: const EdgeInsets.only(left: 45.0, right: 45),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            height: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 20 * scaleFactor,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: 'LichenCare Terms of Use',
                        style: TextStyle(
                          fontSize: 22 * scaleFactor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: '\nEffective as of: November 20, 2023\n\n',
                        style: TextStyle(
                          fontSize: 18 * scaleFactor,
                          fontStyle: FontStyle.italic,
                          height: 1.3,
                        ),
                      ),
                      TextSpan(
                        text: 'Introduction\n',
                        style: TextStyle(
                          fontSize: 18 * scaleFactor,
                          height: 1.7,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      TextSpan(
                        text:
                            'Welcome to LichenCare! Please read these Terms of Use (“Terms”) carefully as they govern your use (which includes access to) LichenCare’s personalized services for the classification of the Cutaneous Lichen Planus skin disease, including the in-app features (LichenCheck, Lichenpedia, LichenHub) that incorporate or link to these Terms (collectively, the “LichenCare Service”). LichenCare mobile application and LichenCare external services or APIs use experimental Artificial Intelligence (“AI”) technology to offer general information for general educational purposes (“Services”), subject to your reading, understanding, and agreement with all of these terms and conditions (“Terms”).\n\n',
                        style: TextStyle(
                          fontSize: 18 * scaleFactor,
                        ),
                      ),
                      TextSpan(
                        text:
                            'LichenCare may modify these Terms at any time, and such modifications shall be effective immediately upon posting the updated Terms on our app. External entities that use our APIs are wholly responsible for ensuring that our updated Terms are presented and acknowledged by users.\n\n',
                        style: TextStyle(
                          fontSize: 18 * scaleFactor,
                        ),
                      ),
                      TextSpan(
                        text:
                            'If you A) do not agree with all the Terms bar none, or if B) you are under the age of fourteen (14), or if C) you have or belong to any of the contraindications as stated below, do not use LichenCare and our Services. Please review all of the Terms carefully before proceeding.',
                        style: TextStyle(
                          fontSize: 18 * scaleFactor,
                        ),
                      ),
                    ],
                  ),
                ),

                //Supply of Services
                SizedBox(height: 15),
                RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 20 * scaleFactor,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: 'Supply of Services\n',
                        style: TextStyle(
                          fontSize: 18 * scaleFactor,
                          fontWeight: FontWeight.bold,
                          height: 1.3,
                        ),
                      ),
                      TextSpan(
                        text:
                            'We provide the following services the application’s main features through external services or APIs, with its bound terms and conditions of use:',
                        style: TextStyle(
                          fontSize: 18 * scaleFactor,
                        ),
                      ),
                    ],
                  ),
                ),

                //1. LichenCheck
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 18 * scaleFactor,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          height: 1.5,
                        ),
                        children: [
                          TextSpan(
                            text: '1. ',
                          ),
                          TextSpan(
                            text: 'LichenCheck',
                            style: TextStyle(
                              fontSize: 18 * scaleFactor,
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                //  LichenCheck items (a,b,c,d)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 35.0, right: 20),
                    child: RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 20 * scaleFactor,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: ' ',
                          ),
                          TextSpan(
                            text: 'a. ',
                          ),
                          TextSpan(
                            text: 'Image Capture: ',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18 * scaleFactor,
                            ),
                          ),
                          TextSpan(
                            text:
                                'LichenCheck feature can capture images of the target skin condition. You can also upload images from your device into LichenCheck as another option in providing image input.\n',
                            style: TextStyle(
                              fontSize: 18 * scaleFactor,
                            ),
                          ),
                          TextSpan(
                            text: 'b. ',
                          ),
                          TextSpan(
                            text: 'Image Capture: ',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18 * scaleFactor,
                            ),
                          ),
                          TextSpan(
                            text:
                                'Images submitted will be analyzed by our AI model. In turn, LichenCheck will ask you for additional patient information.\n',
                            style: TextStyle(
                              fontSize: 18 * scaleFactor,
                            ),
                          ),
                          TextSpan(
                            text: 'c. ',
                          ),
                          TextSpan(
                            text: 'AI Works: ',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18 * scaleFactor,
                            ),
                          ),
                          TextSpan(
                            text:
                                'Images submitted will be analyzed and will undergo the process of image classification by our pre-trained AI model.\n',
                            style: TextStyle(
                              fontSize: 18 * scaleFactor,
                            ),
                          ),
                          TextSpan(
                            text: 'd. ',
                          ),
                          TextSpan(
                            text: 'Results: ',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18 * scaleFactor,
                            ),
                          ),
                          TextSpan(
                            text:
                                'Our AI will reveal the results after accomplishing additional patient information asked by LichenCheck to the user. Results generated by AI are not medical advice and are not meant to replace formal consultation with your local licensed healthcare professional. We make no hundred percent guarantee to the accuracy of the results. We encourage everyone to still seek medical advice from dermatologists as they are still the ones knowledgeable of the Lichen Planus skin disease. Our services offered in this mobile application are a tool for decision support and healthcare aid for everyone.\n',
                            style: TextStyle(
                              fontSize: 18 * scaleFactor,
                            ),
                          ),
                          TextSpan(
                            text: ' ',
                          ),
                          TextSpan(
                            text: ' ',
                          ),
                          TextSpan(
                            text: '\nLICHENCHECK DISCLAIMER\n',
                            style: TextStyle(
                              fontSize: 18 * scaleFactor,
                              color: secondaryForegroundColor,
                            ),
                          ),
                          TextSpan(
                            text: ' ',
                          ),
                          TextSpan(
                            text:
                                'LichenCheck feature provides broad classifications of Cutaneous Lichen Planus (annular, hypertrophic, linear) for educational purposes only. It does not replace professional medical advice; consult a healthcare professional for accurate diagnosis. LichenCare is a supportive tool, not a substitute for expert judgment. Users are responsible for interpreting results and acknowledging technology limitations. False positives or negatives may occur. Use at your own risk. LichenCare disclaims any liability for actions based on app information. By proceeding, you agree to these terms. For comprehensive skin health assessments, consult a healthcare professional.\n',
                            style: TextStyle(
                              fontSize: 18 * scaleFactor,
                            ),
                          ),
                          TextSpan(
                            text: ' ',
                          ),
                          TextSpan(
                            text: ' ',
                          ),
                          TextSpan(
                            text: '\nOur AI Technology\n',
                            style: TextStyle(
                              fontSize: 18 * scaleFactor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text: ' ',
                          ),
                          TextSpan(
                            text:
                                'We use our proprietary AI algorithms, more specifically, the work of the pre-trained machine learning model. These are highly experimental in nature and were developed in our own workstation. While the pre-trained model is still a work in progress, it is solely responsible for the decision-making process and the results generated by our services. Our application will also ask you for patient information as part of the database and collection of important data that correlates with the provided image of the skin disease. As such, if you cannot accept the nature of our technology and its overt limitations, please stop using our services immediately.\n',
                            style: TextStyle(
                              fontSize: 18 * scaleFactor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                //2. LichenPedia
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 18 * scaleFactor,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          height: 1.5,
                        ),
                        children: [
                          TextSpan(
                            text: '2. ',
                          ),
                          TextSpan(
                            text: 'LichenPedia',
                            style: TextStyle(
                              fontSize: 18 * scaleFactor,
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                //  Description
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 35.0, right: 20),
                    child: RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 20 * scaleFactor,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: ' ',
                          ),
                          TextSpan(
                            text:
                                'Lichenpedia is designed for educational purposes only. The information provided is intended to supplement, not replace, the relationship between individuals and their healthcare providers. While we strive for accuracy, the information in Lichenpedia may not be exhaustive, complete, or up-to-date. Users are encouraged to verify information with qualified healthcare professionals and authoritative sources. Remember that Lichenpedia does not provide medical advice, diagnosis, or treatment. The content is not a substitute for professional medical advice. Always consult with a qualified healthcare professional for accurate medical guidance.  Users are responsible for how they use the information provided in Lichenpedia and LichenCare is not liable for any actions taken or decisions made based on the information within Lichenpedia. LichenCare may update or modify the content within Lichenpedia to ensure accuracy and relevance. Users are encouraged to check for updates regularly. In addition, the content within Lichenpedia is protected by copyright and other intellectual property laws. Users may not reproduce, distribute, or modify the content without explicit permission from the application. In line with this, the feature may contain links to external websites for additional information as Lichencare is not responsible for the content, accuracy, or privacy practices of these external sites. Lastly, the application reserves the right to terminate or restrict access to this feature at any time without notice.\n',
                            style: TextStyle(
                              fontSize: 18 * scaleFactor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                //3. LichenHub
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 18 * scaleFactor,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          height: 1.5,
                        ),
                        children: [
                          TextSpan(
                            text: '3. ',
                          ),
                          TextSpan(
                            text: 'LichenHub',
                            style: TextStyle(
                              fontSize: 18 * scaleFactor,
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                //  LichenHub items (a,b,c,d,e,g,h,i,j)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 35.0, right: 20),
                    child: RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 20 * scaleFactor,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: ' ',
                          ),
                          TextSpan(
                            text: 'a. ',
                          ),
                          TextSpan(
                            text: 'Community Purpose: ',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18 * scaleFactor,
                            ),
                          ),
                          TextSpan(
                            text:
                                'LichenHub is a community forum for individuals with lichen planus to share information, experiences, and support. Users are expected to engage respectfully, responsibly, and empathetically. Users are encouraged to contribute positively to the community by sharing insights, asking questions, and offering support.\n',
                            style: TextStyle(
                              fontSize: 18 * scaleFactor,
                            ),
                          ),
                          TextSpan(
                            text: 'b. ',
                          ),
                          TextSpan(
                            text: 'No Medical Advice: ',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18 * scaleFactor,
                            ),
                          ),
                          TextSpan(
                            text:
                                'Content shared on LichenHub, including posts, comments, and discussions, does not constitute medical advice, diagnosis, or treatment. Always consult with a qualified healthcare professional for accurate medical guidance. Any medical information shared should be accompanied by a disclaimer highlighting its non-professional nature.\n',
                            style: TextStyle(
                              fontSize: 18 * scaleFactor,
                            ),
                          ),
                          TextSpan(
                            text: 'c. ',
                          ),
                          TextSpan(
                            text: 'User Responsibility: ',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18 * scaleFactor,
                            ),
                          ),
                          TextSpan(
                            text:
                                'Users are responsible for the accuracy and legality of their contributions to this feature. LichenCare is not liable for any actions taken or decisions made based on user-generated content.\n',
                            style: TextStyle(
                              fontSize: 18 * scaleFactor,
                            ),
                          ),
                          TextSpan(
                            text: 'd. ',
                          ),
                          TextSpan(
                            text: 'Respectful Conduct: ',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18 * scaleFactor,
                            ),
                          ),
                          TextSpan(
                            text:
                                'Users are expected to engage in respectful and constructive discussions. Harassment, hate speech, or any form of abusive behavior will not be tolerated. LichenCare reserves the right to moderate, edit, or remove content that violates community guidelines. LichenHub is a space for respectful and constructive conversations. Harassment, hate speech, discrimination, or any form of abusive behavior will not be tolerated thus, users are encouraged to engage in open-minded and empathetic discussions, recognizing the diversity of experiences within the community. Be mindful of the sensitivity of the information shared and obtain consent before sharing personal stories or experiences involving others.\n',
                            style: TextStyle(
                              fontSize: 18 * scaleFactor,
                            ),
                          ),

                          //3. LichenHub e-j
                          TextSpan(
                            text: 'e. ',
                          ),
                          TextSpan(
                            text: 'Privacy and Confidentiality: ',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18 * scaleFactor,
                            ),
                          ),
                          TextSpan(
                            text:
                                'LichenCare understands the importance of privacy and confidentiality. Any information accomplished in this feature will not be shared across third-party applications or any form of media. As for the users of this feature, respect the privacy of others. Do not share personal information, including contact details or medical records, on LichenHub. Users are encouraged to be mindful of the sensitivity of the information shared in a public forum.\n',
                            style: TextStyle(
                              fontSize: 18 * scaleFactor,
                            ),
                          ),

                          TextSpan(
                            text: 'f. ',
                          ),
                          TextSpan(
                            text: 'Intellectual Property: ',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18 * scaleFactor,
                            ),
                          ),
                          TextSpan(
                            text:
                                'Users retain ownership of their original content. By posting on LichenHub, users grant LichenCare a license to use, modify, and display the content within the app. Reproduction or distribution of user-generated content outside the LichenCare app without explicit permission is prohibited.\n',
                            style: TextStyle(
                              fontSize: 18 * scaleFactor,
                            ),
                          ),

                          TextSpan(
                            text: 'g. ',
                          ),
                          TextSpan(
                            text: 'External Links: ',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18 * scaleFactor,
                            ),
                          ),
                          TextSpan(
                            text:
                                'LichenHub may contain links to external websites if users tend to publish links in the forum. LichenCare is not responsible for the content, accuracy, or privacy practices of these external sites. However, reporting such inappropriate external links is encouraged to moderate the content being produced.\n',
                            style: TextStyle(
                              fontSize: 18 * scaleFactor,
                            ),
                          ),

                          TextSpan(
                            text: 'h. ',
                          ),
                          TextSpan(
                            text: 'Moderation and Termination: ',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18 * scaleFactor,
                            ),
                          ),
                          TextSpan(
                            text:
                                'LichenCare reserves the right to moderate LichenHub feature, including the removal of inappropriate content, suspension, or termination of access for users who violate community guidelines.\n',
                            style: TextStyle(
                              fontSize: 18 * scaleFactor,
                            ),
                          ),

                          TextSpan(
                            text: 'i. ',
                          ),
                          TextSpan(
                            text: 'Disclaimer of Liability: ',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18 * scaleFactor,
                            ),
                          ),
                          TextSpan(
                            text:
                                'LichenCare disclaims any liability for damages arising from the use of LichenHub. Users participate at their own risk. The content in LichenHub reflects the views of individual users and does not necessarily represent the views of LichenCare.\n',
                            style: TextStyle(
                              fontSize: 18 * scaleFactor,
                            ),
                          ),

                          TextSpan(
                            text: 'j. ',
                          ),
                          TextSpan(
                            text: 'Termination of Access: ',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18 * scaleFactor,
                            ),
                          ),
                          TextSpan(
                            text:
                                'LichenCare reserves the right to terminate or restrict access to LichenHub at any time without notice, especially in cases of repeated violations of community guidelines.\n',
                            style: TextStyle(
                              fontSize: 18 * scaleFactor,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 5),

                //General Disclaimer
                Align(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 20 * scaleFactor,
                      ),
                      children: const [
                        TextSpan(
                            text:
                                'Please read these Terms of Use (“Terms”) carefully as they govern your use (which includes access to) LichenCare’s personalized services for classification of the Cutaneous Lichen Planus skin disease, including the in-app features (LichenCheck, Lichenpedia, LichenHub) that incorporate or link to these Terms (collectively, the “LichenCare Service”).'),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed('/login');
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.symmetric(
                              horizontal: 20, vertical: 22 * scaleFactor),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xFFFF7F50),
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
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
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed('/profile/privacy_policy');
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.symmetric(
                              horizontal: 20, vertical: 22 * scaleFactor),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xFFFF7F50),
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
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
                        'I accept',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
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

Color primaryforegroundColor = const Color(0xFFFF7F50);
