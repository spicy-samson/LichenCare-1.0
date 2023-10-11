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
        leading: Container(
          margin:
              EdgeInsets.only(left: 30.0), // Set the left margin to 30 pixels
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.black,
            onPressed: () {
              Navigator.of(context).pop();
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
              _buildTextField('First Name', false, Icons.person),
              SizedBox(height: 30.0),
              _buildTextField('Last Name', false, Icons.person),
              SizedBox(height: 30.0),
              _buildTextField('Email', false, Icons.email),
              SizedBox(height: 30.0),
              _buildTextField('Password', true, Icons.lock),
              SizedBox(height: 30.0),
              _buildTextField('Confirm Password', true, Icons.lock),
              SizedBox(height: 70.0),
              Container(
                // Adjust the padding
                child: ElevatedButton(
                  onPressed: () {
                    // Implement your registration logic here
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 23.0,
                      color: Colors.white,
                    ),
                  ),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.symmetric(horizontal: 40, vertical: 10)),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xFFFF7F50)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
                  Text('Already have an account?',
                      style: TextStyle(fontSize: 16.0)),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/login');
                    },
                    child: Text(
                      'Sign in',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFF7F50),
                          fontSize: 16.0),
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
                  0xFFFF7F50)), // Set the border color to blue when focused
        ),
        contentPadding:
            EdgeInsets.symmetric(horizontal: w * 0.05, vertical: 4.0),
      ),
    );
  }
}
