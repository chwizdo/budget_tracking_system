import 'package:budget_tracking_system/bottomNavTabs/record.dart';
import 'package:budget_tracking_system/services/record.dart' as recServ;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:budget_tracking_system/pages/switch.dart';
import 'package:budget_tracking_system/pages/mainpage.dart';
import 'package:budget_tracking_system/services/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user == null) {
      return Authenticate();
    } else {
      recServ.Record.getRecords(uid: user.uid);
      return Mainpage(
        uid: user.uid,
      );
    }
  }
}
