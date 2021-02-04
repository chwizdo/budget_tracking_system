import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:budget_tracking_system/services/account.dart' as service;

class EditAccount extends StatefulWidget {
  final int index;
  final String uid;
  final String name;
  final String currency;
  final double amount;

  EditAccount({
    Key key,
    @required this.index,
    @required this.uid,
    @required this.name,
    @required this.currency,
    @required this.amount,
  }) : super(key: key);

  @override
  _EditAccountState createState() => _EditAccountState(
        index: index,
        uid: uid,
        name: name,
        amount: amount,
        //currency: currency,
      );
}

class _EditAccountState extends State<EditAccount> {
  final String uid;
  _EditAccountState({
    this.index,
    this.uid,
    this.name,
    this.amount,
    //this.currency,
  });

  var accountcollections = Firestore.instance.collection('users');

  int index;
  String name = 'Untitled';
  //String currency;
  double amount = 0;

  String _currentSelectedCurrency = "RM";
  List _currencyTypes = ["RM", "USD", "EUR"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(57, 57, 57, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(18, 18, 18, 1),
        title: Text('Edit Account'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.white,
            ),
            onPressed: () {
              service.Account.list[index].remove();
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          child: ListView(
            children: [
              SizedBox(height: 30.0),
              Container(
                margin: EdgeInsets.only(left: 20.0, right: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Name:',
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        height: 50.0,
                        child: TextFormField(
                          initialValue: name,
                          validator: (_val) {
                            if (_val.isEmpty) {
                              return null;
                            } else {
                              return null;
                            }
                          },
                          onChanged: (_val) {
                            name = _val;
                          },
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            //Remove visible borders
                            border: InputBorder.none,
                            //Enables color fill in the text form field.
                            filled: true,
                            fillColor: Color.fromRGBO(41, 41, 41, 1),
                            //Border when it is not focused by user input.
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            //Border when it is focused by user input.
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide:
                                    BorderSide(color: Colors.transparent)),
                            contentPadding: EdgeInsets.all(12.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.0),

              //Display Save Button
              Column(
                children: [
                  ButtonTheme(
                    height: 40.0,
                    minWidth: 350.0,
                    child: RaisedButton(
                      color: Color.fromRGBO(255, 185, 49, 1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0)),
                      onPressed: () {
                        if (name == null || amount == null) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Error Message"),
                                  content: Text(
                                      "Invalid Data Detected, Please Try Again"),
                                  actions: [
                                    FlatButton(
                                      child: Text("Close"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    )
                                  ],
                                );
                              });
                        } else {
                          service.Account.list[index].setProperties(
                            name: name,
                            amount: amount,
                          );
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        'Save',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Color.fromRGBO(41, 41, 41, 1),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
