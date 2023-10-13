import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
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
                    _buildTextField('Email', false, Icons.email, _emailFocus),
                    SizedBox(height: 30.0),
                    _buildTextField(
                        'Password', true, Icons.lock, _passwordFocus),
                    SizedBox(height: 30.0),
                    Container(
                      // Adjust the padding
                      child: ElevatedButton(
                        onPressed: () {
                          // Implement your registration logic here
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
                              EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 10)),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xFFFF7F50)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
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

  Widget _buildTextField(
      String label, bool isPassword, IconData? icon, FocusNode focusNode) {
    double w = MediaQuery.of(context).size.width;

    return TextFormField(
      focusNode: focusNode, // Assign the FocusNode to the TextFormField
      obscureText: isPassword,
      decoration: InputDecoration(
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
