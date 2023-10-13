import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
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
              _buildTextField(
                  'First Name', false, Icons.person, _firstNameFocus),
              SizedBox(height: 30.0),
              _buildTextField('Last Name', false, Icons.person, _lastNameFocus),
              SizedBox(height: 30.0),
              _buildTextField('Email', false, Icons.email, _emailFocus),
              SizedBox(height: 30.0),
              _buildTextField('Password', true, Icons.lock, _passwordFocus),
              SizedBox(height: 30.0),
              _buildTextField(
                  'Confirm Password', true, Icons.lock, _confirmPasswordFocus),
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
