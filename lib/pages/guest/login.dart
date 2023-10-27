import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController _email;
  late final TextEditingController _password;

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
                      // Adjust the padding
                      child: ElevatedButton(
                        onPressed: () async {
                          final email = _email.text;
                          final password = _password.text;
                          try {
                            final userCredential = await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: email, password: password);
                            print(userCredential);
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              print('No user found for that email.');
                            } else if (e.code == 'wrong-password') {
                              print('Wrong password provided for that user.');
                            }
                          }
                        },
                        child: Text(
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
                            Navigator.of(context).pushNamed('/registration');
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
      obscureText: isPassword,
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
      ),
    );
  }
}
