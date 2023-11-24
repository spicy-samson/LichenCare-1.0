import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lichen_care/helpers/helpers.dart';
import 'package:lichen_care/pages/guest/login.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:shared_preferences/shared_preferences.dart';

Color primaryBackgroundColor = const Color(0xFFFFF4E9);
Color primaryforegroundColor = const Color(0xFFFF7F50);
Color secondaryForegroundColor = const Color(0xFF66D7D1);
Color termaryForegroundColor = const Color.fromARGB(255, 231, 231, 240);

class LichenHub extends StatefulWidget {
  @override
  _LichenHubState createState() => _LichenHubState();
}

class Post {
  String id;
  String userID;
  String user;
  String? userProfile;
  DateTime datetime;
  String title;
  QuillController content;
  String? embeddedImage;
  int likes;
  List<String> likedByUserIds;
  bool isLiked;
  List<Comment> comments;

  Post({
    required this.id,
    required this.userID,
    required this.user,
    required this.datetime,
    required this.title,
    required this.content,
    required this.isLiked,
    this.embeddedImage,
    required this.likes,
    required this.likedByUserIds,
    required this.comments,
  });
}

class Comment {
  String id;
  String sender;
  String reply;
  DateTime datetime;
  Comment(
      {required this.id,
      required this.sender,
      required this.reply,
      required this.datetime});
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
  QuillController contentController = QuillController.basic();
  FocusNode editorFocusNode = FocusNode();
  TextEditingController reportFieldController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController replyController = TextEditingController();
  bool titleOnFocus = false;
  Color currentColor = Colors.black87;
  List<int> reportFlags = [];
  File? postImage;
  Map<String, bool> toolbar = {
    "bold": false,
    "italic": false,
    "underline": true,
  };
  List<Post> posts = [];
  // UI booleans
  bool postLoaded = false;
  bool isPosting = false;
  bool navigatorHidden = false;

  final FirebaseAuth auth = FirebaseAuth.instance;
  final storage = FirebaseStorage.instance;

  Future loadPosts() async {
    try {
      final usersCollection = FirebaseFirestore.instance.collection('users');
      final postsCollectionName = 'LichenHub_posts';

      final querySnapshot = await usersCollection.get();

      List<Post> loadedPosts = [];

      for (var userDoc in querySnapshot.docs) {
        final postsCollection =
            userDoc.reference.collection(postsCollectionName);

        final userPostsSnapshot = await postsCollection
            .orderBy('date_uploaded', descending: true)
            .get();

        for (var doc in userPostsSnapshot.docs) {
          var postDoc = doc.data() as Map<String, dynamic>;

          var content = QuillController.basic();
          try {
            content.document =
                Document.fromJson(jsonDecode(postDoc['content']));
          } catch (e) {
            content.document = Document()..insert(0, postDoc['content'] ?? '');
          }

          // Create a new Post object
          var post = Post(
            id: doc.id,
            userID: postDoc['userID'] ?? '',
            user: postDoc['uploader_name'] ?? '',
            datetime: postDoc['date_uploaded']?.toDate(),
            title: postDoc['title'] ?? '',
            content: content,
            isLiked: false,
            likes: postDoc['likes'] ?? 0,
            likedByUserIds: [],
            comments: [],
            embeddedImage: postDoc['file_image'],
          );

          // Fetch comments
          var commentsQuery = await doc.reference.collection('comments').get();
          post.comments = commentsQuery.docs
              .map((commentDoc) => Comment(
                    id: commentDoc.id,
                    sender: commentDoc['sender'] ?? '',
                    reply: commentDoc['reply'] ?? '',
                    datetime: commentDoc['timestamp']?.toDate() ?? '',
                  ))
              .toList();

          // Add the post to the list
          loadedPosts.add(post);
        }
      }

      // Update the local list with the loaded posts
      if (mounted) {
        setState(() {
          posts = loadedPosts;
        });
      }
    } catch (e) {
      print('Error loading posts: $e');
    }
  }

  Future newPost() async {
    // check if the post userID matches the current user
    final user = auth.currentUser;
    QuillController newController = QuillController.basic();
    newController.document =
        Document.fromDelta(contentController.document.toDelta());
    if (user == null) {
      return;
    }

    try {
      final userDocRef =
          FirebaseFirestore.instance.collection('users').doc(user.uid);
      final userSnapshot = await userDocRef.get();

      if (userSnapshot.exists) {
        final firstName = userSnapshot.get('first_name') ?? '';
        final postsCollection = userDocRef.collection('LichenHub_posts');
        final storageRef = storage
            .ref()
            .child('lichenhub_images/${user.uid}/${DateTime.now()}.jpg');

        String? imageUrl; // Default to null

        if (postImage != null) {
          final uploadTask = await storageRef.putFile(postImage!);

          if (uploadTask.state == TaskState.success) {
            imageUrl = await uploadTask.ref.getDownloadURL();
          } else {
            print('Error uploading the image to Firebase Storage');
          }
        }

        final timestamp = DateTime.now(); // Get the current timestamp

        final newInputDocRef = await postsCollection.add({
          'title': titleController.text,
          'content': jsonEncode(newController.document.toDelta().toJson()),
          'date_uploaded': timestamp,
          'file_image': imageUrl,
          'likes': 0,
          'uploader_name': firstName,
          'userID': user.uid,
        });

        // Create a new Post object
        Post newPost = Post(
          id: newInputDocRef.id,
          userID: user.uid,
          user: firstName,
          datetime: timestamp,
          title: titleController.text,
          content: newController,
          isLiked: false,
          likes: 0,
          likedByUserIds: [],
          comments: [],
          embeddedImage: imageUrl,
        );

        // Add the new post to the local list
        setState(() {
          posts = [newPost, ...posts];
        });

        //await addCommentToPost(newPost, 'Commenter Name', 'This is a comment.');
      } else {
        print('User document does not exist in Firestore');
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  bool isPostFromUser(Post post) {
    // check if the post userID matches the current user
    final user = auth.currentUser;

    try {
      return user?.uid == post.userID ? true : false;
    } catch (e) {
      print('Error: $e');
      return false; // or handle the error in an appropriate way for your use case
    }
  }

  Future<void> commentOnPost(Post post, String reply, DateTime time) async {
    var user = auth.currentUser;

    if (user == null) {
      return;
    }

    try {
      // Get the commentor's details
      final userDocRef =
          FirebaseFirestore.instance.collection('users').doc(user.uid);
      final senderSnapshot = await userDocRef.get();
      final firstName = senderSnapshot.get('first_name') ?? '';

      // Get the post owner's details
      final postOwnerDocRef =
          FirebaseFirestore.instance.collection('users').doc(post.userID);
      final userSnapshot = await postOwnerDocRef.get();

      if (userSnapshot.exists) {
        final postsCollection = postOwnerDocRef.collection('LichenHub_posts');

        final postDocRef = postsCollection.doc(post.id);

        final newCommentDocRef = await postDocRef.collection('comments').add({
          'sender': makeAnonymous(firstName),
          'reply': reply,
          'timestamp': time,
        });

        // Create a new Comment object
        Comment newComment = Comment(
          id: newCommentDocRef.id,
          sender: makeAnonymous(firstName),
          reply: reply,
          datetime: time,
        );

        // Update the local list with the new comment
        setState(() {
          post.comments = [newComment, ...post.comments];
        });
      } else {
        print('User document does not exist in Firestore');
      }
    } catch (e) {
      print('Error adding comment: $e');
    }
  }

  Future editPost(Post post) async {
    try {
      final user = auth.currentUser;

      if (user == null) {
        return;
      }

      final userDocRef =
          FirebaseFirestore.instance.collection('users').doc(user.uid);
      final userSnapshot = await userDocRef.get();

      if (userSnapshot.exists) {
        final postsCollection = userDocRef.collection('LichenHub_posts');
        final postDocRef = postsCollection.doc(post.id);

        String? imageUrl = post.embeddedImage; // Default to the current image

        // Upload a new image if postImage is not null
        if (postImage != null) {
          final storageRef = storage
              .ref()
              .child('lichenhub_images/${user.uid}/${DateTime.now()}.jpg');

          final uploadTask = await storageRef.putFile(postImage!);

          if (uploadTask.state == TaskState.success) {
            imageUrl = await uploadTask.ref.getDownloadURL();
          } else {
            print('Error uploading the new image to Firebase Storage');
          }
        }

        // Update post data in Firestore, including the new image URL
        await postDocRef.update({
          'title': titleController.text,
          'content': jsonEncode(contentController.document.toDelta().toJson()),
          'file_image': imageUrl,
        });

        // Fetch the updated post from Firestore
        final updatedPostDoc = await postDocRef.get();
        final updatedPostData = updatedPostDoc.data() as Map<String, dynamic>;

        // Update the local list with the edited post
        setState(() {
          post.title = updatedPostData['title'];
          post.content.document =
              Document.fromJson(jsonDecode(updatedPostData['content']));
          post.embeddedImage = updatedPostData['file_image'];
        });

        print('Post edited successfully');
      } else {
        print('User document does not exist in Firestore');
      }
    } catch (e) {
      print('Error editing post: $e');
    }
  }

  Future<void> deletePost(Post post) async {
    final user = auth.currentUser;
    if (user == null) {
      return;
    }

    try {
      final userDocRef =
          FirebaseFirestore.instance.collection('users').doc(user.uid);
      final postsCollection = userDocRef.collection('LichenHub_posts');
      final postDocRef = postsCollection.doc(post.id);

      // Get the image URL from the post
      String? imageUrl = post.embeddedImage;

      // Delete post document from Cloud Firestore
      await postDocRef.delete();

      // Delete image from Firebase Storage if URL exists
      if (imageUrl != null && imageUrl.isNotEmpty) {
        // Get a reference to the image in Firebase Storage
        Reference imageRef = FirebaseStorage.instance.refFromURL(imageUrl);

        // Delete the image
        await imageRef.delete();
      }

      // Delete comments collection
      final commentsCollection = postDocRef.collection('comments');
      final commentsQuery = await commentsCollection.get();
      for (var commentDoc in commentsQuery.docs) {
        await commentDoc.reference.delete();
      }

      print('Post and comments deleted successfully');

      setState(() {
        post.content.dispose();
        posts.remove(post);
        replyController.dispose();
      });
    } catch (e) {
      print('Error deleting post: $e');
    }
  }

  Future<void> likePost(Post post) async {
    try {
      User? user = auth.currentUser;
      if (user == null) {
        return;
      }

      final postRef = FirebaseFirestore.instance
          .collection('users')
          .doc(post.userID)
          .collection('LichenHub_posts')
          .doc(post.id);

      // Check if the post is liked by the current user locally
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> userLikedPosts =
          prefs.getStringList('userLikedPosts_${user.uid}') ?? [];

      bool isLiked = userLikedPosts.contains(post.id);

      // Use FieldValue.arrayUnion and FieldValue.arrayRemove to append/remove user ID
      final likeUpdate = isLiked
          ? FieldValue.arrayRemove([user.uid])
          : FieldValue.arrayUnion([user.uid]);

      // Firebase update
      await postRef.update({
        'likes': isLiked ? post.likes - 1 : post.likes + 1,
        'likedByUserIds': likeUpdate,
      });

      // Update local liked posts
      if (isLiked) {
        userLikedPosts.remove(post.id);
      } else {
        userLikedPosts.add(post.id);
      }

      // Save updated liked post IDs locally
      await prefs.setStringList('userLikedPosts_${user.uid}', userLikedPosts);

      setState(() {
        post.likes = isLiked ? post.likes - 1 : post.likes + 1;
        post.isLiked = !isLiked;
        post.likedByUserIds = List.from(
            likeUpdate == FieldValue.arrayUnion([user.uid])
                ? [...post.likedByUserIds, user.uid]
                : post.likedByUserIds
              ..remove(user.uid));
      });
    } catch (e) {
      print('Error liking the post: $e');
    }
  }

  Future<void> reportPost(
      Post post, List<int> reportFlags, String details) async {
    try {
      // Get the current user
      User? user = auth.currentUser;
      if (user == null) {
        return;
      }

      // Reference to the post document
      final postRef = FirebaseFirestore.instance
          .collection('users')
          .doc(post.userID)
          .collection('LichenHub_posts')
          .doc(post.id);

      // Extract the actual values from the reportFlags indices
      List<String> selectedFlags = reportFlags.map((index) {
        return concerns[index];
      }).toList();

      // Report object
      Map<String, dynamic> reportData = {
        'reporterUserID': user.uid,
        'reportFlags': selectedFlags,
        'details': details,
        'timestamp': FieldValue.serverTimestamp(),
      };

      // Update the post document with the report
      await postRef.collection('reports').add(reportData);
    } catch (e) {
      print('Error reporting the post: $e');
    }
  }

  void copyPostContent(Post post) async {
    await Clipboard.setData(
        ClipboardData(text: post.content.document.toPlainText()));
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(milliseconds: 1000),
        content: Text("Content copied to clipboard.")));
  }

  // WIDGET BUILDERS
  dynamic composePost(double scaleFactor, {Post? post}) {
    toolbar["bold"] = false;
    toolbar["italic"] = false;
    toolbar["underline"] = false;
    postImage = null;
    isPosting = false;
    setState(() {});
    if (post != null) {
      titleController.text = post.title;
      contentController.document =
          Document.fromDelta(post.content.document.toDelta());
      Navigator.of(context).pop();
    }
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        barrierColor: Colors.transparent,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            contentController.document.changes.listen((event) {
              if (context.mounted) {
                setState(() {});
              }
            });
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
                  decoration: BoxDecoration(
                      color: termaryForegroundColor,
                      boxShadow: const [
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
                          (isPosting)
                              ? SpinKitRing(
                                  color: Color(0XFFF0784C),
                                  size: 40.0,
                                )
                              : InkWell(
                                  onTap: () async {
                                    if (isPosting) {
                                      return;
                                    }
                                    if (contentController.document
                                            .toPlainText()
                                            .trim() ==
                                        "") {
                                      return;
                                    }
                                    setState(() {
                                      isPosting = true;
                                    });
                                    if (post == null) {
                                      await newPost();
                                    } else {
                                      await editPost(post);
                                    }
                                    setState(() {
                                      isPosting = false;
                                    });
                                    Navigator.of(context).pop();
                                  },
                                  child: Transform.rotate(
                                      angle: -3.14 / 5,
                                      child: Icon(
                                        Icons.send,
                                        size: 24,
                                        color: (contentController.document
                                                    .toPlainText()
                                                    .trim() ==
                                                "")
                                            ? Colors.grey
                                            : primaryforegroundColor,
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
                      child: FocusScope(
                        onFocusChange: (focus) {
                          setState(() {
                            titleOnFocus = focus;
                          });
                        },
                        child: TextFormField(
                          controller: titleController,
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
                    ),
                    Stack(
                      children: [
                        SizedBox(
                            width: double.infinity,
                            height: 380 * scaleFactor,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: QuillProvider(
                                configurations: QuillConfigurations(
                                  controller: contentController,
                                  sharedConfigurations:
                                      const QuillSharedConfigurations(),
                                ),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: QuillEditor.basic(
                                        focusNode: editorFocusNode,
                                        configurations:
                                            const QuillEditorConfigurations(
                                          placeholder:
                                              "Start a new conversation",
                                          readOnly: false,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )),
                        GestureDetector(
                          onTap: () async {
                            await Future.delayed(
                                const Duration(milliseconds: 100));
                            final currentStyle =
                                contentController.getSelectionStyle();
                            if (currentStyle.containsKey('bold')) {
                              toolbar['bold'] = true;
                            } else {
                              toolbar['bold'] = false;
                            }

                            if (currentStyle.containsKey('italic')) {
                              toolbar['italic'] = true;
                            } else {
                              toolbar['italic'] = false;
                            }

                            if (currentStyle.containsKey('underline')) {
                              toolbar['underline'] = true;
                            } else {
                              toolbar['underline'] = false;
                            }

                            if (currentStyle.containsKey('color')) {
                              currentColor = Color(int.parse(
                                  currentStyle.attributes['color']!.value
                                      .toString()
                                      .replaceAll("#", ""),
                                  radix: 16));
                            } else {
                              currentColor = Colors.black87;
                            }

                            setState(() {});
                          },
                          behavior: HitTestBehavior.translucent,
                          child: SizedBox(
                            width: double.infinity,
                            height: 380 * scaleFactor,
                          ),
                        ),
                      ],
                    ),
                    (postImage == null)
                        ? (post != null && post.embeddedImage != null)
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 10.0),
                                child: Container(
                                  width: double.infinity,
                                  height: 300,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.0))),
                                  child: FittedBox(
                                    fit: BoxFit.cover,
                                    child: Image.network(
                                      post.embeddedImage!,
                                      loadingBuilder: (BuildContext context,
                                          Widget child,
                                          ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null)
                                          return child;
                                        return FadeInImage(
                                          placeholder: AssetImage(
                                              'assets/imgs/placeholder-image.jpg'), // Your placeholder image asset
                                          image:
                                              NetworkImage(post.embeddedImage!),
                                          fit: BoxFit.cover,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox()
                        : Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10.0),
                            child: Container(
                              width: double.infinity,
                              height: 300,
                              clipBehavior: Clip.antiAlias,
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0))),
                              child: FittedBox(
                                  fit: BoxFit.cover,
                                  child: Image.file(postImage!)),
                            ),
                          )
                  ]),
                )),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 8.0, left: 15.0, right: 15.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () async {
                            final take = await ImagePicker().pickImage(
                                source: ImageSource.gallery,
                                maxHeight: 720,
                                maxWidth: 480);
                            if (take == null) {
                              return;
                            }
                            setState(() {
                              postImage = File(take.path);
                            });
                          },
                          child: Container(
                            width: 60 * scaleFactor,
                            height: 60 * scaleFactor,
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
                        (MediaQuery.of(context).viewInsets.bottom == 0 ||
                                titleOnFocus)
                            ? const SizedBox()
                            : InkWell(
                                onTap: () {
                                  if (toolbar["bold"]!) {
                                    toolbar["bold"] = false;
                                    contentController.formatSelection(Attribute(
                                        "bold", AttributeScope.INLINE, null));
                                  } else {
                                    toolbar["bold"] = true;
                                    contentController.formatSelection(Attribute(
                                        "bold", AttributeScope.INLINE, true));
                                  }
                                  setState(() {});
                                },
                                child: Container(
                                  width: 60 * scaleFactor,
                                  height: 60 * scaleFactor,
                                  decoration: BoxDecoration(
                                    color: (toolbar["bold"]!)
                                        ? primaryforegroundColor
                                        : Colors.black12.withOpacity(0.05),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                  ),
                                  child: Center(
                                      child: Text("B",
                                          style: TextStyle(
                                              color: (toolbar["bold"]!)
                                                  ? termaryForegroundColor
                                                  : primaryforegroundColor,
                                              fontSize: 36 * scaleFactor,
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic))),
                                ),
                              ),
                        (MediaQuery.of(context).viewInsets.bottom == 0 ||
                                titleOnFocus)
                            ? const SizedBox()
                            : InkWell(
                                onTap: () {
                                  if (toolbar["italic"]!) {
                                    toolbar["italic"] = false;
                                    contentController.formatSelection(Attribute(
                                        "italic", AttributeScope.INLINE, null));
                                  } else {
                                    toolbar["italic"] = true;
                                    contentController.formatSelection(Attribute(
                                        "italic", AttributeScope.INLINE, true));
                                  }
                                  setState(() {});
                                },
                                child: Container(
                                  width: 60 * scaleFactor,
                                  height: 60 * scaleFactor,
                                  decoration: BoxDecoration(
                                    color: (toolbar["italic"]!)
                                        ? primaryforegroundColor
                                        : Colors.black12.withOpacity(0.05),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(15.0 * scaleFactor)),
                                  ),
                                  child: Center(
                                      child: Text("I",
                                          style: TextStyle(
                                              color: (toolbar["italic"]!)
                                                  ? termaryForegroundColor
                                                  : primaryforegroundColor,
                                              fontSize: 36 * scaleFactor,
                                              fontStyle: FontStyle.italic))),
                                ),
                              ),
                        (MediaQuery.of(context).viewInsets.bottom == 0 ||
                                titleOnFocus)
                            ? const SizedBox()
                            : InkWell(
                                onTap: () {
                                  if (toolbar["underline"]!) {
                                    toolbar["underline"] = false;
                                    contentController.formatSelection(Attribute(
                                        "underline",
                                        AttributeScope.INLINE,
                                        null));
                                  } else {
                                    toolbar["underline"] = true;
                                    contentController.formatSelection(Attribute(
                                        "underline",
                                        AttributeScope.INLINE,
                                        true));
                                  }
                                  setState(() {});
                                },
                                child: Container(
                                  width: 60 * scaleFactor,
                                  height: 60 * scaleFactor,
                                  decoration: BoxDecoration(
                                    color: (toolbar["underline"]!)
                                        ? primaryforegroundColor
                                        : Colors.black12.withOpacity(0.05),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                  ),
                                  child: Center(
                                      child: Text("U",
                                          style: TextStyle(
                                              color: (toolbar["underline"]!)
                                                  ? termaryForegroundColor
                                                  : primaryforegroundColor,
                                              decoration:
                                                  TextDecoration.underline,
                                              fontSize: 36 * scaleFactor))),
                                ),
                              ),
                        (MediaQuery.of(context).viewInsets.bottom == 0 ||
                                titleOnFocus)
                            ? const SizedBox()
                            : InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text('Pick a color!'),
                                      content: SingleChildScrollView(
                                        child: ColorPicker(
                                          pickerColor: Colors.black87,
                                          onColorChanged: (color) {
                                            setState(() {
                                              currentColor = color;
                                            });
                                          },
                                        ),
                                      ),
                                      actions: <Widget>[
                                        ElevatedButton(
                                          child: const Text('Got it'),
                                          onPressed: () {
                                            contentController.formatSelection(
                                                Attribute(
                                                    "color",
                                                    AttributeScope.INLINE,
                                                    "#${currentColor.value.toRadixString(16).toUpperCase()}"));
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                child: Container(
                                  width: 60 * scaleFactor,
                                  height: 60 * scaleFactor,
                                  decoration: BoxDecoration(
                                    color: Colors.black12.withOpacity(0.05),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                  ),
                                  child: Icon(
                                    Icons.palette,
                                    color: currentColor,
                                    size: 40 * scaleFactor,
                                  ),
                                ),
                              ),
                        (MediaQuery.of(context).viewInsets.bottom == 0 ||
                                titleOnFocus)
                            ? const Spacer()
                            : const SizedBox(),
                      ]),
                ),
                SizedBox(
                  height: MediaQuery.of(context).viewInsets.bottom + 15,
                )
              ]),
            );
          });
        });
  }

  dynamic reportScreen(Post post) {
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
                                        if (reportFlags.isEmpty) {
                                          return;
                                        }
                                        // Get details from the text field
                                        String details =
                                            reportFieldController.text.trim();

                                        // Call the reportPost function
                                        await reportPost(
                                            post, reportFlags, details);
                                        AwesomeDialog(
                                          context: context,
                                          dialogType: DialogType.warning,
                                          animType: AnimType.topSlide,
                                          title: 'Thank you for reportiing',
                                          desc:
                                              "We take your safety seriously and are investigating your submission in accordance with our Code of Conduct.",
                                          descTextStyle: TextStyle(
                                            fontSize: 16.0,
                                          ),
                                          padding: EdgeInsets.all(16.0),
                                          btnCancelText: "Close",
                                          btnCancelOnPress: () {
                                            Navigator.of(context).pop();
                                          },
                                        ).show();
                                        // Navigator.of(context).pop();
                                      },
                                      child: Transform.rotate(
                                          angle: -3.14 / 5,
                                          child: Icon(
                                            Icons.send,
                                            size: 24,
                                            color: (reportFlags.isEmpty)
                                                ? Colors.grey
                                                : primaryforegroundColor,
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
  void initState() {
    super.initState();
    loadPosts().then((value) => {
          if (mounted) {postLoaded = true}
        });
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    contentController.dispose();
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
          padding: EdgeInsets.only(top: h * 0.02, right: w * 0.3),
          child: SvgPicture.asset(
            'assets/svgs/#3 - lichenhub.svg',
            width: w * 0.1,
            height: h * 0.06,
          ),
        ),
        elevation: 0,
        toolbarHeight: 60.0,
        actions: [
          SizedBox(
            height: 70,
            width: 80,
            child: Padding(
              padding: EdgeInsets.only(
                top: h * 0.023,
                bottom: h * 0.01,
              ),
              child: FittedBox(
                child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    Navigator.pushNamed(context, "/lichenNotif");
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
      body: (!postLoaded)
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SpinKitThreeBounce(
                  color: Color(0XFFF0784C),
                  size: 60.0,
                ),
                SizedBox(
                  height: 20,
                ),
                Text("Loading posts...")
              ],
            )
          : Stack(
              children: [
                (posts.isEmpty)
                    ? const Center(
                        child: Text("No Posts Yet."),
                      )
                    : Listener(
                        onPointerMove: (pointer) {
                          // print(pointer.delta);
                          if (pointer.delta.dy == 0) {
                            return;
                          }
                          if (pointer.delta.dy < 0) {
                            // scrolls down
                            setState(() {
                              navigatorHidden = true;
                            });
                          } else {
                            // scrolls up
                            setState(() {
                              navigatorHidden = false;
                            });
                          }
                        },
                        child: RefreshIndicator(
                          backgroundColor: primaryforegroundColor,
                          color: primaryBackgroundColor,
                          onRefresh: () async {
                            await Future.delayed(Duration(milliseconds: 500));
                            setState(() {
                              postLoaded = false;
                            });
                            loadPosts().then((value) => setState(() {
                                  postLoaded = true;
                                }));
                          },
                          child: ListView.builder(
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
                                    onReport: () => reportScreen(posts[index]),
                                    onEdit: () => composePost(scaleFactor,
                                        post: posts[index]),
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
                                                    color: Color.fromARGB(
                                                        255, 206, 206, 221),
                                                    borderRadius: BorderRadius
                                                        .only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    15.0),
                                                            topRight:
                                                                Radius.circular(
                                                                    15.0))),
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.98,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Column(children: [
                                                  Container(
                                                    width: double.infinity,
                                                    height: 75,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            termaryForegroundColor,
                                                        boxShadow: [
                                                          BoxShadow(
                                                              color: Colors
                                                                  .black26,
                                                              offset:
                                                                  Offset(1, 1),
                                                              blurRadius: 2,
                                                              spreadRadius: 2)
                                                        ]),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 20),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          InkWell(
                                                              onTap: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child: Icon(
                                                                  Icons
                                                                      .arrow_back_ios,
                                                                  size: 28,
                                                                  color:
                                                                      primaryforegroundColor)),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                            "Post",
                                                            style: TextStyle(
                                                                fontSize: 22),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                      child: (index >=
                                                              posts.length)
                                                          ? const SizedBox()
                                                          : SingleChildScrollView(
                                                              child: Column(
                                                                  children: [
                                                                    PostBox(
                                                                      post: posts[
                                                                          index],
                                                                      onCopy: () =>
                                                                          copyPostContent(
                                                                              posts[index]),
                                                                      onLike:
                                                                          () {
                                                                        likePost(
                                                                            posts[index]);
                                                                        setState(
                                                                            () {});
                                                                      },
                                                                      onDelete:
                                                                          () async {
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                        deletePost(
                                                                            posts[index]);
                                                                        setState(
                                                                            () {});
                                                                      },
                                                                      fromUser:
                                                                          (isPostFromUser(
                                                                              posts[index])),
                                                                      onReport: () =>
                                                                          reportScreen(
                                                                              posts[index]),
                                                                      onEdit: () => composePost(
                                                                          scaleFactor,
                                                                          post:
                                                                              posts[index]),
                                                                    ),
                                                                    Column(
                                                                      children:
                                                                          List.generate(
                                                                        posts[index]
                                                                            .comments
                                                                            .length,
                                                                        (i) {
                                                                          List<Comment>
                                                                              comments =
                                                                              posts[index].comments;
                                                                          return Padding(
                                                                            padding: const EdgeInsets.only(
                                                                                top: 8.0,
                                                                                left: 15,
                                                                                right: 15),
                                                                            child:
                                                                                Container(
                                                                              decoration: const BoxDecoration(
                                                                                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                                                                color: Color.fromARGB(255, 221, 221, 223),
                                                                              ),
                                                                              constraints: BoxConstraints(minHeight: 100 * scaleFactor, minWidth: double.infinity),
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                                                                                child: Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                      children: [
                                                                                        Text(
                                                                                          comments[i].sender,
                                                                                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                                                                        ),
                                                                                        Text(
                                                                                          DateFormat('yMMMd').add_jm().format(comments[i].datetime),
                                                                                          style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                    Text(
                                                                                      comments[i].reply,
                                                                                      style: TextStyle(fontSize: 14),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          );
                                                                        },
                                                                      ),
                                                                    )
                                                                  ]),
                                                            )),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8.0,
                                                            left: 15.0,
                                                            right: 15.0),
                                                    child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          Expanded(
                                                            child: SizedBox(
                                                              height: 40,
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        5.0),
                                                                child:
                                                                    TextFormField(
                                                                  controller:
                                                                      replyController,
                                                                  textInputAction:
                                                                      TextInputAction
                                                                          .done,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    contentPadding: EdgeInsets.only(
                                                                        left:
                                                                            15,
                                                                        bottom:
                                                                            5),
                                                                    hintText:
                                                                        "Reply",
                                                                    border: OutlineInputBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(15.0)),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              commentOnPost(
                                                                  posts[index],
                                                                  replyController
                                                                      .text,
                                                                  DateTime
                                                                      .now());
                                                              replyController
                                                                  .clear();
                                                            },
                                                            child: Container(
                                                              width: 45,
                                                              height: 45,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .transparent,
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
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
                                                  (navigatorHidden)
                                                      ? const SizedBox()
                                                      : SizedBox(
                                                          height: MediaQuery.of(
                                                                      context)
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
                                  return (navigatorHidden)
                                      ? const SizedBox()
                                      : SizedBox(
                                          height: 30,
                                        );
                                }
                              }),
                        ),
                      ),
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
                          contentController.clear();
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
      floatingActionButton: (navigatorHidden) ? null : _lichenCheckBtn(context),

      // Bottom navigation bar
      bottomNavigationBar: (navigatorHidden) ? null : _bottomNavBar(context),
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
            // Navigator.pushReplacementNamed(context, '/lichenHub');
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
            minHeight: 430 * scaleFactor, minWidth: double.infinity),
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
                      makeAnonymous(post.user),
                      style: TextStyle(fontSize: 28 * scaleFactor),
                    ),
                    Text(DateFormat('yMMMd').add_jm().format(post.datetime),
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
                                            onPressed: () async {
                                              bool confirmDelete =
                                                  await showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Text(
                                                        'Confirm Deletion'),
                                                    content: Text(
                                                        'Are you sure you want to delete this post?'),
                                                    actionsPadding:
                                                        EdgeInsets.zero,
                                                    actions: <Widget>[
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: <Widget>[
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(
                                                                      false); // Return false if canceled
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
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(
                                                                      true); // Return true if confirmed
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
                                                  onDelete!();
                                                  Navigator.of(context)
                                                      .pushNamed('/lichenHub');
                                                } catch (e) {
                                                  print(
                                                      'Error deleting document and/or image: $e');
                                                }
                                              }
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
            Container(
              width: double.infinity,
              height: 220 * scaleFactor,
              child: Padding(
                  padding:
                      const EdgeInsets.only(top: 8.0, left: 15.0, right: 15.0),
                  child: QuillProvider(
                    configurations: QuillConfigurations(
                      controller: post.content,
                      sharedConfigurations:
                          const QuillSharedConfigurations(locale: Locale("de")),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: QuillEditor.basic(
                            configurations: QuillEditorConfigurations(
                              showCursor: false,
                              enableInteractiveSelection: false,
                              customStyles: DefaultStyles(
                                  paragraph: DefaultTextBlockStyle(
                                      TextStyle(
                                          fontSize: 20 * scaleFactor,
                                          color: Colors.black87),
                                      VerticalSpacing(1, 1),
                                      VerticalSpacing(1, 1),
                                      BoxDecoration())),
                              readOnly: true,
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
            ),
            (post.embeddedImage == null)
                ? const SizedBox()
                : Padding(
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
                              loadingBuilder: (BuildContext context,
                                  Widget child,
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
              padding: const EdgeInsets.only(left: 12.0, bottom: 8.0, top: 8.0),
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
                            ? const SizedBox()
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
                    thickness: 1,
                    height: 3,
                    color: Colors.black12,
                  ),
            (onReply == null)
                ? SizedBox()
                : Padding(
                    padding:
                        const EdgeInsets.only(left: 10.0, top: 5, bottom: 5),
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