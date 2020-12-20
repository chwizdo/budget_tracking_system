import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
   bool passwordVisible;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(57, 57, 57, 1),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            children: [
              //Creates a space to display the logo.
              Column(
                children: [
                  SizedBox(height: 80.0),
                  Image.asset(
                    'assets/Logo.png',
                    height: 150.0,
                    width: 150.0,
                  ),
                ],
              ),

              SizedBox(height: 40.0),
              
              //Creates a text field for email input.
              TextFormField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    //Remove visible borders
                    border: InputBorder.none, 
                    //Enables color fill in the text form field.
                    filled: true, 
                    fillColor: Color.fromRGBO(41, 41, 41, 1),   
                    //Border when it is not focused by user input.              
                    enabledBorder: OutlineInputBorder( 
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    //Border when it is focused by user input.
                    focusedBorder: OutlineInputBorder( 
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.transparent)
                    ),
                    //An icon that appears at the very beginning of the text form field.
                    prefixIcon: Icon(
                      Icons.account_circle,
                      color: Color.fromRGBO(101, 101, 101, 1),
                      ),
                    //Label and hint text to guide users' input.
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
              TextFormField(
                obscureText: !passwordVisible,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  border: InputBorder.none,  
                  filled: true,
                  fillColor: Color.fromRGBO(41, 41, 41, 1),                 
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.transparent)
                  ),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Color.fromRGBO(101, 101, 101, 1),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      passwordVisible ? Icons.visibility : Icons.visibility_off,
                      color: Color.fromRGBO(101, 101, 101, 1),
                    ),
                    onPressed: () {
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    },
                  ),
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    fontSize: 20.0,
                    color: Color.fromRGBO(101, 101, 101, 1)),
                ),
              ),
            
              SizedBox(height: 20),

              //Creates a text field for password input confirmation.
              TextFormField(
                obscureText: !passwordVisible,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  border: InputBorder.none,  
                  filled: true,
                  fillColor: Color.fromRGBO(41, 41, 41, 1),                 
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.transparent)
                  ),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Color.fromRGBO(101, 101, 101, 1),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      passwordVisible ? Icons.visibility : Icons.visibility_off,
                      color: Color.fromRGBO(101, 101, 101, 1),
                    ),
                    onPressed: () {
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    },
                  ),
                  labelText: 'Re-Password',
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
                    minWidth: 350.0,           
                    child: RaisedButton(
                      color: Color.fromRGBO(255, 185, 49, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0)
                      ),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/mainpage');
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Color.fromRGBO(41, 41, 41, 1),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20.0),

                  //A clickable text that navigates user to register new account.             
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                      child: Text(
                      'Return to Login',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.grey
                      ),
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