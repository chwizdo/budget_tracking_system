import 'package:flutter/material.dart';
import 'package:budget_tracking_system/pages/mainpage.dart';
import 'package:budget_tracking_system/pages/login.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/login',
  routes: {
    '/login': (context) => Login(),
    '/mainpage': (context) => Mainpage()
  },
));

