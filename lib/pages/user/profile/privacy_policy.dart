import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PrivacyPolicy extends StatelessWidget {
  final int _currentIndex = 4;
  final bool onBoot;
  const PrivacyPolicy({super.key, this.onBoot = false});

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
          padding: EdgeInsets.only(top: h * 0.04, right: w * 0.35),
          child: SvgPicture.asset(
            'assets/svgs/profileSection/profileAppBars/privacy_policy(copy).svg',
            width: w * 0.1,
            height: h * 0.8,
          ),
        ),
        elevation: 0,
        toolbarHeight: 80.0,
      ),

      // Body
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: ListView(
          children: [
            Column(
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
                        text: 'LichenCare Privacy Policy',
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
                            'Hello there! We at LichenCare are about your privacy. We are fully committed to protecting and safeguarding the personal data you share with us when you use our services. In this Privacy Policy, we explain what kind of data we use, and how we use it.\n\n',
                        style: TextStyle(
                          fontSize: 18 * scaleFactor,
                        ),
                      ),
                      TextSpan(
                        text:
                            'We might amend this Privacy Policy from time to time. Please visit this page regularly in order to understand what we do and know our updates.\n\n',
                        style: TextStyle(
                          fontSize: 18 * scaleFactor,
                        ),
                      ),
                      TextSpan(
                        text:
                            'We have designed our services with your privacy in mind. As this is always a two-way dynamic process, we would be happy to hear feedback from you about how we can further strengthen this commitment to privacy. However, if you do not agree with our processing of personal data as described in this Privacy Policy, you cannot continue the use of our Services.',
                        style: TextStyle(
                          fontSize: 18 * scaleFactor,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),

                //What data do we collect?
                Align(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 20 * scaleFactor,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: 'What data do we collect?',
                          style: TextStyle(
                            fontSize: 18 * scaleFactor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5),
                //  What data do we collect?.. STATEMENT
                Align(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 20 * scaleFactor,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text:
                              "LichenCare requires an account creation and requests login to access our services. Part of the account creation is the accomplishment of First Name, Last Name, Email, and Password. Email address is collected for the account verification process to authorize the registered user. Other personal information such as financial information, address, contact details, social security number, birth registration number, exact date of birth, aliases or other common sensitive personal data normally associated with account registration will not be needed in the usage of the application. However, the use of the LichenCheck, a feature that allows user to upload images from their camera or gallery and submit them to the application for the AI to generate results will require several data gathering. This patient information needed includes Sex, Age, Country, Ethnicity, Onset of the Rash, Severity of Itching, and Severity of Pain for the feature to generate results. The collected patient information is needed for the correlation of the detected skin disease and the linked patient information is vital for the association of such demographics to further improve the information and knowledge about Lichen Planus. The personal information gathered will be utilized with end-to-end encryption and be handled with utmost security. You are hence advised to keep checking on our website, apps, or services to be always mindful of any changes to our Terms of Use and Privacy Policy. You are encouraged to reach out to us for any concerns or questions instead.",
                          style: TextStyle(
                            fontSize: 18 * scaleFactor,
                          ),
                        ),
                        TextSpan(text: '\n'),
                        TextSpan(text: '\n'),
                        TextSpan(
                          text:
                              "Upon using the LichenCheck feature, at each attempt, you will take a photo of the target skin condition. Please do not take photos that contain sensitive and personal information - such as photos of your face or those that contain identifying content. This is something that we cannot control. Image processing is then done locally on your device and the result is uploaded to our server for AI analysis, along with a copy of your locally stored biodata. We neither require nor capture your geolocation for submission. If you need to delete your biodata, simply clear the cache and uninstall LichenCare. User-submitted data are only used by our AI to derive a more accurate prediction. Data is not used for discrimination or to deny services to any particular groups of people.",
                          style: TextStyle(
                            fontSize: 18 * scaleFactor,
                          ),
                        ),
                        TextSpan(text: '\n'),
                        TextSpan(text: '\n'),
                        TextSpan(
                          text:
                              "While using the LichenHub feature, our team ensures the anonymity of every user as their names will only be displayed as ‘Anonymous User’ to protect the privacy and ensure the safety of every stakeholder. Do take not that Your contributions to LichenHub, such as posts and comments, are visible to other users in the community. Rest assured that every content posted or published in this community forum will only stay on the application and will not be uploaded nor shared in any third-party applications and social media sites. This feature does not track any location nor collect any personal sensitive information and will solely focus on its purpose and usability. Changes to this Privacy Policy will be effective as of the date specified at the top of the policy.\n",
                          style: TextStyle(
                            fontSize: 18 * scaleFactor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15),

                // Why we collect your data, and on what grounds
                Align(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 20 * scaleFactor,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text:
                              'Why we collect your data, and on what grounds?',
                          style: TextStyle(
                            fontSize: 18 * scaleFactor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5),
                //  Why we collect your data, and on what grounds?.. STATEMENT
                Align(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 20 * scaleFactor,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text:
                              "We use collected data for research - to improve the accuracy, reliability, and stability of our AI technology so that one day our capabilities can be used to tackle global medical challenges. Your data is pseudonymized and anonymized for this purpose. By using our services, you explicitly consent to the images being processed for the purposes of the provision of the services and to be used anonymously for the purposes of research, and testing of our services and to advance the interests of LichenCare. As such, your images may be reviewed by our employees or third-party consultants who work for us and who are bound by strict confidentiality.\n",
                          style: TextStyle(
                            fontSize: 18 * scaleFactor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15),

                // Data Policy
                Align(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 20 * scaleFactor,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: 'Data Policy',
                          style: TextStyle(
                            fontSize: 18 * scaleFactor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5),
                //  Data Policy, and on what grounds?.. STATEMENT
                Align(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 20 * scaleFactor,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text:
                              "Data provided to us are stored on secure cloud servers operated by trusted major companies. These servers may not be fixed to a certain specific location, but are all held to similarly high standards. We will take the appropriate measures to prevent unauthorized access and/or misuse of your data. Consequently, your personal information may be transferred to, and stored at, a destination outside your country. It may also be handled by staffs or by other third-party service providers. We take reasonable steps to ensure your data is handled securely. By using our services, you acknowledge and consent to this.\n",
                          style: TextStyle(
                            fontSize: 18 * scaleFactor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15),

                //Data Retention
                Align(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 20 * scaleFactor,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: 'Data Retention',
                          style: TextStyle(
                            fontSize: 18 * scaleFactor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5),
                //  Data Retention.. STATEMENT
                Align(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 20 * scaleFactor,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text:
                              "LichenCare will periodically destroy or de-identify your collected data once it is no longer required for the purpose or purposes for which it was collected.\n",
                          style: TextStyle(
                            fontSize: 18 * scaleFactor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15),

                //Data of Children
                Align(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 20 * scaleFactor,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: 'Data of Children',
                          style: TextStyle(
                            fontSize: 18 * scaleFactor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5),
                //  Data of Children.. STATEMENT
                Align(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 20 * scaleFactor,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text:
                              "Our service can only be used when you have reached the age of fourteen (14) years or older.\n",
                          style: TextStyle(
                            fontSize: 18 * scaleFactor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15),

                //Your access to your data
                Align(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 20 * scaleFactor,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: 'Your access to your data',
                          style: TextStyle(
                            fontSize: 18 * scaleFactor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5),
                //  Your access to your data.. STATEMENT
                Align(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 20 * scaleFactor,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text:
                              "You access your stored data in the application at any point in time. However, if you do not want access to our services anymore, we also cannot delete your account, because there is not any to begin with. There is no way we can trace any of your data back to you. It is a one-way data flow. Your collected data would have been pseudonymized in the sea of databases or could have been destroyed if not flagged for research, and hence we cannot find, delete or retrieve it for you.\n\n",
                          style: TextStyle(
                            fontSize: 18 * scaleFactor,
                          ),
                        ),
                        TextSpan(
                          text:
                              "As such, if you feel that you need to terminate our services, please simply stop using the application.\n",
                          style: TextStyle(
                            fontSize: 18 * scaleFactor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15),
              ],
            ),
            SizedBox(height: 5),

            //And hence...
            Align(
              alignment: Alignment.centerLeft,
              child: RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 20 * scaleFactor,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: 'And hence..',
                      style: TextStyle(
                        fontSize: 18 * scaleFactor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 5),
            //  And hence.. STATEMENT
            Align(
              alignment: Alignment.centerLeft,
              child: RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 20 * scaleFactor,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text:
                          "Given the experimental and unpredictable nature of LichenCare, content provided and our policies will change from time to time. Additionally, since we do not collect or require login information, we will also not be able to trace you back from any collected data. However, we will try our best to accommodate your requests to delete data that you request, but we must emphasize to you upfront that it may be almost impossible to achieve given that data is pseudonymized and anonymized in a one directional manner. LichenCare may revise and update this Privacy Policy at any time. Your continued usage of the LichenCare will mean you accept those changes.",
                      style: TextStyle(
                        fontSize: 18 * scaleFactor,
                      ),
                    ),
                    TextSpan(text: '\n'),
                    TextSpan(text: '\n'),
                    TextSpan(
                      text:
                          "If you have any questions or concerns about this Privacy Policy or your data within LichenCare, please contact us at bsitcapstoneproject143@gmail.com. If you are unable to accept these terms, please stop using our services.",
                      style: TextStyle(
                        fontSize: 18 * scaleFactor,
                      ),
                    ),
                    TextSpan(text: '\n'),
                    TextSpan(text: '\n'),
                    TextSpan(
                      text: "Last updated: 17 November 2023. \n",
                      style: TextStyle(
                        fontSize: 18 * scaleFactor,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            (onBoot) ? Row(
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
                            .pushReplacementNamed('/home');
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
            ) : const SizedBox(),
            SizedBox(height: 15),
          ],
        ),
      ),

      // Floating action button
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: (!onBoot)? _lichenCheckBtn(context):null,

      // Bottom navigation bar
      bottomNavigationBar: (!onBoot)? _bottomNavBar(context) : null,
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
