import 'package:flutter/material.dart';
import 'package:budget_tracking_system/services/auth.dart';
import 'package:budget_tracking_system/pages/loading.dart';

class Login extends StatefulWidget {
  final Function toggleView;
  Login({this.toggleView});
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';

  bool passwordVisible;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Color.fromRGBO(57, 57, 57, 1),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
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
                      //Creates a text field for email input.
                      SizedBox(height: 60.0),
                      TextFormField(
                        validator: (val) =>
                            val.isEmpty ? 'Enter an Email' : null,
                        onChanged: (val) {
                          setState(() => email = val);
                        },
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          //Remove visible borders
                          border: InputBorder.none,
                          //Enables color fill in the text form field.
                          filled: true,
                          fillColor: Color.fromRGBO(41, 41, 41, 1),
                          //Border when it is not focused by user input.
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          //Border when it is focused by user input.
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide:
                                  BorderSide(color: Colors.transparent)),

                          //An icon that appears at the very beginning of the text form field.
                          prefixIcon: Icon(
                            Icons.account_circle,
                            color: Color.fromRGBO(101, 101, 101, 1),
                          ),
                          //Label and hint text to guide users' input.
                          labelText: 'Email',
                          hintText: 'example@mail.com',
                          hintStyle: TextStyle(
                              color: Color.fromRGBO(101, 101, 101, 1)),

                          labelStyle: TextStyle(
                              fontSize: 20.0,
                              color: Color.fromRGBO(101, 101, 101, 1)),
                        ),
                      ),

                      SizedBox(height: 20.0),

                      //Creates a text field for password input.
                      TextFormField(
                        validator: (val) =>
                            val.length < 6 ? 'Enter Password' : null,
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                        //Hides the password characters
                        obscureText: !passwordVisible,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          filled: true,
                          fillColor: Color.fromRGBO(41, 41, 41, 1),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Color.fromRGBO(101, 101, 101, 1),
                          ),
                          //An icon that displays at the very end of the text form field.
                          //To check whether a user pressed the show password icon.
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                //If a user tap the visibility icon, passwordVisible boolean state will be changed.
                                passwordVisible = !passwordVisible;
                              });
                            },
                            icon: Icon(
                              //If passwordVisible is False, display the visibility icon.
                              //Else display the visibility_off icon.
                              passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Color.fromRGBO(101, 101, 101, 1),
                            ),
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
                            minWidth: 350.0,
                            child: RaisedButton(
                              color: Color.fromRGBO(255, 185, 49, 1),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0)),
                              onPressed: () async {
                                //Navigator.pushReplacementNamed(context, '/mainpage');
                                if (_formKey.currentState.validate()) {
                                  setState(() => loading = true);
                                  // FirebaseUser user =
                                  //     FirebaseAuth.instance.currentUser();
                                  dynamic result =
                                      await _auth.signInWithEmailAndPassword(
                                          email, password);
                                  if (result == null) {
                                    setState(() {
                                      error = 'Please Try Again';
                                      loading = false;
                                    });
                                  }
                                }
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
                          GestureDetector(
                            onTap: () {
                              //Navigator.pushReplacementNamed(context, '/register');
                              widget.toggleView();
                            },
                            child: Text(
                              'Sign Up Here',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.grey),
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            error,
                            style: TextStyle(color: Colors.red, fontSize: 14.0),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
