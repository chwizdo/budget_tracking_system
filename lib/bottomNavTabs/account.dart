import 'package:budget_tracking_system/pages/editaccount.dart';
import 'package:budget_tracking_system/services/user.dart';
import 'package:flutter/material.dart';
import 'package:budget_tracking_system/pages/addaccount.dart';
import 'package:provider/provider.dart';
import 'package:budget_tracking_system/services/account.dart' as service;

class AccountRecord {
  String accountName, currency;
  double amount;

  AccountRecord({this.accountName, this.amount, this.currency});
}

class Account extends StatefulWidget {
  final String uid;
  Account({Key key, @required this.uid}) : super(key: key);
  @override
  _AccountState createState() => _AccountState(uid);
}

class _AccountState extends State<Account> {
  final String uid;
  _AccountState(this.uid);

  List accountRecords = service.Account.list;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
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
                              service.Account.calAsset().toString(),
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
                              service.Account.calLiability().toString(),
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
                              service.Account.calNet().toString(),
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
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditAccount(
                                          uid: user.uid,
                                          index: index,
                                          name:
                                              service.Account.list[index].name,
                                          currency: service
                                              .Account.list[index].currency,
                                          amount: service
                                              .Account.list[index].amount,
                                        ),
                                    fullscreenDialog: true),
                              ).then((value) => setState(() {}));
                            },
                            title: Text(
                              accountRecords[index].name,
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                      Expanded(
                          flex: 1,
                          child: ListTile(
                            onTap: () {
                              print(
                                service.Account.list[index].amount,
                              );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditAccount(
                                          uid: user.uid,
                                          index: index,
                                          name:
                                              service.Account.list[index].name,
                                          currency: service
                                              .Account.list[index].currency,
                                          amount: service
                                              .Account.list[index].amount,
                                        ),
                                    fullscreenDialog: true),
                              ).then((value) => setState(() {}));
                            },
                            trailing: Text(
                              '${accountRecords[index].currency} ${accountRecords[index].amount.toStringAsFixed(2)}',
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
                      uid: user.uid,
                    ),
                fullscreenDialog: true),
          ).then((value) => setState(() {}));
        },
      ),
    );
  }
}
