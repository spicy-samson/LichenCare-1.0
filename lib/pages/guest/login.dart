import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  bool _passwordVisible = false;
  bool _isLoading = false; // Track loading state

  String errorMessage = '';
  String successMessage = '';

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFFFFF4E9),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: h * 0.1,
              ),
              SvgPicture.asset(
                'assets/svgs/LichenCare main logo.svg',
                width: w * 0.2,
                height: h * 0.3,
              ),
              SvgPicture.asset(
                'assets/svgs/LichenCare main branding.svg',
                width: w * 0.15,
                height: h * 0.08,
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 60,
                    vertical: 10), // Adjust the horizontal padding
                child: Column(
                  children: [
                    SizedBox(height: 30.0),
                    _buildTextField(
                        'Email', false, Icons.email, _email, _emailFocus),
                    SizedBox(height: 30.0),
                    _buildTextField('Password', true, Icons.lock, _password,
                        _passwordFocus),
                    SizedBox(height: 30.0),
                    Container(
                      child: ElevatedButton(
                        onPressed: _isLoading
                            ? null
                            : () async {
                                if (_email.text.isEmpty ||
                                    _password.text.isEmpty) {
                                  errorMessage = 'Please fill in all fields.';
                                  successMessage = '';
                                  _showSnackBar(errorMessage);
                                  return;
                                }

                                setState(() {
                                  _isLoading = true; // Set loading state
                                });

                                final email = _email.text;
                                final password = _password.text;
                                try {
                                  final userCredential = await FirebaseAuth
                                      .instance
                                      .signInWithEmailAndPassword(
                                          email: email, password: password);

                                  if (userCredential.user != null &&
                                      userCredential.user!.emailVerified) {
                                    // User is logged in and email is verified

                                    successMessage =
                                        'You have successfully logged in!';
                                    _showSnackBar(successMessage);
                                    // Update Firestore data to indicate that the email is verified
                                    try {
                                      final user =
                                          FirebaseAuth.instance.currentUser;
                                      if (user != null) {
                                        await FirebaseFirestore.instance
                                            .collection('users')
                                            .doc(user.uid)
                                            .update({
                                          'email_verified': true,
                                        });
                                      }
                                    } catch (e) {
                                      print(
                                          "Error updating Firestore data: $e");
                                    }
                                    // If the login is successful and email is verified, navigate to the home page using the named route.
                                    Navigator.of(context)
                                        .pushReplacementNamed('/home');
                                  } else if (userCredential.user != null &&
                                      !userCredential.user!.emailVerified) {
                                    // User is logged in but email is not verified
                                    errorMessage =
                                        'Please verify your email first.';
                                    _showSnackBar(errorMessage);
                                  } else {
                                    // User not found or other errors
                                    errorMessage =
                                        'User not found or other error occurred.';
                                    _showSnackBar(errorMessage);
                                  }
                                } on FirebaseAuthException catch (e) {
                                  errorMessage = 'Error: ${e.message}';
                                  _showSnackBar(errorMessage);
                                } finally {
                                  setState(() {
                                    _isLoading = false; // Reset loading state
                                  });
                                }
                              },
                        child: _isLoading
                            ? CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                                strokeWidth:
                                    4.0, 
                              ) // Show a loading indicator
                            : Text(
                                'Sign in',
                                style: TextStyle(
                                  fontSize: 23.0,
                                  color: Colors.white,
                                ),
                              ),
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xFFFF7F50)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(
                                  color: Colors.white,
                                  width: 2.0), // Add the white border here
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account?",
                            style: TextStyle(fontSize: 16.0)),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/registration',
                                (Route<dynamic> route) => false);
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFF7F50),
                              fontSize: 16.0,
                            ),
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
    );
  }

  Widget _buildTextField(String label, bool isPassword, IconData? icon,
      TextEditingController controller, FocusNode focusNode) {
    double w = MediaQuery.of(context).size.width;
    return TextFormField(
      controller: controller,
      enableSuggestions: false,
      autocorrect: false,
      focusNode: focusNode, // Assign the FocusNode to the TextFormField
      obscureText: isPassword ? !_passwordVisible : false,
      decoration: InputDecoration(
        filled: true, // This makes the background color fill the field
        fillColor: Colors.white, // This sets the background color to white
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.grey,
        ),
        prefixIcon: Icon(
          icon,
          color: focusNode.hasFocus ? Color(0xFFFF7F50) : Colors.grey,
        ),
        prefixIconConstraints: BoxConstraints(
          minWidth: 40,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Color(0xFFFF7F50),
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: w * 0.05,
          vertical: 4.0,
        ),

        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              )
            : null,
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Center(
        child: Text(message, textAlign: TextAlign.center),
      ),
    ));
  }
}