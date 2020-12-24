import 'package:flutter/material.dart';

class ChangeTheme extends StatefulWidget {

  @override
  _ChangeThemeState createState() => _ChangeThemeState();
}

class _ChangeThemeState extends State<ChangeTheme> {
  String selectedTheme = 'dark';

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        unselectedWidgetColor:Colors.grey
      ),
      child: Scaffold(
        backgroundColor: Color.fromRGBO(57, 57, 57, 1),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(18, 18, 18, 1),
          title: Text('Theme'),
        ),
        body: Column(
          children: [
            RadioListTile(
              controlAffinity: ListTileControlAffinity.trailing,
              activeColor: Color.fromRGBO(255, 185, 49, 1),
              title: Text(
                'Light Theme',
                style: TextStyle(
                  color: Colors.white
                ),
              ),
              value: 'light',
              groupValue: selectedTheme,
              onChanged: (value) {
                setState(() {
                  selectedTheme = value;
                });
              },
            ),
            RadioListTile(
              controlAffinity: ListTileControlAffinity.trailing,
              activeColor: Color.fromRGBO(255, 185, 49, 1),
              title: Text(
                'Dark Theme',
                style: TextStyle(
                  color: Colors.white
                ),
              ),
              value: 'dark',
              groupValue: selectedTheme,
              onChanged: (value) {
               setState(() {
                 selectedTheme = value;
               });
              },
            ),
          ],
        ),
      ),
    );
  }
}