import 'package:flutter/material.dart';
// import 'package:budget_tracking_system/pages/mainpage.dart';
// import 'package:budget_tracking_system/pages/login.dart';
// import 'package:budget_tracking_system/pages/register.dart';
// import 'package:budget_tracking_system/pages/addrecord.dart';
// import 'package:budget_tracking_system/pages/editrecord.dart';
import 'package:budget_tracking_system/pages/addbudget.dart';
import 'package:budget_tracking_system/services/currency.dart';
// import 'package:budget_tracking_system/pages/addbudget.dart';
import 'package:budget_tracking_system/services/account.dart';
import 'package:provider/provider.dart';
import 'package:budget_tracking_system/services/user.dart';
import 'package:budget_tracking_system/services/auth.dart';
import 'package:budget_tracking_system/pages/wrapper.dart';

void main() {
  runApp(MyApp(
      // MaterialApp(
      // initialRoute: '/login',
      // routes: {
      //   '/login': (context) => Login(),
      //   '/mainpage': (context) => Mainpage(),
      //   '/register': (context) => Register(),
      //   '/addrecord': (context) => AddRecord(),
      //   '/editrecord': (context) => EditRecord(),
      //   '/addbudget': (context) => AddBudget()
      // },
      ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        routes: {'/addbudget': (context) => AddBudget()},
        home: Wrapper(),
      ),
    );
  }
}
