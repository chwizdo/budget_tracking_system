import 'package:budget_tracking_system/pages/mainpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:budget_tracking_system/services/record.dart' as service;
import 'package:budget_tracking_system/services/account.dart' as service;
import 'package:budget_tracking_system/services/category.dart' as service;
import 'package:budget_tracking_system/services/currency.dart' as service;

class Loading extends StatefulWidget {
  final String uid;

  Loading({Key key, this.uid}) : super(key: key);
  @override
  _LoadingState createState() => _LoadingState(uid);
}

class _LoadingState extends State<Loading> {
  final String uid;
  _LoadingState(this.uid);
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (uid != null) {
      initialize();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Container(
        color: Colors.white,
        child: Center(
          child: SpinKitChasingDots(
            color: Colors.black,
            size: 50.0,
          ),
        ),
      );
    } else {
      return Mainpage(uid: uid);
    }
  }

  void initialize() async {
    await service.Currency.init();
    // service.Category.add(
    //     service.Category(uid: uid, name: 'food', type: 'expense', save: true));
    // service.Category.add(service.Category(
    //     uid: uid, name: 'entertainment', type: 'expense', save: true));

    // service.Account.add(
    //     service.Account(uid: uid, name: 'cash', currency: 'MYR', save: true));
    // service.Account.add(service.Account(
    //     uid: uid, name: 'maybank', currency: 'MYR', save: true));
    await service.Category.getCategories(uid: uid);
    await service.Account.getAccounts(uid: uid);
    await service.Record.getRecords(uid: uid);
    print('system initialized!');
    setState(() {
      isLoading = false;
    });
  }
}
