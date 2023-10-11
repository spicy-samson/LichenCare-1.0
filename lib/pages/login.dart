import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
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
                    _buildTextField('Email', false, Icons.email),
                    SizedBox(height: 20.0),
                    _buildTextField('Password', true, Icons.lock),
                    SizedBox(height: 50.0),
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

  Widget _buildTextField(String label, bool isPassword, IconData? icon) {
    double w = MediaQuery.of(context).size.width;
    return TextFormField(
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.grey, // Set the label color to black
        ),
        prefixIcon: icon != null ? Icon(icon) : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
              color: Color(
                  0xFF5CC9CD)), // Set the border color to blue when focused
        ),
        contentPadding:
            EdgeInsets.symmetric(horizontal: w * 0.05, vertical: 4.0),
      ),
    );
  }
}
