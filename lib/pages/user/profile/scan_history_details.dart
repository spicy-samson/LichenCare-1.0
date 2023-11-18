import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:lichen_care/pages/user/profile/scan_history.dart'
    as ScanHistoryPage;

class ScanHistoryDetails extends StatelessWidget {
  final ScanHistoryPage.LichenCheckEntry? lichenCheckEntry;

  ScanHistoryDetails({Key? key, this.lichenCheckEntry}) : super(key: key);

  int _currentIndex = 4;

  String selectedOption = 'All';
  // Default selected option
  bool showDropdown = false;

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
          padding:
              EdgeInsets.only(top: h * 0.04, right: w * 0.35, left: w * 0.005),
          child: SvgPicture.asset(
            'assets/svgs/profileSection/profileAppBars/scan_history(copy).svg',
            width: w * 0.1,
            height: h * 0.8,
          ),
        ),
        elevation: 0,
        toolbarHeight: 80.0,
      ),

      // Body
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                image: DecorationImage(
                  alignment: Alignment.center,
                  image: NetworkImage(
                      "${lichenCheckEntry?.results['file_image']}"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Padding(
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
                    "${lichenCheckEntry?.results['detection_score'] ?? 'N/A'}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 3, horizontal: 6),
              child: Text(
                "${lichenCheckEntry?.results['detection'] ?? 'NO DETECTIONS'}",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                  color: Color.fromARGB(255, 126, 64, 7),
                ),
              ),
            ),
            // Additional information about the detection
            if (lichenCheckEntry?.results['detection'] != null)
              Padding(
                padding: EdgeInsets.only(left: w * 0.08),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        "Detection Details:",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Age: ${lichenCheckEntry?.additionalInfo['age']}",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      Text("Sex: ${lichenCheckEntry?.additionalInfo['gender']}",
                          style: TextStyle(
                            fontSize: 15,
                          )),
                      Text(
                          "Country: ${lichenCheckEntry?.additionalInfo['country']}",
                          style: TextStyle(
                            fontSize: 15,
                          )),
                      Text(
                          "Ethnicity: ${lichenCheckEntry?.additionalInfo['ethnicity']}",
                          style: TextStyle(
                            fontSize: 15,
                          )),
                      SizedBox(height: 10),
                      Text(
                        "When did the onset began?",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        " -> ${lichenCheckEntry?.symptoms['onset']}",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Severity of Itching",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        " -> ${lichenCheckEntry?.symptoms['itching']}",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Severity of Pain",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        " -> ${lichenCheckEntry?.symptoms['pain']}",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            SizedBox(height: w * 0.08),

            //Back and Delete buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.symmetric(
                          horizontal: 20, vertical: 22 * scaleFactor),
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
                    'Back',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                //DELETE BUTTON w/ FUNCTION
                ElevatedButton(
                  onPressed: () async {
                    bool confirmDelete = await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Confirm Deletion'),
                          content: Text(
                              'Are you sure you want to delete this document?'),
                          actionsPadding: EdgeInsets.zero,
                          actions: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(false); // Return false if canceled
                                  },
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                      color: Colors
                                          .black, // Change text color to orange
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(true); // Return true if confirmed
                                  },
                                  child: Text(
                                    'Delete',
                                    style: TextStyle(
                                      color: Colors
                                          .red, // Change text color to orange
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    );

                    if (confirmDelete ?? false) {
                      try {
                        User? user = FirebaseAuth.instance.currentUser;

                        if (user != null && lichenCheckEntry != null) {
                          final userDocRef = FirebaseFirestore.instance
                              .collection('users')
                              .doc(user.uid);
                          final lichenCheckDocRef = userDocRef
                              .collection('LichenCheck_inputs')
                              .doc('${lichenCheckEntry!.documentId}');

                          // Get the image URL from the lichenCheckEntry
                          String? imageUrl =
                              lichenCheckEntry!.results['file_image'];

                          // Delete document from Cloud Firestore
                          await lichenCheckDocRef.delete();

                          // Delete image from Firebase Storage if URL exists
                          if (imageUrl != null && imageUrl.isNotEmpty) {
                            // Get a reference to the image in Firebase Storage
                            Reference imageRef =
                                FirebaseStorage.instance.refFromURL(imageUrl);

                            // Delete the image
                            await imageRef.delete();
                          }

                          // Document and image deleted successfully, now navigate to the updated page
                          Navigator.of(context)
                              .pushNamed('/profile/scan_history');
                        }
                      } catch (e) {
                        print('Error deleting document and/or image: $e');
                      }
                    }
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.symmetric(
                          horizontal: 20, vertical: 22 * scaleFactor),
                    ),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
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
                    'Delete',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),

            SizedBox(
              height: h * 0.05,
            )
          ],
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

class LichenCheckEntry {
  final Map<String, dynamic> additionalInfo;
  final Map<String, dynamic> results;
  final Map<String, dynamic> symptoms;

  LichenCheckEntry({
    required this.additionalInfo,
    required this.results,
    required this.symptoms,
  });
}

Color primaryforegroundColor = const Color(0xFFFF7F50);
