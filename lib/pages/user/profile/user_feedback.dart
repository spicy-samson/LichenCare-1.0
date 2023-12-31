import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class UserFeedback extends StatefulWidget {
  @override
  _UserFeedbackState createState() => _UserFeedbackState();
}

Color primaryforegroundColor = const Color(0xFFFF7F50);

class _UserFeedbackState extends State<UserFeedback> {
  int _currentIndex = 4;
  double _rating = 0;
  TextEditingController _feedbackController = TextEditingController();
  bool _isSubmitting = false; // Add this variable to track submission status

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    double scaleFactor = h / 1080;

    return GestureDetector(
      onTap: () {
        // Dismiss the keyboard when user taps anywhere on the screen
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Color(0xFFFFF4E9),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xFFFFF4E9),
          title: Padding(
            padding: EdgeInsets.only(top: h * 0.02, right: w * 0.45),
            child: SvgPicture.asset(
              'assets/svgs/profileSection/profileAppBars/feedback(copy).svg',
              width: w * 0.1,
              height: h * 0.8,
            ),
          ),
          elevation: 0,
          toolbarHeight: 60.0,
        ),

        // Body
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Rate Your Experience',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Are you satisfied with the application?',
                style: TextStyle(fontSize: 15.0),
              ),
              SizedBox(height: 10.0),
              // 5 Stars Metric
              RatingBar.builder(
                initialRating: _rating,
                minRating: 0,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 40.0,
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: primaryforegroundColor,
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    _rating = rating;
                  });
                },
              ),
              Divider(),
              SizedBox(height: 20.0),
              Text(
                'Tell us what can be improved?',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              // Blank space text area

              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  controller:
                      _feedbackController, // Link the controller to the TextField
                  maxLines: 10,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Write your feedback here...',
                    hintStyle: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Send feedback to Firebase
                        submitFeedback();
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.symmetric(
                              horizontal: 20, vertical: 22 * scaleFactor),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFFFF7F50)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: const BorderSide(
                                color: Colors.white,
                                width: 2.0), // Add the white border here
                          ),
                        ),
                      ),
                      child: _isSubmitting
                          ? CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                              strokeWidth: 4.0,
                            ) // Show a circular progress indicator if submitting
                          : const Text(
                              'Submit',
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Floating action button
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: _lichenCheckBtn(context),

        // Bottom navigation bar
        bottomNavigationBar: _bottomNavBar(context),
      ),
    );
  }

  Future<void> submitFeedback() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return;
    }

    try {
      setState(() {
        _isSubmitting = true; // Set the flag to true when starting submission
      });

      final userDocRef =
          FirebaseFirestore.instance.collection('users').doc(user.uid);
      final userSnapshot = await userDocRef.get();

      if (userSnapshot.exists) {
        final feedbackCollection = userDocRef.collection('Feedback');
        await feedbackCollection.add({
          'rating': _rating,
          'feedback': _feedbackController.text,
          'timestamp': FieldValue.serverTimestamp(),
        });

        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.topSlide,
          title: 'Feedback submitted!',
          desc:
              "Thank you for your feedback! We'll surely do our best so that we can satisfy our users' needs! 🤗",
          descTextStyle: TextStyle(
            fontSize: 16.0,
          ),
          padding: EdgeInsets.all(16.0),
          btnOkOnPress: () {
            Navigator.of(context).pop();
            Navigator.of(context).pushNamedAndRemoveUntil('/profile',
                (Route<dynamic> route) => false); // Navigate to the login page
          },
        ).show();
        setState(() {
          _isSubmitting =
              false; // Set the flag to false after successful submission
        });
      }
    } catch (e) {
      debugPrint('Error submitting feedback: $e');
      setState(() {
        _isSubmitting = false; // Set the flag to false if an error occurs
      });
      // Handle error as needed
    }
  }

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
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
