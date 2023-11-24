import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image/image.dart' as img;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lichen_care/processes/classifier.dart';
import 'package:lichen_care/processes/recognitions.dart';

class LichenCheck extends StatefulWidget {
  LichenCheck({super.key});

  @override
  State<LichenCheck> createState() => _LichenCheckState();
}

class _LichenCheckState extends State<LichenCheck> {
  final _currentIndex = 2;
  bool navigatorHidden = false;

  List<String> ethnicities = [
    "African",
    "Asian (Central)",
    "Asian (East)",
    "Asian (South)",
    "Asian (South East)",
    "Asian (Others)",
    "Caucasian (South Europe)",
    "Caucasian (West Europe)",
    "Caucasian (Others)",
    "Hispanic",
    "Indigenous People",
    "Jewish (European)",
    "Middle Eastern",
    "Mixed Race",
    "Native American",
    "Pacific Islander",
    "Others"
  ];

  PatientInformation patientInformation = PatientInformation();
  bool disclaimerClosed = false;
  bool hasImage = false;
  bool sourceSelected = false;
  bool formCompleted = false;
  bool isPredicting = false;
  bool pushingData = false;
  int currentPIPage = 0;
  Classifier? classifier;

  Color primaryBackgroundColor = const Color(0xFFFFF4E9);
  Color primaryforegroundColor = const Color(0xFFFF7F50);
  Color secondaryForegroundColor = const Color(0xFF66D7D1);
  Color errorColor = Colors.red;

  FirebaseAuth auth = FirebaseAuth.instance;
  final storage = FirebaseStorage.instance;

  Future<void> pushPatientEntry() async {
    final user = auth.currentUser;

    if (user == null) {
      return; // No user is logged in, exit the function
    }

    try {
      final userDocRef =
          FirebaseFirestore.instance.collection('users').doc(user.uid);
      final userSnapshot = await userDocRef.get();

      if (userSnapshot.exists) {
        final inputsCollection = userDocRef.collection('LichenCheck_inputs');
        final storageRef = storage
            .ref()
            .child('lichencheck_images/${user.uid}/${DateTime.now()}.jpg');

        if (patientInformation.image != null) {
          final uploadTask =
              await storageRef.putFile(patientInformation.image!);

          if (uploadTask.state == TaskState.success) {
            final imageUrl = await uploadTask.ref.getDownloadURL();

            final timestamp = Timestamp.now(); // Get the current timestamp

            final newInputDocRef = await inputsCollection.add({
              'additional_info': {
                'age': patientInformation.age,
                'country': patientInformation.selectedCountry,
                'ethnicity': patientInformation.selectedEthnicity,
                'gender': getGenderString(patientInformation.gender),
              },
              'symptoms': {
                'itching': getSeverityofItchString(patientInformation.itching),
                'onset': getOnsetString(patientInformation.onset),
                'pain': getSeverityofPainString(patientInformation.pain),
              },
              'results': {
                'detection': patientInformation.detection,
                'detection_score': patientInformation.detectionScore,
                'file_image': imageUrl, // Store the image URL
                'date_uploaded': timestamp, // Add the date uploaded field
              },
            });
          } else {
            print('Error uploading the image to Firebase Storage');
          }
        } else {
          print('patientInformation.image is null');
        }
      } else {
        print('User document does not exist in Firestore');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void reset() {
    sourceSelected = false;
    hasImage = false;
    formCompleted = false;
    currentPIPage = 0;
    patientInformation.reset();
  }

  @override
  void initState() {
    loadDisclaimerStatus();
    classifier = Classifier();
    super.initState();
  }

  Future<void> loadDisclaimerStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    FirebaseAuth auth = FirebaseAuth.instance;

    // Get the current user UID
    User? user = auth.currentUser;
    if (user != null) {
      var userUid = user.uid;

      // Use the UID as a key to load the disclaimer status
      setState(() {
        disclaimerClosed = prefs.getBool('disclaimerClosed_$userUid') ?? false;
      });
    }
  }

  Future<void> saveDisclaimerStatus(bool closed) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    FirebaseAuth auth = FirebaseAuth.instance;

    // Get the current user UID
    User? user = auth.currentUser;

    if (user != null) {
      var userUid = user.uid;

      // Save the disclaimer status using the UID as a key
      await prefs.setBool('disclaimerClosed_$userUid', closed);
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    double scaleFactor = h / 1080;

    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Color(0xFFFFF4E9),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Color(0xFFFFF4E9),
            title: Padding(
              padding: EdgeInsets.only(top: h * 0.02, right: w * 0.42),
              child: SvgPicture.asset(
                'assets/svgs/#1 - lichencheck.svg',
                width: w * 0.1,
                height: h * 0.06,
              ),
            ),
            elevation: 0,
            toolbarHeight: 60.0,
          ),

          // Body
          body: (!sourceSelected)
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Center(
                      child: Text("Select Image Source",
                          style: TextStyle(fontSize: 16.0)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 15.0),
                      child: SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shadowColor: Colors.transparent,
                                foregroundColor: primaryforegroundColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30.0)),
                                    side: BorderSide(
                                        width: 2.0,
                                        color: primaryforegroundColor)),
                                backgroundColor: primaryBackgroundColor,
                              ),
                              onPressed: () {
                                setState(() {
                                  sourceSelected = true;
                                });
                                pickImage(ImageSource.camera);
                              },
                              child: Text(
                                "Use Camera",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: primaryforegroundColor,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.5),
                              ))),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 0.0),
                      child: SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shadowColor: Colors.transparent,
                                foregroundColor: primaryforegroundColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30.0)),
                                    side: BorderSide(
                                        width: 2.0,
                                        color: primaryforegroundColor)),
                                backgroundColor: primaryBackgroundColor,
                              ),
                              onPressed: () {
                                setState(() {
                                  sourceSelected = true;
                                });
                                pickImage(ImageSource.gallery);
                              },
                              child: Text(
                                "Browse Gallery",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: primaryforegroundColor,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.5),
                              ))),
                    ),
                  ],
                )
              : (hasImage)
                  ? (formCompleted)
                      ? (pushingData)
                          ? const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SpinKitThreeBounce(
                                  color: Color(0XFFF0784C),
                                  size: 60.0,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text("Saving your entries...")
                              ],
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30.0),
                              child: Listener(
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
                                      const SizedBox(
                                        height: 20.0,
                                      ),
                                      result(context),
                                      const SizedBox(
                                        height: 30.0,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 0.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pushReplacementNamed(
                                                        '/home'); //
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      15.0))),
                                                  backgroundColor:
                                                      primaryforegroundColor),
                                              child: const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 0.0,
                                                    vertical: 10.0),
                                                child: Text(
                                                  "Back to Home",
                                                  style:
                                                      TextStyle(fontSize: 16.0),
                                                ),
                                              ),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                setState(() {
                                                  reset();
                                                });
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      15.0))),
                                                  backgroundColor:
                                                      primaryforegroundColor),
                                              child: const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10.0,
                                                    vertical: 10.0),
                                                child: Text(
                                                  "Scan Again",
                                                  style:
                                                      TextStyle(fontSize: 16.0),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 45.0,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                      : Column(
                          children: [
                            const SizedBox(
                              height: 20.0,
                            ),
                            const Center(
                              child: Text(
                                "Patient Information",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 24,
                                    letterSpacing: 1.2),
                              ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Expanded(
                                child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30.0),
                              child: patientInformationForm(context),
                            )),
                          ],
                        )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SpinKitThreeBounce(
                          color: Color(0XFFF0784C),
                          size: 60.0,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text((isPredicting)
                            ? "Detecting Lichen Planus..."
                            : "Please Wait...")
                      ],
                    ),
          // Floating action button
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: (navigatorHidden)? null: _lichenCheckBtn(context),
          // Bottom navigation bar
          bottomNavigationBar: (navigatorHidden)? null: _bottomNavBar(context),
        ),
        (disclaimerClosed)
            ? const SizedBox()
            : Container(
                color: Colors.black54,
              ),
        (disclaimerClosed)
            ? const SizedBox()
            : Padding(
                padding: EdgeInsets.only(
                    left: 20.0 * scaleFactor,
                    right: 20.0 * scaleFactor,
                    top: 130.0 * scaleFactor,
                    bottom: 120.0 * scaleFactor),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                      color: Color(0xFFFFF4E9),
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25.0, vertical: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 23 * (scaleFactor),
                                    fontWeight: FontWeight.bold),
                                children: const <TextSpan>[
                                  TextSpan(
                                      text: 'DISCLAIMER IN USING LICHENCHECK'),
                                ])),
                        SizedBox(
                          height: 25 * scaleFactor,
                        ),
                        SizedBox(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20 * scaleFactor,
                                            fontStyle: FontStyle.italic),
                                        children: const <TextSpan>[
                                          TextSpan(text: "Dear Users,"),
                                        ])),
                                SizedBox(
                                  height: 15 * scaleFactor,
                                ),
                                RichText(
                                    textAlign: TextAlign.justify,
                                    text: TextSpan(
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20 * scaleFactor,
                                            height: 1.5),
                                        children: const [
                                          WidgetSpan(
                                              child: SizedBox(
                                            width: 25,
                                          )),
                                          TextSpan(
                                              text:
                                                  "LichenCheck feature provides broad classifications of Cutaneous Lichen Planus (annular, hypertrophic, linear) for educational purposes only. It does not replace professional medical advice; consult a healthcare professional for accurate diagnosis."),
                                          TextSpan(
                                              text: " Lichen",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0XFF15D6b4))),
                                          TextSpan(
                                              text: "Care",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0XFFF0784C))),
                                          TextSpan(
                                              text:
                                                  " is a supportive tool, and not a substitute for expert judgment. Users are responsible for interpreting results and acknowledging technology limitations. False positives or negatives may occur. Use at your own risk. "),
                                          TextSpan(
                                              text: "Lichen",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0XFF15D6b4))),
                                          TextSpan(
                                              text: "Care",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0XFFF0784C))),
                                          TextSpan(
                                              text:
                                                  " disclaims any liability for actions based on app information. By proceeding, you agree to these terms. For comprehensive skin health assessments, consult a healthcare professional."),
                                        ])),
                                SizedBox(height: 25 * scaleFactor),
                                RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20 * scaleFactor,
                                        ),
                                        children: const <TextSpan>[
                                          TextSpan(
                                              text: "Thank you for choosing "),
                                          TextSpan(
                                              text: "Lichen",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0XFF15D6b4))),
                                          TextSpan(
                                              text: "Care",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0XFFF0784C))),
                                          TextSpan(text: "!")
                                        ])),
                              ],
                            )),
                        const Spacer(),
                        SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 13.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(
                                        context, '/home');
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30.0, vertical: 10.0),
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15.0))),
                                    backgroundColor:
                                        const Color.fromARGB(255, 255, 127, 80),
                                  ),
                                  child: const Text(
                                    "Cancel",
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    await saveDisclaimerStatus(true);
                                    loadDisclaimerStatus(); // Add this line
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 10.0),
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15.0))),
                                    backgroundColor:
                                        const Color.fromARGB(255, 255, 127, 80),
                                  ),
                                  child: const Text(
                                    "Continue",
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  // result widget
  Widget result(BuildContext context) {
    if (patientInformation.detection != null) {
      return Column(
        children: [
          Center(
            child: Text(
              "DETECTIONS",
              style: TextStyle(
                  color: const Color.fromARGB(255, 82, 19, 19),
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                  letterSpacing: 5.0),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Container(
            width: 220,
            height: 220,
            decoration: BoxDecoration(
                image: DecorationImage(
                    alignment: Alignment.center,
                    image: FileImage(patientInformation.image!),
                    fit: BoxFit.fill)),
          ),
          Center(
              child: Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Confidence Score:",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  width: 5.0,
                ),
                Text(
                  "${patientInformation.detectionScore!}%",
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87),
                ),
              ],
            ),
          )),
          Center(
              child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              patientInformation.detection!,
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  color: Color.fromARGB(255, 126, 64, 7)),
            ),
          )),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Text(
                "DESCRIPTION",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Center(
            child: RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      height: 2,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: patientInformation
                              .resultsDescription!.description),
                    ])),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 40.0, bottom: 10.0),
              child: Text(
                "SYMPTOMS",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Center(
            child: RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      height: 2,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: patientInformation
                              .resultsDescription!.symptoms.header),
                    ])),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Column(
              children: List<Widget>.generate(
                  patientInformation.resultsDescription!.symptoms.features
                      .length, (int index) {
                final features =
                    patientInformation.resultsDescription!.symptoms.features;
                return Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 5.0),
                        child: Text(
                          features.keys.elementAt(index),
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    RichText(
                        textAlign: TextAlign.justify,
                        text: TextSpan(
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              height: 2,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: features.values.elementAt(index),
                              ),
                            ])),
                  ],
                );
              }),
            ),
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 40.0, bottom: 10.0),
              child: Text(
                "TREATMENTS",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Center(
            child: RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      height: 2,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: patientInformation
                              .resultsDescription!.treatments.header),
                    ])),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Column(
              children: List<Widget>.generate(
                  patientInformation.resultsDescription!.treatments.suggestions
                      .length, (int index) {
                final suggestions = patientInformation
                    .resultsDescription!.treatments.suggestions;
                return Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 5.0),
                        child: Text(
                          suggestions.keys.elementAt(index),
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    RichText(
                        textAlign: TextAlign.justify,
                        text: TextSpan(
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              height: 2,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: suggestions.values.elementAt(index),
                              ),
                            ])),
                  ],
                );
              }),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Center(
            child: RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                      height: 2.0,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: patientInformation.resultsDescription!.footer),
                    ])),
          )
        ],
      );
    } else {
      return Column(
        children: [
          Center(
            child: Text(
              "RESULTS",
              style: TextStyle(
                  color: Colors.red.shade900,
                  fontWeight: FontWeight.w500,
                  fontSize: 24,
                  letterSpacing: 10.0),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: SvgPicture.asset(
              'assets/svgs/nodetections_image.svg',
              width: 200,
              height: 200,
            ),
          ),
          Center(
            child: Text(
              "LICHEN PLANUS NOT DETECTED",
              style: TextStyle(fontSize: 22),
            ),
          )
        ],
      );
    }
  }

  // widget selector (page)
  Widget patientInformationForm(BuildContext context) {
    double scaleFactor = MediaQuery.of(context).size.height / 1080;
    List<String> onsets = [
      "within a week",
      "within a month",
      "within a year",
      "over a year/congenital"
    ];
    List<String> severity = ["none", "mild/moderate", "severe"];
    switch (currentPIPage) {
      case 0:
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            "Please tell us a bit about yourself.",
            style: TextStyle(fontSize: 14.0),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15.0 * scaleFactor, bottom: 10),
            child: const Text(
              "Sex",
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 15.0, vertical: 10.0 * scaleFactor),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      patientInformation.gender = 1;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(
                          side: BorderSide(width: 1.5, color: Colors.black54)),
                      backgroundColor: (patientInformation.gender == 1)
                          ? primaryforegroundColor
                          : primaryBackgroundColor),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.male,
                      size: 80,
                      color: (patientInformation.gender == 1)
                          ? Colors.white
                          : Colors.black87,
                    ),
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      patientInformation.gender = 2;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(
                          side: BorderSide(width: 1.5, color: Colors.black54)),
                      backgroundColor: (patientInformation.gender == 2)
                          ? primaryforegroundColor
                          : primaryBackgroundColor),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.female,
                      size: 80,
                      color: (patientInformation.gender == 2)
                          ? Colors.white
                          : Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0 * scaleFactor, bottom: 0),
            child: const Text(
              "Age",
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          TextFormField(
            onChanged: (value) => setState(() {
              patientInformation.age = int.parse(value);
            }),
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
                hintText: "Enter your age", border: InputBorder.none),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0 * scaleFactor, bottom: 0),
            child: const Text(
              "Country",
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          SizedBox(
              width: double.infinity,
              child: TextButton(
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  onPressed: () {
                    showCountryPicker(
                        context: context,
                        countryListTheme: const CountryListThemeData(
                            inputDecoration: InputDecoration(
                                labelText: 'Search Country/Region',
                                hintText: 'Enter a country/region name',
                                prefixIcon: Icon(Icons.search),
                                border: UnderlineInputBorder())),
                        onSelect: (Country country) {
                          setState(() {
                            patientInformation.selectedCountry = country.name;
                          });
                        });
                  },
                  child: Row(
                    children: [
                      Text(
                        (patientInformation.selectedCountry == null)
                            ? "Select"
                            : patientInformation.selectedCountry!,
                        style: TextStyle(
                            color: (patientInformation.selectedCountry == null)
                                ? Colors.black54
                                : Colors.black87,
                            fontSize: 16.0),
                      ),
                    ],
                  ))),
          Padding(
            padding: EdgeInsets.only(top: 10.0 * scaleFactor, bottom: 0),
            child: const Text(
              "Ethnicity",
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          SizedBox(
              width: double.infinity,
              child: TextButton(
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        clipBehavior: Clip.antiAlias,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30.0),
                                topRight: Radius.circular(30.0))),
                        builder: (BuildContext context) {
                          return Container(
                            height: MediaQuery.of(context).size.height * 0.95,
                            child: Column(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                        color: secondaryForegroundColor),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Center(
                                          child: Text("Select your Ethnicity",
                                              style:
                                                  TextStyle(fontSize: 18.0))),
                                    ),
                                  ),
                                ),
                                Expanded(
                                    child: ListView.builder(
                                        itemCount: ethnicities.length,
                                        itemBuilder: (context, index) {
                                          return SizedBox(
                                            width: double.infinity,
                                            child: TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    patientInformation
                                                            .selectedEthnicity =
                                                        ethnicities[index];
                                                    Navigator.of(context).pop();
                                                  });
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 15.0),
                                                  child: Row(
                                                    children: [
                                                      Text(ethnicities[index],
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .black87,
                                                                  fontSize:
                                                                      16.0)),
                                                    ],
                                                  ),
                                                )),
                                          );
                                        }))
                              ],
                            ),
                          );
                        });
                  },
                  child: Row(
                    children: [
                      Text(
                        (patientInformation.selectedEthnicity == null)
                            ? "Select"
                            : patientInformation.selectedEthnicity!,
                        style: TextStyle(
                            color:
                                (patientInformation.selectedEthnicity == null)
                                    ? Colors.black54
                                    : Colors.black87,
                            fontSize: 16.0),
                      ),
                    ],
                  ))),
          const Spacer(),
          Center(
              child: ElevatedButton(
            onPressed: () {
              if (patientInformation.checkPageisComplete(currentPIPage)) {
                setState(() {
                  currentPIPage += 1;
                });
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      duration: Duration(milliseconds: 1000),
                      backgroundColor: errorColor,
                      content: Text('Please fill up all fields.')),
                );
              }
            },
            style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                backgroundColor:
                    (patientInformation.checkPageisComplete(currentPIPage))
                        ? primaryforegroundColor
                        : Colors.grey),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Text(
                "Next",
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          )),
          const SizedBox(
            height: 45.0,
          ),
        ]);
      case 1:
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            "When did the onset began?",
            style: TextStyle(fontSize: 18.0),
          ),
          Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.only(top: 20.0),
                itemCount: onsets.length,
                itemBuilder: (context, int index) {
                  return SizedBox(
                      width: double.infinity,
                      height: 60.0,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shadowColor: Colors.transparent,
                              backgroundColor:
                                  (patientInformation.onset == index + 1)
                                      ? primaryforegroundColor
                                      : primaryBackgroundColor,
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 1.2,
                                      color: primaryforegroundColor),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20.0)))),
                          onPressed: () {
                            setState(() {
                              patientInformation.onset = index + 1;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(
                                  onsets[index],
                                  style: TextStyle(
                                      color: (patientInformation.onset ==
                                              index + 1)
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 18.0),
                                )
                              ],
                            ),
                          ),
                        ),
                      ));
                }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      currentPIPage -= 1;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.0))),
                      backgroundColor: primaryforegroundColor),
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    child: Text(
                      "Previous",
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (patientInformation.checkPageisComplete(currentPIPage)) {
                      setState(() {
                        currentPIPage += 1;
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            duration: Duration(milliseconds: 1000),
                            backgroundColor: errorColor,
                            content: Text('Please fill up all fields.')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.0))),
                      backgroundColor: (patientInformation
                              .checkPageisComplete(currentPIPage))
                          ? primaryforegroundColor
                          : Colors.grey),
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                    child: Text(
                      "Next",
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 45.0,
          ),
        ]);
      case 2:
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            "Severity of Itching",
            style: TextStyle(fontSize: 18.0),
          ),
          Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.only(top: 20.0),
                itemCount: severity.length,
                itemBuilder: (context, int index) {
                  return SizedBox(
                      width: double.infinity,
                      height: 60.0,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shadowColor: Colors.transparent,
                              backgroundColor:
                                  (patientInformation.itching == index + 1)
                                      ? primaryforegroundColor
                                      : primaryBackgroundColor,
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 1.2,
                                      color: primaryforegroundColor),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20.0)))),
                          onPressed: () {
                            setState(() {
                              patientInformation.itching = index + 1;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(
                                  severity[index],
                                  style: TextStyle(
                                      color: (patientInformation.itching ==
                                              index + 1)
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 18.0),
                                )
                              ],
                            ),
                          ),
                        ),
                      ));
                }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      currentPIPage -= 1;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.0))),
                      backgroundColor: primaryforegroundColor),
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    child: Text(
                      "Previous",
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (patientInformation.checkPageisComplete(currentPIPage)) {
                      setState(() {
                        currentPIPage += 1;
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            duration: Duration(milliseconds: 1000),
                            backgroundColor: errorColor,
                            content: Text('Please fill up all fields.')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.0))),
                      backgroundColor: (patientInformation
                              .checkPageisComplete(currentPIPage))
                          ? primaryforegroundColor
                          : Colors.grey),
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                    child: Text(
                      "Next",
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 45.0,
          ),
        ]);
      case 3:
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            "Severity of Pain",
            style: TextStyle(fontSize: 18.0),
          ),
          Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.only(top: 20.0),
                itemCount: severity.length,
                itemBuilder: (context, int index) {
                  return SizedBox(
                      width: double.infinity,
                      height: 60.0,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shadowColor: Colors.transparent,
                              backgroundColor:
                                  (patientInformation.pain == index + 1)
                                      ? primaryforegroundColor
                                      : primaryBackgroundColor,
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 1.2,
                                      color: primaryforegroundColor),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20.0)))),
                          onPressed: () {
                            setState(() {
                              patientInformation.pain = index + 1;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(
                                  severity[index],
                                  style: TextStyle(
                                      color:
                                          (patientInformation.pain == index + 1)
                                              ? Colors.white
                                              : Colors.black,
                                      fontSize: 18.0),
                                )
                              ],
                            ),
                          ),
                        ),
                      ));
                }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      currentPIPage -= 1;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.0))),
                      backgroundColor: primaryforegroundColor),
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    child: Text(
                      "Previous",
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (patientInformation.checkPageisComplete(currentPIPage)) {
                      setState(() {
                        formCompleted = true;
                        pushingData = true;
                      });
                      await pushPatientEntry();
                      var data = await rootBundle.loadString(
                          "assets/jsons/results.json"); //latest Dart
                      setState(() {
                        if (patientInformation.detection != null) {
                          patientInformation.resultsDescription =
                              ResultsDescription(json.decode(data),
                                  lichenType: patientInformation.detection!);
                        }
                        pushingData = false;
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            duration: Duration(milliseconds: 1000),
                            backgroundColor: errorColor,
                            content: Text('Please fill up all fields.')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.0))),
                      backgroundColor: (patientInformation
                              .checkPageisComplete(currentPIPage))
                          ? primaryforegroundColor
                          : Colors.grey),
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                    child: Text(
                      "Done",
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 45.0,
          ),
        ]);
      default:
        setState(() {
          currentPIPage -= 1;
        });
        return patientInformationForm(context);
    }
  }

  // Input and processing
  Future classifyImage(File file) async {
    int threshold = 75;
    List<int> imageSize = [300, 400];
    var image = img.decodeImage(file.readAsBytesSync());
    // resize image add adjustmment filter for better prediction
    var reduced =
        img.adjustColor(image!, saturation: 2.0, contrast: 5.0, amount: 1.0);
    reduced = img.copyResize(reduced,
        width: imageSize[0],
        height: imageSize[1],
        interpolation: img.Interpolation.cubic); // resize

    // exit function if classifier object is not initialized
    classifier!.putImage(reduced);
    // 5707.89ms
    List<Recognition> recognitions = await classifier!.predict();
    // dispose image
    classifier!.disposeImage();
    if (recognitions.isNotEmpty) {
      double score = recognitions[0].score;
      var value = (score * 100);
      if (value >= threshold) {
        for (int i = 0; i < recognitions.length; i++) {
          List location = [
            (recognitions[i].location!.left * (image!.width / reduced.width))
                .round(),
            (recognitions[i].location!.top * (image.height / reduced.height))
                .round(),
            (recognitions[i].location!.right * (image.width / reduced.width))
                .round(),
            (recognitions[i].location!.bottom * (image.height / reduced.height))
                .round()
          ];
          // get rid of out of bounds vertex locations
          for (int j = 0; j < location.length; j++) {
            location[j] = location[j] < 0 ? 0 : location[j];
            location[j] = (j + 1) % 2 != 0 && location[j] > image.width
                ? image.width
                : location[j];
            location[j] = (j + 1) % 2 == 0 && location[j] > image.height
                ? image.height
                : location[j];
          }
          if (recognitions[i].label == recognitions[0].label &&
              recognitions[i].score > 0.3) {
            // Draw Rect
            image = img.drawRect(image, location[0], location[1], location[2],
                location[3], 0xFF0000FF);
            image = img.drawRect(image, location[0] + 2, location[1] + 2,
                location[2] - 2, location[3] - 2, 0xFF0000FF);
          }
        }
      }

      final jpg = img.encodeJpg(image!);
      File labeled = file.copySync("${file.path}(labeld).jpg");
      labeled.writeAsBytes(jpg);
      setState(() {
        patientInformation.image = labeled;
        if (value >= threshold) {
          patientInformation.detection = recognitions[0].label;
          patientInformation.detectionScore =
              value.toStringAsFixed(2).substring(0, 5);
          // _predictedLabel = recognitions[0].label;
        }
      });
    } else {
      setState(() {
        patientInformation.image = file;
      });
      print("No recognition");
    }
  }

  Future pickImage(ImageSource source) async {
    try {
      final take = await ImagePicker()
          .pickImage(source: source, maxHeight: 720, maxWidth: 480);
      if (take == null) {
        Navigator.of(context).pop();
        return;
      }
      File? image = File(take.path);
      image = await cropImage(imageFile: image);
      if (image == null) {
        Navigator.of(context).pop();
        return;
      }
      setState(() {
        isPredicting = true;
      });
      await Future.delayed(const Duration(seconds: 1));
      await Future.delayed(const Duration(seconds: 1));
      await classifyImage(image);
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        hasImage = true;
        isPredicting = false;
      });
    } on PlatformException catch (e) {
      print(e);
      Navigator.of(context).pop();
    }
  }

  Future<File?> cropImage({required File imageFile}) async {
    CroppedFile? croppedImage =
        await ImageCropper().cropImage(sourcePath: imageFile.path);
    if (croppedImage == null) return null;
    return File(croppedImage.path);
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
            // Navigator.of(context).pushNamed('/lichenCheck');
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

class PatientInformation {
  int age = 0;
  int gender = 0;
  int onset = 0;
  int itching = 0;
  int pain = 0;
  String? detectionScore;
  String? selectedCountry;
  String? selectedEthnicity;
  String? detection;
  File? image;
  ResultsDescription? resultsDescription;

  PatientInformation();

  void reset() {
    age = 0;
    gender = 0;
    onset = 0;
    itching = 0;
    pain = 0;
    image = null;
    resultsDescription = null;
    detection = null;
    detectionScore = null;
    selectedCountry = null;
    selectedEthnicity = null;
  }

  bool checkPageisComplete(page) {
    switch (page) {
      case 0:
        return (age != 0 &&
            gender != 0 &&
            selectedCountry != null &&
            selectedEthnicity != null);
      case 1:
        return (onset != 0);
      case 2:
        return (itching != 0);
      case 3:
        return (pain != 0);
      default:
        return false;
    }
  }
}

class ResultsDescription {
  final String lichenType;
  late String description;
  late Symptoms symptoms;
  late Treatments treatments;
  late String footer;
  ResultsDescription(row, {required this.lichenType}) {
    description = row[lichenType]['Description'];
    symptoms = Symptoms(
        header: row[lichenType]['Symptoms']['Header'],
        features: row[lichenType]['Symptoms']['Features']);
    treatments = Treatments(
        header: row[lichenType]['Treatments']['Header'],
        suggestions: row[lichenType]['Treatments']['Suggestions']);
    footer = row[lichenType]["Footer"];
  }
}

class Symptoms {
  String header;
  Map<String, dynamic> features;
  Symptoms({required this.header, required this.features});
}

class Treatments {
  String header;
  Map<String, dynamic> suggestions;
  Treatments({required this.header, required this.suggestions});
}

String getGenderString(int? gender) {
  if (gender == 1) {
    return 'Male';
  } else if (gender == 2) {
    return 'Female';
  } else {
    return 'Unknown';
  }
}

String getOnsetString(int? onset) {
  if (onset == 1) {
    return 'within a week';
  } else if (onset == 2) {
    return 'within a month';
  } else if (onset == 3) {
    return 'within a year';
  } else if (onset == 4) {
    return 'over a year/congenital';
  } else {
    return 'Unknown';
  }
}

String getSeverityofItchString(int? itch) {
  if (itch == 1) {
    return 'none';
  } else if (itch == 2) {
    return 'mild/moderate';
  } else if (itch == 3) {
    return 'severe';
  } else {
    return 'Unknown';
  }
}

String getSeverityofPainString(int? pain) {
  if (pain == 1) {
    return 'none';
  } else if (pain == 2) {
    return 'mild/moderate';
  } else if (pain == 3) {
    return 'severe';
  } else {
    return 'Unknown';
  }
}
