import 'package:budget_tracking_system/pages/mainpage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:budget_tracking_system/pages/switch.dart';
//import 'package:budget_tracking_system/pages/mainpage.dart';
import 'package:budget_tracking_system/services/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user == null) {
      return Authenticate();
    } else {
      return Mainpage(
        uid: user.uid,
      );
    }
  }
}
