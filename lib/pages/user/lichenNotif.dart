import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:lichen_care/pages/user/lichenHub.dart';

class LichenNotif extends StatefulWidget {
  @override
  _LichenNotifState createState() => _LichenNotifState();
}

class _LichenNotifState extends State<LichenNotif> {
  final int _currentIndex = 3;
  bool navigatorHidden = false;
  late User user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser!;
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    int newNotificationsCount = 0;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF4E9),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFFFFF4E9),
        title: Padding(
          padding: EdgeInsets.only(top: h * 0.02, right: w * 0.3),
          child: SvgPicture.asset(
            'assets/svgs/profileSection/notifications_with_icon.svg',
            width: w * 0.1,
            height: h * 0.047,
          ),
        ),
        elevation: 0,
        toolbarHeight: 60.0,
      ),

      // Body
      body: Listener(
        onPointerMove: (pointer) {
          // print(pointer.delta);
          if (pointer.delta.dy == 0) {
            return;
          }
          if (pointer.delta.dy < 0) {
            // scrolls down
            // setState(() {
            //   navigatorHidden = true;
            // });
          } else {
            // scrolls up
            // setState(() {
            //   navigatorHidden = false;
            // });
          }
        },
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(user.uid)
                      .collection('LichenHub_posts')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> postsSnapshot) {
                    if (postsSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (postsSnapshot.hasError) {
                      return const Text('Error loading posts');
                    } else {
                      List<Widget> postWidgets = [];
                      for (var postDoc in postsSnapshot.data!.docs) {
                        var post = postDoc.data() as Map<String, dynamic>;
                        postWidgets.add(
                          Column(
                            children: [
                              // Stream for fetching comments
                              StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(user.uid)
                                    .collection('LichenHub_posts')
                                    .doc(postDoc.id)
                                    .collection('comments')
                                    .orderBy('timestamp', descending: true)
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot>
                                        commentsSnapshot) {
                                  if (commentsSnapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const CircularProgressIndicator();
                                  } else if (commentsSnapshot.hasError) {
                                    return const Text('Error loading comments');
                                  } else {
                                    List<Widget> commentWidgets = [];
                                    for (var commentDoc
                                        in commentsSnapshot.data!.docs) {
                                      var comment = commentDoc.data()
                                          as Map<String, dynamic>;
                                      commentWidgets.add(
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: GestureDetector(
                                            onTap: () {
                                              // Handle onTap for each comment
                                            },
                                            child: Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8),
                                              padding: const EdgeInsets.all(16),
                                              decoration: BoxDecoration(
                                                color: Colors.grey[100],
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Icon(
                                                    Icons.comment,
                                                    size: 30,
                                                    color: Colors.blue,
                                                  ),
                                                  const SizedBox(width: 16),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        RichText(
                                                          text: TextSpan(
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    'ABeeZee'),
                                                            children: [
                                                              TextSpan(
                                                                text:
                                                                    "${comment['sender']} replied to your post ",
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                              TextSpan(
                                                                text:
                                                                    "${post['title']}",
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                              const TextSpan(
                                                                text: ":",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 14),
                                                        Text(
                                                          '"${comment['reply']}"',
                                                          style:
                                                              const TextStyle(
                                                            color: Color(
                                                                0xFF797272),
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 8),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Text(
                                                              DateFormat(
                                                                      'yyyy-MM-dd hh:mma')
                                                                  .format(comment[
                                                                          'timestamp']
                                                                      .toDate()),
                                                              style:
                                                                  const TextStyle(
                                                                color: Color(
                                                                    0xFF797272),
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .italic,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }

                                    return Column(
                                      children: commentWidgets,
                                    );
                                  }
                                },
                              ),

                              // Stream for fetching likes
                              StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(user.uid)
                                    .collection('LichenHub_posts')
                                    .doc(postDoc.id)
                                    .collection('likes')
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot>
                                        likesSnapshot) {
                                  if (likesSnapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const CircularProgressIndicator();
                                  } else if (likesSnapshot.hasError) {
                                    return const Text('Error loading likes');
                                  } else {
                                    List<Widget> likedUserIds = [];
                                    for (var usersLiked
                                        in post['likedByUserIds'] ?? []) {
                                      likedUserIds.add(Padding(
                                        padding: const EdgeInsets.only(
                                            left: 5, right: 5),
                                        child: GestureDetector(
                                          onTap: () {
                                            // Handle onTap for each like
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 8),
                                            padding: const EdgeInsets.all(16),
                                            decoration: BoxDecoration(
                                              color: Colors.grey[100],
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Icon(
                                                  Icons.thumb_up,
                                                  size: 30,
                                                  color: Colors.green,
                                                ),
                                                const SizedBox(width: 16),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      RichText(
                                                        text: TextSpan(
                                                          style: const TextStyle(
                                                              fontFamily:
                                                                  'ABeeZee'),
                                                          children: [
                                                            TextSpan(
                                                              text:
                                                                  "A user liked your post",
                                                              style: const TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                            TextSpan(
                                                              text:
                                                                  " ${post['title']}",
                                                              style: const TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ));
                                    }
                                    return Column(
                                      children: likedUserIds,
                                    );
                                  }
                                },
                              ),

                              // Stream for fetching reports
                              StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(user.uid)
                                    .collection('LichenHub_posts')
                                    .doc(postDoc.id)
                                    .collection('reports')
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot>
                                        reportsSnapshot) {
                                  if (reportsSnapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const CircularProgressIndicator();
                                  } else if (reportsSnapshot.hasError) {
                                    return const Text('Error loading reports');
                                  } else {
                                    List<Widget> reportWidgets = [];
                                    for (var reportDoc
                                        in reportsSnapshot.data!.docs) {
                                      var report = reportDoc.data()
                                          as Map<String, dynamic>?;
                                      if (report == null) {
                                        continue;
                                      }
                                      reportWidgets.add(
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 5, right: 5),
                                          child: GestureDetector(
                                            onTap: () {
                                              // Handle onTap for each report
                                            },
                                            child: Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8),
                                              padding: const EdgeInsets.all(16),
                                              decoration: BoxDecoration(
                                                color: Colors.grey[100],
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Icon(
                                                    Icons.report,
                                                    size: 35,
                                                    color: Colors.red,
                                                  ),
                                                  const SizedBox(width: 16),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        RichText(
                                                          text: TextSpan(
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    'ABeeZee'),
                                                            children: [
                                                              TextSpan(
                                                                text:
                                                                    "Your post",
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                              TextSpan(
                                                                text:
                                                                    " ${post['title']} ",
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                              TextSpan(
                                                                text:
                                                                    "was reported by 1 user for the following concerns: \n",
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                              for (var flag in report[
                                                                      'reportFlags']
                                                                  as List<
                                                                      dynamic>)
                                                                TextSpan(
                                                                  text:
                                                                      "\n\u2022 $flag", // Bullet point
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Color(
                                                                        0xFF797272),
                                                                    fontSize:
                                                                        13,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                                ),
                                                              // TextSpan(
                                                              //   text: report[
                                                              //       'reporterUserID'],
                                                              //   style: const TextStyle(
                                                              //       fontSize:
                                                              //           14,
                                                              //       fontWeight:
                                                              //           FontWeight
                                                              //               .bold,
                                                              //       color: Colors
                                                              //           .black),
                                                              // ),
                                                            ],
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 14),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Text(
                                                              DateFormat(
                                                                      'yyyy-MM-dd hh:mma')
                                                                  .format(report[
                                                                          'timestamp']
                                                                      .toDate()),
                                                              style:
                                                                  const TextStyle(
                                                                color: Color(
                                                                    0xFF797272),
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .italic,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }

                                    return Column(
                                      children: reportWidgets,
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        );
                      }

                      return Column(
                        children: postWidgets,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),

      // Floating action button
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: navigatorHidden ? null : _lichenCheckBtn(context),

      // Bottom navigation ba()
      bottomNavigationBar: navigatorHidden ? null : _bottomNavBar(context),
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
        backgroundColor: const Color(0xFFFFF4E9),
        onPressed: () {},
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
        const BottomNavigationBarItem(
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
