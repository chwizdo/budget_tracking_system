import 'package:flutter/material.dart';
import 'package:budget_tracking_system/pages/addincome.dart';

class Income {
  String incomeTitle;

  Income({this.incomeTitle});
}

class IncomeCategory extends StatefulWidget {
  @override
  _IncomeCategoryState createState() => _IncomeCategoryState();
}

class _IncomeCategoryState extends State<IncomeCategory> {

  List incomeRecords = [
    Income(incomeTitle: 'Salary'),
    Income(incomeTitle: 'Investment'),
  ];

  @override
  Widget build(BuildContext context) {
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
                title: Text(
                  incomeRecords[index].incomeTitle,
                  style: TextStyle(
                    color: Colors.white
                  ),
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
        style: TextStyle(
          fontSize: 25.0,
          color: Color.fromRGBO(41, 41, 41, 1)
        ),
      ),
      backgroundColor: Color.fromRGBO(255, 185, 49, 1),
      onPressed: () {
        Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddIncome(
                //uid: user.uid,
              ),
          fullscreenDialog: true),
        );
      },
      ),
    );
  }
}