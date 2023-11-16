import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LichenHub extends StatefulWidget {
  @override
  _LichenHubState createState() => _LichenHubState();
}

class _LichenHubState extends State<LichenHub> {
  int _currentIndex = 3;

  Color primaryBackgroundColor = const Color(0xFFFFF4E9);
  Color primaryforegroundColor = const Color(0xFFFF7F50);
  Color secondaryForegroundColor = const Color(0xFF66D7D1);

  List<Post> posts = [
    Post(id: "1", user: "Anonymous User", datetime: DateTime.now(), title: "", 
    content: "Hi, All\nI'm new to the group and hoping to get some answers. My toddler (almost 2) us itchy all over, mostly lower back, stomach and scalph. We thought it was caused by dustmite allergy but it can't be that alone.\nIs this LP?", 
    likes: 2, comments: [])
  ];

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFFFFF4E9),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFFFFF4E9),
        title: Padding(
          padding: EdgeInsets.only(top: h * 0.05, right: w * 0.3),
          child: SvgPicture.asset(
            'assets/svgs/#3 - lichenhub.svg',
            width: w * 0.1,
            height: h * 0.06,
          ),
        ),
        elevation: 0,
        toolbarHeight: 80.0,
        actions: [
          SizedBox(height: 80, width: 80,
            child: Padding(
              padding:  EdgeInsets.only(top: h * 0.05,),
              child: FittedBox(
                child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: (){},
                  child: Icon(Icons.notifications,color: primaryforegroundColor ,),
                ),
              ),
            ),
          )
        ],
      ),

      // Body
      body: (posts.isEmpty) ? const Center(child: Text("No Posts Yet."),) : ListView.builder(
        itemCount: posts.length,
        itemBuilder: (BuildContext context, int index){
          return PostBox(post: posts[index]);
        }),

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



class PostBox extends StatelessWidget {
  final Post post;
  const PostBox({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15.0))
      ),
    );
  }
}


class Post{
  String id;
  String user;
  DateTime datetime;
  String title;
  String content;
  int likes;
  List<Comment> comments;
  Post({
    required this.id,
    required this.user,
    required this.datetime,
    required this.title,
    required this.content,
    required this.likes,
    required this.comments
  });
}

class Comment{
  String id;
  String sender;
  String reply;
  Comment({
    required this.id,
    required this.sender,
    required this.reply
  });
}