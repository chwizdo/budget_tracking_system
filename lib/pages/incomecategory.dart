import 'package:budget_tracking_system/services/category.dart';
import 'package:flutter/material.dart';
import 'package:budget_tracking_system/pages/addincome.dart';
import 'package:budget_tracking_system/pages/editincome.dart';
import 'package:budget_tracking_system/services/user.dart';
import 'package:provider/provider.dart';

class Income {
  String incomeTitle;

  Income({this.incomeTitle});
}

class IncomeCategory extends StatefulWidget {
  final String uid;

  IncomeCategory({Key key, @required this.uid}) : super(key: key);

  @override
  _IncomeCategoryState createState() => _IncomeCategoryState(uid);
}

class _IncomeCategoryState extends State<IncomeCategory> {
  List incomeRecords = Category.incomeList;

  final String uid;
  _IncomeCategoryState(this.uid);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return Scaffold(
      backgroundColor: Color.fromRGBO(57, 57, 57, 1),
      appBar: AppBar(
        title: Text('Income Category'),
        backgroundColor: Color.fromRGBO(18, 18, 18, 1),
      ),

      body: SafeArea(
        child: ListView.separated(
          itemCount: incomeRecords.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 50,
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditIncome(
                              index: index,
                              uid: user.uid,
                              name: incomeRecords[index].name,
                            ),
                        fullscreenDialog: true),
                  ).then((value) => setState(() {}));
                },
                title: Text(
                  incomeRecords[index].name,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              color: Colors.grey,
              indent: 15.0,
              endIndent: 15.0,
            );
          },
        ),
      ),
      //This button can be navigated to add records page.
      floatingActionButton: FloatingActionButton(
        child: Text(
          "+",
          style:
              TextStyle(fontSize: 25.0, color: Color.fromRGBO(41, 41, 41, 1)),
        ),
        backgroundColor: Color.fromRGBO(255, 185, 49, 1),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddIncome(
                      uid: user.uid,
                    ),
                fullscreenDialog: true),
          ).then((value) => setState(() {}));
        },
      ),
    );
  }
}
