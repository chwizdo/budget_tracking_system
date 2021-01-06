import 'package:flutter/material.dart';
import 'package:budget_tracking_system/pages/budgetperiodic.dart';
import 'package:budget_tracking_system/pages/budgetonetime.dart';
import 'package:budget_tracking_system/pages/addbudget.dart';

class Budget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(57, 57, 57, 1),
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TabBar(
                labelColor: Color.fromRGBO(255, 185, 49, 1),
                indicatorColor: Color.fromRGBO(255, 185, 49, 1),
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(text: "Periodic",),
                  Tab(text: "One-Time",),
                ],
              ),
            ],
          ),
        ),

        body: SafeArea(
          child: TabBarView(
            children: [
              Periodic(),
              OneTime(),
            ],
          ),
        ),

        //This button can be navigated to add budget page.
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
                builder: (context) => AddBudget(
                      //uid: user.uid,
                    ),
                fullscreenDialog: true),
              );
          },
        ),
      ),
    );
  }
}
