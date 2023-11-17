import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:lichen_care/pages/user/profile/scan_history_details.dart';

class ScanHistory extends StatefulWidget {
  @override
  _ScanHistory createState() => _ScanHistory();
}

class LichenCheckEntry {
  final Map<String, dynamic> additionalInfo;
  final Map<String, dynamic> results;
  final Map<String, dynamic> symptoms;
  final String documentId; // Include documentId

  LichenCheckEntry({
    required this.additionalInfo,
    required this.results,
    required this.symptoms,
    required this.documentId, // Include documentId
  });
}

Color primaryforegroundColor = const Color(0xFFFF7F50);

class _ScanHistory extends State<ScanHistory> {
  int _currentIndex = 4;
  String selectedOption = 'All'; // Default selected option
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
        child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
            child: FutureBuilder<Map<String, LichenCheckEntry>>(
              future: getLichenCheckEntries(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: primaryforegroundColor,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else {
                  Map<String, LichenCheckEntry> lichenCheckData =
                      snapshot.data ?? {};

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            DropdownButton<String>(
                              value: selectedOption,
                              icon: const Icon(Icons.arrow_downward),
                              iconSize: 20,
                              elevation: 16,
                              borderRadius: BorderRadius.circular(10),
                              focusColor: Colors.black,
                              style: TextStyle(
                                  color: primaryforegroundColor, fontSize: 15),
                              underline: Container(
                                height: 2,
                                color: primaryforegroundColor,
                              ),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedOption = newValue!;
                                });
                              },
                              items: <String>[
                                'All',
                                'Detections',
                                'No Detections'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: Text(
                          '$selectedOption',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),

                      // Sorting the Scan History; 'All' is the default
                      if (selectedOption == 'All')
                        Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8.0),
                              child: Text(
                                "${lichenCheckData.length} entries found.",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                            for (var entryKey in lichenCheckData.keys)
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ScanHistoryDetails(
                                        lichenCheckEntry:
                                            lichenCheckData[entryKey],
                                      ),
                                    ),
                                  );
                                },
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              "${lichenCheckData[entryKey]?.results['file_image']}",
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              FadeInImage(
                                            placeholder: AssetImage(
                                                'assets/imgs/placeholder-image.jpg'), // Your placeholder image asset
                                            image: NetworkImage(url),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        )

                      // Sorting; Detected,
                      else if (selectedOption == 'Detections')
                        Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8.0),
                              child: Text(
                                "${lichenCheckData.values.where((entry) => entry.results['detection'] != null).length} entries found.",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                            for (var entryKey in lichenCheckData.keys)
                              if (lichenCheckData[entryKey]
                                      ?.results['detection'] !=
                                  null)
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ScanHistoryDetails(
                                          lichenCheckEntry:
                                              lichenCheckData[entryKey],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                "${lichenCheckData[entryKey]?.results['file_image']}",
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                FadeInImage(
                                              placeholder: AssetImage(
                                                  'assets/imgs/placeholder-image.jpg'), // Your placeholder image asset
                                              image: NetworkImage(url),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                          ],
                        )

                      // Sorting; No Detections
                      else if (selectedOption == 'No Detections')
                        Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8.0),
                              child: Text(
                                "${lichenCheckData.values.where((entry) => entry.results['detection'] == null).length} entries found.",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                            for (var entryKey in lichenCheckData.keys)
                              if (lichenCheckData[entryKey]
                                      ?.results['detection'] ==
                                  null)
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ScanHistoryDetails(
                                          lichenCheckEntry:
                                              lichenCheckData[entryKey],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                "${lichenCheckData[entryKey]?.results['file_image']}",
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                FadeInImage(
                                              placeholder: AssetImage(
                                                  'assets/imgs/placeholder-image.jpg'), // Your placeholder image asset
                                              image: NetworkImage(url),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                          ],
                        )
                    ],
                  );
                }
              },
            )),
      ),

      // Floating action button
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _lichenCheckBtn(context),

      // Bottom navigation bar
      bottomNavigationBar: _bottomNavBar(context),
    );
  }

  Future<Map<String, LichenCheckEntry>> getLichenCheckEntries(
      {bool detections = true}) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return {};
    }

    try {
      final userDocRef =
          FirebaseFirestore.instance.collection('users').doc(user?.uid);
      final inputsCollection = userDocRef.collection('LichenCheck_inputs');

      QuerySnapshot querySnapshot;
      if (detections) {
        querySnapshot =
            await inputsCollection.where('results', isNull: false).get();
      } else {
        querySnapshot =
            await inputsCollection.where('results', isNull: true).get();
      }

      return Map.fromEntries(querySnapshot.docs.map((doc) {
        return MapEntry(
          doc.id,
          LichenCheckEntry(
            additionalInfo: doc['additional_info'] ?? {},
            results: doc['results'] ?? {},
            symptoms: doc['symptoms'] ?? {},
            documentId: doc.id, // Include the documentId
          ),
        );
      }));
    } catch (e) {
      print('Error fetching LichenCheck entries: $e');
      return {};
    }
  }

  Future<void> fetchData() async {
    Map<String, LichenCheckEntry> lichenCheckEntries =
        await getLichenCheckEntries(detections: true);

    // Accessing values in the map
    lichenCheckEntries.forEach((String docId, LichenCheckEntry entry) {
      print('Document ID: $docId');
      print('Additional Info: ${entry.additionalInfo}');
      print('Symptoms: ${entry.symptoms}');
      print('Results: ${entry.results}');
      print('------------------------');
    });
  }

  Future<Map<String, String>> getUserData() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (userSnapshot.exists) {
          String firstName = userSnapshot.get('first_name') ?? '';
          String lastName = userSnapshot.get('last_name') ?? '';
          String email = userSnapshot.get('email') ?? '';
          return {
            'firstName': firstName,
            'lastName': lastName,
            'email': email,
          };
        }
      } catch (e) {
        print("Error fetching user data: $e");
      }
    }

    return {
      'firstName': '',
      'lastName': '',
      'email': '',
    };
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
