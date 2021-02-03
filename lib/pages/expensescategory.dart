import 'package:budget_tracking_system/pages/editexpense.dart';
import 'package:budget_tracking_system/services/category.dart';
import 'package:flutter/material.dart';
import 'package:budget_tracking_system/pages/addexpense.dart';
import 'package:budget_tracking_system/services/user.dart';
import 'package:provider/provider.dart';

class Expense {
  String expenseTitle;

  Expense({this.expenseTitle});
}

class ExpensesCategory extends StatefulWidget {
  final String uid;

  ExpensesCategory({Key key, @required this.uid}) : super(key: key);

  @override
  _ExpensesCategoryState createState() => _ExpensesCategoryState(uid);
}

class _ExpensesCategoryState extends State<ExpensesCategory> {
  List<Category> expenseRecords = List.from(Category.expenseList);

  final String uid;
  _ExpensesCategoryState(this.uid);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // Remove "No Category"
    Category rmCategory;
    expenseRecords.forEach((Category category) {
      if (category == Category.getNoCat('expense')) {
        rmCategory = category;
      }
    });
    expenseRecords.remove(rmCategory);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

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
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditExpense(
                              index: index,
                              uid: user.uid,
                              name: expenseRecords[index].name,
                            ),
                        fullscreenDialog: true),
                  ).then((value) => setState(() {
                        expenseRecords = List.from(Category.expenseList);
                        Category rmCategory;
                        expenseRecords.forEach((Category category) {
                          if (category == Category.getNoCat('expense')) {
                            rmCategory = category;
                          }
                        });
                        expenseRecords.remove(rmCategory);
                      }));
                },
                title: Text(
                  expenseRecords[index].name,
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
                builder: (context) => AddExpense(
                      uid: user.uid,
                    ),
                fullscreenDialog: true),
          ).then((value) => setState(() {
                expenseRecords = List.from(Category.expenseList);
                Category rmCategory;
                expenseRecords.forEach((Category category) {
                  if (category == Category.getNoCat('expense')) {
                    rmCategory = category;
                  }
                });
                expenseRecords.remove(rmCategory);
              }));
        },
      ),
    );
  }
}
