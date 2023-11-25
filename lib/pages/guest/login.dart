import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

Color primaryBackgroundColor = const Color(0xFFFFF4E9);
Color primaryforegroundColor = const Color(0xFFFF7F50);
Color secondaryForegroundColor = const Color(0xFF66D7D1);
Color successColor = Colors.green;
Color errorColor = Colors.red;

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  bool _passwordVisible = false;
  bool _isLoading = false;
  bool rememberMe = false;

  String errorMessage = '';
  String successMessage = '';

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _loadSavedEmail();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  //For the remember be functionality
  Future<void> _loadSavedEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedEmail = prefs.getString('rememberedEmail');
    if (savedEmail != null) {
      setState(() {
        _email.text = savedEmail;
      });
    }
  }

  Future<void> _saveEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('rememberedEmail', _email.text);
    if(rememberMe){
      _keepLogin();
    }
  }

  Future<void> _keepLogin() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('loginEmail', _email.text);
  }

  //Method to check and navigate based on disclaimer status
  Future<void> checkDisclaimerAndNavigate(User? user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Check the disclaimer status
    bool termsDisclaimerClosed =
        prefs.getBool('termsDisclaimerClosed_${user?.uid}') ?? false;
    bool privacyPolicydisclaimerClosed =
        prefs.getBool('privacyPolicyClosed_${user?.uid}') ?? false;

    // If the terms disclaimer is closed, navigate directly to the next screen
    if (termsDisclaimerClosed || privacyPolicydisclaimerClosed) {
      Navigator.of(context).pushReplacementNamed('/home');
    } else {
      // If not closed, navigate to the terms and conditions screen
      Navigator.of(context)
          .pushReplacementNamed('/profile/terms_and_conditions-boot');
    }
  }

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: primaryBackgroundColor,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
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
                    Center(
                      child: Row(
                        children: [
                          Checkbox(
                            value: rememberMe,
                            onChanged: (value) {
                              setState(() {
                                rememberMe = value!;
                              });
                            },
                          ),
                          Text('Remember Me'),
                        ],
                      ),
                    ),
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
                                    _saveEmail();

                                    successMessage =
                                        'You have successfully logged in!';
                                    _showSnackBar(successMessage);
                                    // Update Firestore data to indicate that the email is verified
                                    try {
                                      final user =
                                          FirebaseAuth.instance.currentUser;
                                      if (user != null) {
                                        await checkDisclaimerAndNavigate(user);
                                        
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
                                  
                                  } else if (userCredential.user != null &&
                                      !userCredential.user!.emailVerified) {
                                    // User tries to log in but email is not verified
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
                                  errorMessage = '${e.message}';
                                  if (errorMessage ==
                                      "An internal error has occurred. [ INVALID_LOGIN_CREDENTIALS ]") {
                                    errorMessage = "Invalid email or password.";
                                    print(e.message);
                                  }
                                  _showSnackBar(errorMessage);
                                } finally {
                                  if(mounted){
                                     setState(() {
                                      _isLoading = false; // Reset loading state
                                    });
                                  }
                                }
                              },
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              primaryforegroundColor),
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
                        child: _isLoading
                            ? const CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                                strokeWidth: 4.0,
                              ) // Show a loading indicator
                            : const Text(
                                'Sign in',
                                style: TextStyle(
                                  fontSize: 23.0,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 35.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 13.0, right: 13.0),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: "Don't have an account?",
                              style: TextStyle(
                                // height: 0.8,
                                fontSize: 16.0,
                                color: Colors.black,
                              ),
                            ),
                            WidgetSpan(
                              child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      '/registration',
                                      (Route<dynamic> route) => false);
                                },
                                child: Center(
                                  child: Text(
                                    'Sign Up',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: primaryforegroundColor,
                                      fontSize: 16.0,
                                      // height: 0.001,
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
            color: primaryforegroundColor,
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
    final isErrorMessage = message == errorMessage;
    final snackBarBackgroundColor = isErrorMessage ? errorColor : successColor;

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: snackBarBackgroundColor, // Set the background color
      content: Center(
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white, // Set the text color to white
          ),
        ),
      ),
      duration: Duration(milliseconds: 2000),
    ));
  }
}
