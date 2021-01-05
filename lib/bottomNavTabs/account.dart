import 'package:flutter/material.dart';
import 'package:budget_tracking_system/pages/addaccount.dart';

class AccountRecord {
  String accountName, currency;
  double amount;

  AccountRecord({this.accountName, this.amount, this.currency});
}

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  List accountRecords = [
    AccountRecord(accountName: 'Account Maybank - MYR', amount: 34700.00, currency: 'RM'),
    AccountRecord(accountName: 'Account Maybank - USD',amount: 13500.00,currency: 'USD'),
    AccountRecord(accountName: 'Card', amount: 250.00, currency: 'RM'),
    AccountRecord(accountName: 'Cash - MYR', amount: 1000.00, currency: 'RM'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(57, 57, 57, 1),
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(18, 18, 18, 1),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          title: Center(
                            child: Text(
                              'Asset',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          subtitle: Center(
                            child: Text(
                              '93332.20',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          title: Center(
                            child: Text(
                              'Liability',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          subtitle: Center(
                            child: Text(
                              '655.00',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          title: Center(
                            child: Text(
                              'Net',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          subtitle: Center(
                            child: Text(
                              '9267730.50',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ListView.separated(
              shrinkWrap: true,
              itemCount: accountRecords.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 50,
                  child: Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: ListTile(
                            title: Text(
                              accountRecords[index].accountName,
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                      Expanded(
                          flex: 1,
                          child: ListTile(
                            trailing: Text(
                              '${accountRecords[index].currency}' +
                                  ' ${accountRecords[index].amount.toStringAsFixed(2)}',
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                    ],
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
            )
          ],
        ),
      ),
      //This button can be navigated to add account page.
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
                builder: (context) => AddAccount(
                    //uid: user.uid,
                    ),
                fullscreenDialog: true),
          );
        },
      ),
    );
  }
}
