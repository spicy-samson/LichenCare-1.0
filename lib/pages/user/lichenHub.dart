import 'package:intl/intl.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lichen_care/pages/guest/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter_quill/flutter_quill.dart' as quill;

Color primaryBackgroundColor = const Color(0xFFFFF4E9);
Color primaryforegroundColor = const Color(0xFFFF7F50);
Color secondaryForegroundColor = const Color(0xFF66D7D1);
Color termaryForegroundColor = const Color.fromARGB(255, 231, 231, 240);

class LichenHub extends StatefulWidget {
  @override
  _LichenHubState createState() => _LichenHubState();
}

class _LichenHubState extends State<LichenHub> {
  int _currentIndex = 3;
  List<String> concerns = [
    "Sexually inappropriate",
    "Terrorist or Violent extermisit content",
    "Child sexual exploitation or abuse",
    "Harrassments or threats",
    "Imminent harm to persons or property",
    "Malware or viruses",
    "Fraud or a spam",
    "Copyright and trademark infringement",
    "Hate speech",
    "Other"
  ];
  GlobalKey reportField = GlobalKey();
  TextEditingController reportFieldController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  List<int> reportFlags = [];

  List<Post> posts = [
    Post(
        id: "1",
        userID: "1",
        user: "Anonymous User",
        datetime: DateTime.now(),
        title: "",
        content:
            "Hi, All\nI'm new to the group and hoping to get some answers. My toddler (almost 2) us itchy all over, mostly lower back, stomach and scalph. We thought it was caused by dustmite allergy but it can't be that alone.\nIs this LP?",
        embeddedImage:
            "https://drive.google.com/uc?export=view&id=13jg-JY7jRQhbtMjcpsVmVPhBUjKjcIBT",
        likes: 2,
        isLiked: true,
        comments: [
          Comment(
              id: "1", sender: "Anonymous User", reply: "This is a comment."),
          Comment(
              id: "1",
              sender: "Anonymous User",
              reply: "This is another comment."),
          Comment(
              id: "1",
              sender: "Anonymous User",
              reply: "This is another another comment.")
        ])
  ];

  Future newPost() async {
    // create entry
    // titleController.text is title
    // concernController.text is content
  }

  Future editPost(Post post) async {
    // edit entry (post.id)
    // titleController.text is title
    // concernController.text is content
  }

  Future replyPost(Post post) async {
    // post comment connected to post.id
  }

  Future deletePost(Post post) async {
    // delete post from post.id

    // update widget
    setState(() {
      posts.remove(post);
    });
  }

  Future likePost(Post post) async {
    // backend
    // update the list of ids who liked the post (use post id)
    // update the number of likes of the post (use post id)
    if (post.isLiked) {
    } else {}

    // update widget
    if (post.isLiked) {
      setState(() {
        post.likes -= 1;
        post.isLiked = false;
      });
    } else {
      setState(() {
        post.likes += 1;
        post.isLiked = true;
      });
    }
  }

  bool isPostFromUser(Post post) {
    // check if the post userID matches the current user
    return (post.userID == "1");
  }

  void copyPostContent(Post post) async {
    await Clipboard.setData(ClipboardData(text: post.content));
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(milliseconds: 1000),
        content: Text("Content copied to clipboard.")));
  }

  // WIDGET BUILDERS

  dynamic composePost(double scaleFactor, {Post? post}) {
    if (post != null) {
      titleController.text = post.title;
      // contentController.text = post.content;
      Navigator.of(context).pop();
    }
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        barrierColor: Colors.transparent,
        builder: (context) {
          return Container(
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 206, 206, 221),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0))),
            height: MediaQuery.of(context).size.height * 0.98,
            width: MediaQuery.of(context).size.width,
            child: Column(children: [
              Container(
                width: double.infinity,
                height: 75,
                decoration:
                    BoxDecoration(color: termaryForegroundColor, boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      offset: Offset(1, 1),
                      blurRadius: 2,
                      spreadRadius: 2)
                ]),
                child: Center(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Icon(Icons.close_sharp,
                                size: 28, color: primaryforegroundColor)),
                        Expanded(
                            child: Center(
                                child: Text(
                          (post == null) ? "New post" : "Edit post",
                          style: TextStyle(fontSize: 22),
                        ))),
                        InkWell(
                          onTap: () async {
                            if (post == null) {
                              await newPost();
                            } else {
                              await editPost(post);
                            }
                            Navigator.of(context).pop();
                          },
                          child: Transform.rotate(
                              angle: -3.14 / 5,
                              child: Icon(
                                Icons.send,
                                size: 24,
                                color: primaryforegroundColor,
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(children: [
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: TextFormField(
                      controller: titleController,
                      textInputAction: TextInputAction.go,
                      style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87),
                      decoration: const InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                          hintText: "Add a title",
                          hintStyle: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          )),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: SizedBox())
                ]),
              )),
              Padding(
                padding:
                    const EdgeInsets.only(top: 8.0, left: 15.0, right: 15.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Container(
                          width: 45 * scaleFactor,
                          height: 45 * scaleFactor,
                          decoration: BoxDecoration(
                            color: Colors.black12.withOpacity(0.05),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                          ),
                          child: Icon(
                            Icons.photo,
                            color: primaryforegroundColor,
                            size: 40 * scaleFactor,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          width: 45 * scaleFactor,
                          height: 45 * scaleFactor,
                          decoration: BoxDecoration(
                            color: Colors.black12.withOpacity(0.05),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                          ),
                          child: Center(
                              child: Text("B",
                                  style: TextStyle(
                                      color: primaryforegroundColor,
                                      fontSize: 36 * scaleFactor,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic))),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          width: 45 * scaleFactor,
                          height: 45 * scaleFactor,
                          decoration: BoxDecoration(
                            color: Colors.black12.withOpacity(0.05),
                            borderRadius: BorderRadius.all(
                                Radius.circular(15.0 * scaleFactor)),
                          ),
                          child: Center(
                              child: Text("I",
                                  style: TextStyle(
                                      color: primaryforegroundColor,
                                      fontSize: 36 * scaleFactor,
                                      fontStyle: FontStyle.italic))),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          width: 45 * scaleFactor,
                          height: 45 * scaleFactor,
                          decoration: BoxDecoration(
                            color: Colors.black12.withOpacity(0.05),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                          ),
                          child: Center(
                              child: Text("U",
                                  style: TextStyle(
                                      color: primaryforegroundColor,
                                      decoration: TextDecoration.underline,
                                      fontSize: 36 * scaleFactor))),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          width: 45 * scaleFactor,
                          height: 45 * scaleFactor,
                          decoration: BoxDecoration(
                            color: Colors.black12.withOpacity(0.05),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                          ),
                          child: Icon(
                            Icons.edit,
                            color: primaryforegroundColor,
                            size: 40 * scaleFactor,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          width: 45 * scaleFactor,
                          height: 45 * scaleFactor,
                          decoration: BoxDecoration(
                            color: Colors.black12.withOpacity(0.05),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                          ),
                          child: Center(
                              child: Text("A",
                                  style: TextStyle(
                                      color: primaryforegroundColor,
                                      decoration: TextDecoration.underline,
                                      fontSize: 36 * scaleFactor))),
                        ),
                      )
                    ]),
              ),
              SizedBox(
                height: MediaQuery.of(context).viewInsets.bottom + 15,
              )
            ]),
          );
        });
  }

  dynamic reportPost(Post post) {
    Navigator.of(context).pop();
    setState(() {
      reportFlags = [];
      reportFieldController.text = "";
    });
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        barrierColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Container(
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 206, 206, 221),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15.0),
                      topLeft: Radius.circular(15.0))),
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.98,
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 75,
                        decoration: BoxDecoration(
                            color: termaryForegroundColor,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(1, 1),
                                  blurRadius: 2,
                                  spreadRadius: 2)
                            ]),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("Cancel",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: primaryforegroundColor))),
                                Expanded(
                                    child: Center(
                                  child: Text(
                                    "Report a concern",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                )),
                                SizedBox(
                                  width: 40,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: InkWell(
                                      onTap: () async {
                                        Navigator.of(context).pop();
                                      },
                                      child: Transform.rotate(
                                          angle: -3.14 / 5,
                                          child: Icon(
                                            Icons.send,
                                            size: 24,
                                            color: primaryforegroundColor,
                                          )),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 15.0),
                        child: Text(
                          "Tell us your concern",
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: List.generate(concerns.length, (j) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 5.0),
                            child: TextButton(
                                style: TextButton.styleFrom(
                                    padding:
                                        EdgeInsets.only(left: 15, right: 15.0),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15.0)))),
                                onPressed: () {
                                  setState(() {
                                    if (reportFlags.contains(j)) {
                                      reportFlags.remove(j);
                                    } else {
                                      reportFlags.add(j);
                                    }
                                  });
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: (reportFlags.contains(j))
                                              ? primaryforegroundColor
                                              : Color.fromARGB(
                                                  255, 206, 206, 221),
                                          border: Border.all(
                                              width: 2.0,
                                              color: primaryforegroundColor)),
                                      child: Center(
                                          child: Icon(Icons.check,
                                              size: 24,
                                              color: Color.fromARGB(
                                                  255, 206, 206, 221))),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                        child: Text(
                                      concerns[j],
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.black87),
                                    ))
                                  ],
                                )),
                          );
                        }),
                      ),
                      const Divider(
                        color: Colors.black38,
                        thickness: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: TextFormField(
                          controller: reportFieldController,
                          key: reportField,
                          onTap: () {
                            Scrollable.ensureVisible(
                                reportField.currentContext!,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut);
                          },
                          maxLines: 20,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText:
                                  "Include details about the offensive behavior"),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).viewInsets.bottom,
                      )
                    ]),
              ),
            );
          });
        });
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    // contentController.dispose();
    reportFieldController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    double scaleFactor = h / 1080;
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
          SizedBox(
            height: 70,
            width: 80,
            child: Padding(
              padding: EdgeInsets.only(
                top: h * 0.055,
              ),
              child: FittedBox(
                child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    Navigator.of(context).pushNamed('/lichenNotif');
                  },
                  child: Icon(
                    Icons.notifications,
                    color: primaryforegroundColor,
                  ),
                ),
              ),
            ),
          )
        ],
      ),

      // Body
      body: Stack(
        children: [
          (posts.isEmpty)
              ? const Center(
                  child: Text("No Posts Yet."),
                )
              : ListView.builder(
                  itemCount: posts.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index < posts.length) {
                      return PostBox(
                        post: posts[index],
                        fromUser: (isPostFromUser(posts[index])),
                        onCopy: () => copyPostContent(posts[index]),
                        onLike: () {
                          likePost(posts[index]);
                        },
                        onDelete: () {
                          deletePost(posts[index]);
                          Navigator.of(context).pop();
                        },
                        onReport: () => reportPost(posts[index]),
                        onEdit: () =>
                            composePost(scaleFactor, post: posts[index]),
                        onReply: () {
                          showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              barrierColor: Colors.transparent,
                              builder: (context) {
                                return StatefulBuilder(
                                    builder: ((context, setState) {
                                  return Container(
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 206, 206, 221),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15.0),
                                            topRight: Radius.circular(15.0))),
                                    height: MediaQuery.of(context).size.height *
                                        0.98,
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(children: [
                                      Container(
                                        width: double.infinity,
                                        height: 75,
                                        decoration: BoxDecoration(
                                            color: termaryForegroundColor,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black26,
                                                  offset: Offset(1, 1),
                                                  blurRadius: 2,
                                                  spreadRadius: 2)
                                            ]),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              InkWell(
                                                  onTap: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Icon(
                                                      Icons.arrow_back_ios,
                                                      size: 28,
                                                      color:
                                                          primaryforegroundColor)),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "Post",
                                                style: TextStyle(fontSize: 22),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                          child: (index >= posts.length)
                                              ? const SizedBox()
                                              : SingleChildScrollView(
                                                  child: Column(children: [
                                                    PostBox(
                                                      post: posts[index],
                                                      onCopy: () =>
                                                          copyPostContent(
                                                              posts[index]),
                                                      onLike: () {
                                                        likePost(posts[index]);
                                                        setState(() {});
                                                      },
                                                      onDelete: () async {
                                                        Navigator.of(context)
                                                            .pop();
                                                        Navigator.of(context)
                                                            .pop();
                                                        deletePost(
                                                            posts[index]);
                                                        setState(() {});
                                                      },
                                                      fromUser: (isPostFromUser(
                                                          posts[index])),
                                                      onReport: () =>
                                                          reportPost(
                                                              posts[index]),
                                                      onEdit: () => composePost(
                                                          scaleFactor,
                                                          post: posts[index]),
                                                    ),
                                                    Column(
                                                      children: List.generate(
                                                          posts[index]
                                                              .comments
                                                              .length, (i) {
                                                        List<Comment> comments =
                                                            posts[index]
                                                                .comments;
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 8.0,
                                                                  left: 15,
                                                                  right: 15),
                                                          child: Container(
                                                            decoration:
                                                                const BoxDecoration(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          15.0)),
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      221,
                                                                      221,
                                                                      223),
                                                            ),
                                                            constraints: BoxConstraints(
                                                                minHeight: 100 *
                                                                    scaleFactor,
                                                                minWidth: double
                                                                    .infinity),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          10.0,
                                                                      vertical:
                                                                          8.0),
                                                              child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      comments[
                                                                              i]
                                                                          .sender,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                    Text(
                                                                      comments[
                                                                              i]
                                                                          .reply,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14),
                                                                    )
                                                                  ]),
                                                            ),
                                                          ),
                                                        );
                                                      }),
                                                    )
                                                  ]),
                                                )),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0, left: 15.0, right: 15.0),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Expanded(
                                                child: SizedBox(
                                                  height: 40,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 5.0),
                                                    child: TextFormField(
                                                      textInputAction:
                                                          TextInputAction.done,
                                                      decoration:
                                                          InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets.only(
                                                                left: 15,
                                                                bottom: 5),
                                                        hintText: "Reply",
                                                        border: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15.0)),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  replyPost(posts[index]);
                                                  Navigator.of(context).pop();
                                                },
                                                child: Container(
                                                  width: 45,
                                                  height: 45,
                                                  decoration: BoxDecoration(
                                                    color: Colors.transparent,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                15.0)),
                                                  ),
                                                  child: Center(
                                                      child: Icon(
                                                    Icons.send,
                                                    color:
                                                        primaryforegroundColor,
                                                    size: 32,
                                                  )),
                                                ),
                                              ),
                                            ]),
                                      ),
                                      SizedBox(
                                        height: MediaQuery.of(context)
                                                .viewInsets
                                                .bottom +
                                            15,
                                      )
                                    ]),
                                  );
                                }));
                              });
                        },
                      );
                    } else {
                      return SizedBox(
                        height: 30,
                      );
                    }
                  }),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  setState(() {
                    titleController.text = '';
                  });
                  composePost(scaleFactor);
                },
                child: CircleAvatar(
                  radius: 35,
                  backgroundColor: primaryforegroundColor,
                  child: Icon(
                    Icons.post_add,
                    size: 40,
                    color: Colors.black45,
                  ),
                ),
              ),
            ),
          )
        ],
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

class PostBox extends StatelessWidget {
  final Post post;
  final bool fromUser;
  final Function? onReply;
  final Function? onLike;
  final Function? onEdit;
  final Function? onDelete;
  final Function? onCopy;
  final Function? onReport;
  const PostBox(
      {super.key,
      required this.post,
      this.onReply,
      this.onLike,
      this.onEdit,
      this.onDelete,
      this.onCopy,
      this.onReport,
      this.fromUser = false});

  @override
  Widget build(BuildContext context) {
    double scaleFactor = (MediaQuery.of(context).size.height -
            MediaQuery.of(context).padding.top) /
        1080;
    return Padding(
      padding: EdgeInsets.only(
          left: 20.0 * scaleFactor, right: 20.0 * scaleFactor, top: 20),
      child: Container(
        constraints: BoxConstraints(
            minHeight: 500 * scaleFactor, minWidth: double.infinity),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          color: Color.fromARGB(255, 206, 206, 221),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                Icon(
                  Icons.person_pin,
                  color: primaryforegroundColor,
                  size: 100 * scaleFactor,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.user,
                      style: TextStyle(fontSize: 28 * scaleFactor),
                    ),
                    Text(DateFormat('yMMMd').add_jm().format(DateTime.now()),
                        style: TextStyle(fontSize: 20 * scaleFactor)),
                  ],
                ),
                Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            showDragHandle: true,
                            backgroundColor: Colors.transparent,
                            isScrollControlled: true,
                            builder: (context) {
                              return Container(
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 206, 206, 221),
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(15.0),
                                        topLeft: Radius.circular(15.0))),
                                width: double.infinity,
                                height: 250,
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(children: [
                                    (!fromUser)
                                        ? const SizedBox()
                                        : TextButton(
                                            style: TextButton.styleFrom(
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    15.0)))),
                                            onPressed: () {
                                              onEdit!();
                                            },
                                            child: Row(
                                              children: [
                                                Icon(Icons.edit,
                                                    size: 36,
                                                    color:
                                                        primaryforegroundColor),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "Edit",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.black),
                                                )
                                              ],
                                            )),
                                    (!fromUser)
                                        ? const SizedBox()
                                        : TextButton(
                                            style: TextButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                15.0)))),
                                            onPressed: () {
                                              onDelete!();
                                            },
                                            child: Row(
                                              children: [
                                                Icon(Icons.delete,
                                                    size: 36,
                                                    color:
                                                        primaryforegroundColor),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "Delete",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.black),
                                                )
                                              ],
                                            )),
                                    TextButton(
                                        style: TextButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15.0)))),
                                        onPressed: () {
                                          onCopy!();
                                        },
                                        child: Row(
                                          children: [
                                            Icon(Icons.copy,
                                                size: 36,
                                                color: primaryforegroundColor),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "Copy",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black),
                                            )
                                          ],
                                        )),
                                    TextButton(
                                        style: TextButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15.0)))),
                                        onPressed: () {
                                          onReport!();
                                        },
                                        child: Row(
                                          children: [
                                            Icon(Icons.report,
                                                size: 36,
                                                color: primaryforegroundColor),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "Report a concern",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black),
                                            )
                                          ],
                                        )),
                                  ]),
                                ),
                              );
                            });
                      },
                      child: Row(children: [
                        Icon(
                          Icons.circle,
                          size: 10,
                          color: primaryforegroundColor,
                        ),
                        Icon(
                          Icons.circle,
                          size: 10,
                          color: primaryforegroundColor,
                        ),
                        Icon(
                          Icons.circle,
                          size: 10,
                          color: primaryforegroundColor,
                        ),
                      ]),
                    ),
                    const SizedBox(height: 15.0)
                  ],
                ),
                const SizedBox(
                  width: 15,
                )
              ],
            ),
            (post.title == "")
                ? const SizedBox()
                : Padding(
                    padding: const EdgeInsets.only(
                        top: 5.0, left: 15.0, right: 15.0),
                    child: Text(post.title,
                        style: TextStyle(
                            fontSize: 22 * scaleFactor,
                            fontWeight: FontWeight.bold)),
                  ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 15.0, right: 15.0),
              child: Text(post.content,
                  style: TextStyle(fontSize: 18 * scaleFactor)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  width: double.infinity,
                  height: 240 * scaleFactor,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  child: FittedBox(
                      fit: BoxFit.cover,
                      child: Image.network(
                        post.embeddedImage!,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return FadeInImage(
                            placeholder: AssetImage(
                                'assets/imgs/placeholder-image.jpg'), // Your placeholder image asset
                            image: NetworkImage(post.embeddedImage!),
                            fit: BoxFit.cover,
                          );
                        },
                      ))),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0, bottom: 8.0),
              child: InkWell(
                onTap: () {
                  onLike!();
                },
                child: Container(
                  width: 45,
                  height: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    border: Border.all(width: 1.0, color: Colors.red),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.favorite,
                          size: 15,
                          color: Colors.red,
                        ),
                        (post.likes == 0)
                            ? SizedBox()
                            : Text(
                                post.likes.toString(),
                                style:
                                    TextStyle(fontSize: 12, color: Colors.red),
                              )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            (onReply == null)
                ? SizedBox()
                : const Divider(
                    height: 3,
                    color: Colors.black87,
                  ),
            (onReply == null)
                ? SizedBox()
                : Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: SizedBox(
                      width: 100,
                      child: InkWell(
                          onTap: () {
                            onReply!();
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Transform.rotate(
                                  angle: -3.14 / 5,
                                  child: Icon(
                                    Icons.send,
                                    size: 20,
                                    color: primaryforegroundColor,
                                  )),
                              Center(
                                  child: Text(
                                "Reply ${(post.comments.isEmpty) ? "" : "(${post.comments.length})"}",
                                style: TextStyle(
                                    color: primaryforegroundColor, height: 2),
                              ))
                            ],
                          )),
                    ),
                  )
          ]),
        ),
      ),
    );
  }
}

class Post {
  String id;
  String userID;
  String user;
  String? userProfile;
  DateTime datetime;
  String title;
  String content;
  String? embeddedImage;
  int likes;
  bool isLiked;
  List<Comment> comments;
  Post(
      {required this.id,
      required this.userID,
      required this.user,
      required this.datetime,
      required this.title,
      required this.content,
      required this.isLiked,
      this.embeddedImage,
      required this.likes,
      required this.comments});
}

class Comment {
  String id;
  String sender;
  String reply;
  Comment({required this.id, required this.sender, required this.reply});
}
