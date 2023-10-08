import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
        toolbarHeight: 100.0,
      ),
      body: SingleChildScrollView(
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
              _buildTextField('First Name', false, null),
              SizedBox(height: 30.0),
              _buildTextField('Last Name', false, null),
              SizedBox(height: 30.0),
              _buildTextField('Email', false, Icons.email),
              SizedBox(height: 30.0),
              _buildTextField('Password', true, Icons.lock),
              SizedBox(height: 30.0),
              _buildTextField('Confirm Password', true, Icons.lock),
              SizedBox(height: 45.0),
              ElevatedButton(
                onPressed: () {
                  // Implement your registration logic here
                },
                child: Text('Sign Up',
                    style: TextStyle(fontSize: 18.0, color: Colors.black)),
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xFF5CC9CD),
                  padding:
                      EdgeInsets.symmetric(horizontal: 100, vertical: 15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have an account?',
                      style: TextStyle(fontSize: 18.0)),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/login');
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF5CC9CD),
                          fontSize: 18.0),
                    ),
                  ),
                ],
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
