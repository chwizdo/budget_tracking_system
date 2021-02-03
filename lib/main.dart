import 'package:flutter/material.dart';
// import 'package:budget_tracking_system/pages/mainpage.dart';
// import 'package:budget_tracking_system/pages/login.dart';
// import 'package:budget_tracking_system/pages/register.dart';
// import 'package:budget_tracking_system/pages/addrecord.dart';
// import 'package:budget_tracking_system/pages/editrecord.dart';
import 'package:budget_tracking_system/pages/addbudget.dart';
import 'package:provider/provider.dart';
import 'package:budget_tracking_system/services/user.dart';
import 'package:budget_tracking_system/services/auth.dart';
import 'package:budget_tracking_system/pages/wrapper.dart';

void main() {
  runApp(MyApp());
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
