// ignore_for_file: use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

Color primaryforegroundColor = const Color(0xFFFF7F50);

class _AccountState extends State<Account> {
  int _currentIndex = 4;
  bool _isLoading = false;
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
          padding: EdgeInsets.only(
            top: h * 0.04,
            right: w * 0.45,
          ),
          child: SvgPicture.asset(
            'assets/svgs/profileSection/profileAppBars/account(copy).svg',
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
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder<Map<String, String>>(
            future: getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator(
                  color: primaryforegroundColor,
                );
              } else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              } else {
                Map<String, String> userData = snapshot.data ?? {};

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            // Fetch the current user data
                            Map<String, String> userData = await getUserData();
                            _isLoading = false;
                            // Show a dialog to edit the first name and last name
                            await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                String newFirstName =
                                    userData['firstName'] ?? '';
                                String newLastName = userData['lastName'] ?? '';

                                return StatefulBuilder(builder: ((context, setState) {
                                      return AlertDialog(
                                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
                                      title: const Text('Edit Profile'),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextFormField(
                                            initialValue: newFirstName,
                                            onChanged: (value) {
                                              newFirstName = value;
                                            },
                                            decoration: InputDecoration(
                                              labelText: 'First Name',
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: const BorderSide(
                                                  color: Color(0xFFFF7F50),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          TextFormField(
                                            initialValue: newLastName,
                                            onChanged: (value) {
                                              newLastName = value;
                                            },
                                            decoration: InputDecoration(
                                              labelText: 'Last Name',
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: const BorderSide(
                                                  color: Color(0xFFFF7F50),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      actions: [
                                         SizedBox(
                                          height: 40,
                                          width: 80,
                                           child: ElevatedButton(
                                            onPressed: () async {
                                              if(_isLoading){
                                                return;
                                              }
                                              try {
                                                // Close the dialog and update the profile
                                                setState(() {
                                                  _isLoading = true;
                                                });
                                         
                                                await updateProfile(
                                                    newFirstName, newLastName);
                                         
                                                // Reset loading state
                                                setState(() {
                                                  _isLoading = false;
                                                });
                                              } catch (e) {
                                                // Handle errors if needed
                                                debugPrint(
                                                    'Error updating profile: $e');
                                                setState(() {
                                                  _isLoading = false;
                                                });
                                                Navigator.of(context).pop();
                                              }
                                            },
                                            style: ButtonStyle(
                                              padding: MaterialStateProperty.all<
                                                  EdgeInsets>(
                                                const EdgeInsets.symmetric(
                                                    horizontal: 20, vertical: 10),
                                              ),
                                              backgroundColor:
                                                  MaterialStateProperty.all<Color>(
                                                      primaryforegroundColor),
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10.0),
                                                  side: const BorderSide(
                                                      color: Colors.white,
                                                      width: 2.0),
                                                ),
                                              ),
                                            ),
                                            child: (_isLoading) ? const FittedBox(child:   SpinKitRing(color: Colors.white, size: 20, lineWidth: 2.0,) ,): const Text(
                                                    'Save',
                                                  ),
                                                                                 ),
                                         ),
                                      ],
                                    );
                                }));
                              },
                            );
                          },
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                primaryforegroundColor),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: const BorderSide(
                                    color: Colors.white, width: 2.0),
                              ),
                            ),
                          ),
                          child: const Text("Edit Profile"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _showDeleteAccConfirmationDialog();
                          },
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                            ),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.red),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: const BorderSide(
                                    color: Colors.white, width: 2.0),
                              ),
                            ),
                          ),
                          child: const Text("Delete Account"),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // First Name
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        "First Name: ${userData['firstName']}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Last Name
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        "Last Name: ${userData['lastName']}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Email
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        "Email: ${userData['email']}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                );
              }
            },
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
        backgroundColor: const Color(0xFFFFF4E9),
        onPressed: () {},
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
      ),
    );
  }

  BottomNavigationBar _bottomNavBar(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: const Color(0xFF66D7D1),
      selectedItemColor: Colors.white,
      unselectedItemColor: const Color.fromARGB(94, 0, 0, 0),
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
        const BottomNavigationBarItem(
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
        debugPrint("Error fetching user data: $e");
      }
    }

    return {
      'firstName': '',
      'lastName': '',
      'email': '',
    };
  }

  void _showDeleteAccConfirmationDialog() {
    String password = ''; // State to store the entered password
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            "Delete Account",
            style: TextStyle(
              fontSize: 20,
              color: Colors.red,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Are you sure you want to delete your account?",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                "THIS ACTION IS IRREVERSIBLE!",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                onChanged: (value) {
                  password = value;
                },
                obscureText: true, // Hide the entered text for security
                decoration: InputDecoration(
                  labelText: 'Enter your password',
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Color(0xFFFF7F50),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                      DeleteAccount(password);
                    },
                    child: const Text(
                      "Delete",
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> updateProfile(String firstName, String lastName) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        final userDocRef =
            FirebaseFirestore.instance.collection('users').doc(user.uid);

        await userDocRef.update({
          'first_name': firstName,
          'last_name': lastName,
        });

        // Update display name
        await user.updateDisplayName('$firstName $lastName');

        // Update the posts
        final postsCollectionName = 'LichenHub_posts';
        final postsCollection = userDocRef.collection(postsCollectionName);
        final userPostsSnapshot = await postsCollection
            .orderBy('date_uploaded', descending: true)
            .get();

        for (var doc in userPostsSnapshot.docs) {
          await doc.reference.update({
            'uploader_name': firstName,
          });
        }

        debugPrint('Profile updated successfully');
      } catch (e) {
        debugPrint('Error updating profile: $e');
      }

      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.topSlide,
        title: 'Profile updated.',
        desc: "Profile details successfully changed! 🤗",
        descTextStyle: const TextStyle(
          fontSize: 16.0,
        ),
        padding: const EdgeInsets.all(16.0),
        btnOkOnPress: () {
          Navigator.of(context).pop();
          ;
        },
      ).show();
    }
  }

  // Function to DELETE the user's acc
  Future<void> DeleteAccount(String password) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      // User not signed in
      return;
    }

    try {
      // Create credentials with the entered password
      AuthCredential credential = EmailAuthProvider.credential(
        email: user.email!,
        password: password,
      );

      // User reauthenticate for sure deletion
      await user.reauthenticateWithCredential(credential);
      await user.delete();

      final userDocRef =
          FirebaseFirestore.instance.collection('users').doc(user.uid);

      // Delete the specific document in Firestore
      await userDocRef.delete();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('loginEmail');

      // Delete user's folder in Firebase Storage - TO FIX
      // final storageRef = FirebaseStorage.instance
      //     .ref()
      //     .child('lichencheck_images/${user.uid}');

      // await storageRef.delete();

      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.topSlide,
        title: 'Account deleted.',
        desc:
            "Thank you for your using our App! Hopefully you'll come back soon! 🤗",
        descTextStyle: const TextStyle(
          fontSize: 16.0,
        ),
        padding: const EdgeInsets.all(16.0),
        btnOkOnPress: () {
          Navigator.of(context).pushNamed('/login');
          ; // Navigate to the login page
        },
      ).show();

      debugPrint("Account deleted successfully");
    } catch (e) {
      debugPrint("Error during reauthentication or account deletion: $e");
    }
  }
}
