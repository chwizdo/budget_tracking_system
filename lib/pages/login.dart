import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(57, 57, 57, 1),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 18.0),
            children: [
              //Creates a space to display the logo.
              Column(
                children: [
                  SizedBox(height: 100.0),
                  Image.asset(
                    'assets/Logo.png',
                    height: 150.0,
                    width: 150.0,
                  ),
                ],
              ),
              SizedBox(height: 60.0),
              //Creates a text field for email input.
              TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Color.fromRGBO(41, 41, 41, 1),                 
                  enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.transparent),
                  ),
                  prefixIcon: Icon(
                    Icons.account_circle,
                    color: Color.fromRGBO(101, 101, 101, 1),
                    ),
                  labelText: 'Email',
                  hintText: 'example@mail.com',
                  hintStyle: TextStyle(
                    color: Color.fromRGBO(101, 101, 101, 1)
                  ),
                  labelStyle: TextStyle(
                    fontSize: 20.0,
                    color: Color.fromRGBO(101, 101, 101, 1)),
                ),
              ),
              SizedBox(height: 20.0),
              //Creates a text field for password input.
              TextField(
                //To hide the password characters
                obscureText: true,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Color.fromRGBO(41, 41, 41, 1),                 
                  enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.transparent),
                  ),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Color.fromRGBO(101, 101, 101, 1),
                    ),
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    fontSize: 20.0,
                    color: Color.fromRGBO(101, 101, 101, 1)),
                ),
              ),
              SizedBox(height: 20.0),
              //Creates a login button that navigates to main page.
              Column(
                children: [
                  ButtonTheme(
                    height: 50.0,
                    minWidth: 300.0,           
                    child: RaisedButton(
                      color: Color.fromRGBO(255, 185, 49, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0)
                      ),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/mainpage');
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Color.fromRGBO(41, 41, 41, 1),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  //A clickable text that navigates user to register new account.
                  Text(
                    'Sign Up Here',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.grey
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}