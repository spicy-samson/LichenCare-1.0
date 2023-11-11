import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lichen_care/pages/guest/home_sliders.dart';
import '/firebase_options.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

Color primaryBackgroundColor = const Color(0xFFFFF4E9);
Color primaryforegroundColor = const Color(0xFFFF7F50);
Color secondaryForegroundColor = const Color(0xFF66D7D1);
Color successColor = Colors.green;
Color errorColor = Colors.red;

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  late final TextEditingController _firstName;
  late final TextEditingController _lastName;
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _confirmPassword;

  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  bool _isLoading = false; // Track loading state

  bool isFirebaseInitialized = true;
  bool passwordError = false;
  String errorMessage = '';
  String successMessage = '';

  @override
  void initState() {
    _firstName = TextEditingController();
    _lastName = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
    _confirmPassword = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Create a FocusNode for the text field
  final FocusNode _firstNameFocus = FocusNode();
  final FocusNode _lastNameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey, // Add the key to your Scaffold
      backgroundColor: Color(0xFFFFF4E9),
      appBar: AppBar(
        backgroundColor: Color(0xFFFFF4E9),
        leading: Container(
          margin: EdgeInsets.only(left: 30.0),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.black,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MyCarousel(),
                ),
              );
            },
          ),
        ),
        title: Text(
          'Sign Up',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 34.0,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 70.0,
      ),
      body: isFirebaseInitialized
          ? SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 60, vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Create an account',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    _buildTextField('First Name', false, Icons.person,
                        _firstName, _firstNameFocus),
                    SizedBox(height: 30.0),
                    _buildTextField('Last Name', false, Icons.person, _lastName,
                        _lastNameFocus),
                    SizedBox(height: 30.0),
                    _buildTextField(
                        'Email', false, Icons.email, _email, _emailFocus),
                    SizedBox(height: 30.0),
                    _buildTextField('Password', true, Icons.lock, _password,
                        _passwordFocus),
                    SizedBox(height: 30.0),
                    _buildTextField('Confirm Password', true, Icons.lock,
                        _confirmPassword, _confirmPasswordFocus),
                    SizedBox(height: 35.0),
                    Container(
                      child: ElevatedButton(
                        onPressed: _isLoading
                            ? null
                            : () async {
                                if (_firstName.text.isEmpty ||
                                    _lastName.text.isEmpty ||
                                    _email.text.isEmpty ||
                                    _password.text.isEmpty ||
                                    _confirmPassword.text.isEmpty) {
                                  errorMessage = 'Please fill in all fields.';
                                  successMessage = '';
                                  _showSnackBar(errorMessage);
                                  return;
                                }

                                setState(() {
                                  _isLoading = true; // Set loading state
                                });

                                try {
                                  final email = _email.text;
                                  final password = _password.text;
                                  final confirmPassword = _confirmPassword.text;
                                  final firstName = _firstName.text;
                                  final lastName = _lastName.text;

                                  if (password == confirmPassword) {
                                    setState(() {
                                      passwordError =
                                          false; // Reset password error
                                    });

                                    final userCredential = await FirebaseAuth
                                        .instance
                                        .createUserWithEmailAndPassword(
                                      email: email,
                                      password: password,
                                    );

                                    if (userCredential.user != null) {
                                      // Add user data to Firestore
                                      await FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(userCredential.user!.uid)
                                          .set({
                                        'first_name': firstName,
                                        'last_name': lastName,
                                        'email': email,
                                        'email_verified':
                                            userCredential.user!.emailVerified,
                                      });

                                      // Send an email verification link to the user
                                      await userCredential.user!
                                          .sendEmailVerification();

                                      // Show the verification email dialog
                                      AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.success,
                                        animType: AnimType.topSlide,
                                        title: 'Successful registration!',
                                        desc:
                                            'A verification email has been sent to your email address. Please check your email and click the verification link to activate your account.',
                                        descTextStyle: TextStyle(
                                          fontSize: 16.0,
                                        ),
                                        padding: EdgeInsets.all(16.0),
                                        btnOkOnPress: () {
                                          Navigator.of(context).pop();
                                          Navigator.of(context)
                                              .pushNamedAndRemoveUntil(
                                                  '/login',
                                                  (Route<dynamic> route) =>
                                                      false); // Navigate to the login page
                                        },
                                      ).show();
                                    }
                                  } else {
                                    setState(() {
                                      passwordError =
                                          true; // Set password error
                                    });

                                    errorMessage = 'Passwords do not match.';
                                    successMessage = '';

                                    _showSnackBar(errorMessage);
                                  }
                                } on FirebaseAuthException catch (e) {
                                  errorMessage = 'Error: ${e.message}';
                                  successMessage = '';
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
                                strokeWidth: 4.0,
                              ) // Show a loading indicator
                            : Text(
                                'Sign Up',
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
                              primaryforegroundColor),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(color: Colors.white, width: 2.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 43.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 13.0, right: 13.0),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Already have an account?',
                              style: TextStyle(
                                fontSize: 16.0,
                                height: 0.8,
                                color: Colors.black,
                              ),
                            ),
                            WidgetSpan(
                              child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      '/login',
                                      (Route<dynamic> route) => false);
                                },
                                child: Center(
                                  child: Text(
                                    'Sign in',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: primaryforegroundColor,
                                      fontSize: 16.0,
                                      height: 0.8,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget _buildTextField(String label, bool isPassword, IconData? icon,
      TextEditingController controller, FocusNode focusNode) {
    double w = MediaQuery.of(context).size.width;

    bool isPasswordField =
        isPassword && label.toLowerCase().contains('password');
    bool isConfirmPasswordField =
        isPassword && label.toLowerCase().contains('confirm password');

    return Column(
      children: [
        TextFormField(
          controller: controller,
          focusNode: focusNode,
          obscureText: isPasswordField
              ? !_passwordVisible
              : isConfirmPasswordField
                  ? !_confirmPasswordVisible
                  : false,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            labelText: label,
            labelStyle: TextStyle(
              color: Colors.grey,
            ),
            prefixIcon: Icon(icon,
                color: MaterialStateColor.resolveWith((states) =>
                    states.contains(MaterialState.selected)
                        ? Colors.orange
                        : Colors.grey)),
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
            suffixIcon: isPasswordField
                ? IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  )
                : isConfirmPasswordField
                    ? IconButton(
                        icon: Icon(
                          _confirmPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _confirmPasswordVisible = !_confirmPasswordVisible;
                          });
                        },
                      )
                    : null,
          ),
        ),
      ],
    );
  }

  void _showSnackBar(String message) {
    final isErrorMessage = message == errorMessage;
    final snackBarBackgroundColor = isErrorMessage ? errorColor : successColor;

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: snackBarBackgroundColor, // Set the background color
      content: Center(
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white, // Set the text color to white
          ),
        ),
      ),
      duration: Duration(milliseconds: 2000),
    ));
  }
}

class EmailVerificationDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0), // Rounded borders
      ),
      title: Text(
        'Successful registration! but first, we need to verify your email.',
        style: TextStyle(
          color: Color(0xFF66D7D1),
        ),
      ),
      content: Text(
          'A verification email has been sent to your email address. Please check your email and click the verification link to activate your account.'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
            Navigator.of(context).pushNamedAndRemoveUntil('/login',
                (Route<dynamic> route) => false); // Navigate to the login page
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}
