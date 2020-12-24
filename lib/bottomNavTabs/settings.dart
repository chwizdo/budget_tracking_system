import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(57, 57, 57, 1),
        body: SafeArea(
          child: ListView(children: [
            Container(
              decoration: BoxDecoration(color: Color.fromRGBO(41, 41, 41, 1)),
              height: 50,
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Row(
                  children: [
                    Text(
                      "Category",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 50,
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 10.0),
                child: Row(
                  children: [
                    Text(
                      "Income Category",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Divider(
              color: Colors.grey,
              indent: 15.0,
              endIndent: 15.0,
            ),
            Container(
              height: 50,
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, bottom: 10.0),
                child: Row(
                  children: [
                    Text(
                      "Expenses Category",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(color: Color.fromRGBO(41, 41, 41, 1)),
              height: 60.0,
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Row(
                  children: [
                    Text(
                      "Account",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 50,
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 10.0),
                child: Row(
                  children: [
                    Text(
                      "Currency Selection",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Divider(
              color: Colors.grey,
              indent: 15.0,
              endIndent: 15.0,
            ),
            Container(
              height: 50.0,
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, bottom: 10.0),
                child: Row(
                  children: [
                    Text(
                      "Currency Conversion Rate",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(color: Color.fromRGBO(41, 41, 41, 1)),
              height: 60.0,
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Row(
                  children: [
                    Text(
                      "Appearance",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 50.0,
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Row(
                  children: [
                    Text(
                      "Theme",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            ButtonTheme(
              height: 50,
              child: RaisedButton(
                color: Color.fromRGBO(255, 185, 49, 1),
                elevation: 0,
                child: Text(
                  "Log Out",
                  style: TextStyle(
                    color: Color.fromRGBO(41, 41, 41, 1),
                    fontSize: 18
                  ),
                ),
                onPressed: () {},
              ),
            ),
          ]
      ),
        )
    );
  }
}
