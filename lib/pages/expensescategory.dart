import 'package:flutter/material.dart';
import 'package:budget_tracking_system/pages/addexpense.dart';

class Expense {
  String expenseTitle;

  Expense({this.expenseTitle});
}

class ExpensesCategory extends StatefulWidget {
  @override
  _ExpensesCategoryState createState() => _ExpensesCategoryState();
}

class _ExpensesCategoryState extends State<ExpensesCategory> {
  List expenseRecords = [
    Expense(expenseTitle: 'Food'),
    Expense(expenseTitle: 'Entertainment'),
    Expense(expenseTitle: 'Transport'),
    Expense(expenseTitle: 'Grocery'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(57, 57, 57, 1),
      appBar: AppBar(
        title: Text('Expense Category'),
        backgroundColor: Color.fromRGBO(18, 18, 18, 1),
      ),

      body: SafeArea(
        child: ListView.separated(
          itemCount: expenseRecords.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 50,
              child: ListTile(
                title: Text(
                  expenseRecords[index].expenseTitle,
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
          builder: (context) => AddExpense(
                //uid: user.uid,
              ),
          fullscreenDialog: true),
        );
      },
      ),
    );
  }
}