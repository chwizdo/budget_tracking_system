import 'package:flutter/material.dart';
import 'package:budget_tracking_system/services/category.dart';

class EditExpense extends StatefulWidget {
  final int index;
  final String uid;
  String name;

  EditExpense({
    Key key,
    @required this.index,
    @required this.uid,
    @required this.name,
  }) : super(key: key);

  @override
  _EditExpenseState createState() => _EditExpenseState(
        index: index,
        uid: uid,
        name: name,
      );
}

class _EditExpenseState extends State<EditExpense> {
  final int index;
  final String uid;
  String name;

  List<Category> expenseRecords = List.from(Category.expenseList);

  _EditExpenseState({
    this.index,
    this.uid,
    this.name,
  });

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
    return Scaffold(
      backgroundColor: Color.fromRGBO(57, 57, 57, 1),
      appBar: AppBar(
        title: Text('Edit Expense Category'),
        backgroundColor: Color.fromRGBO(18, 18, 18, 1),
        actions: [
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.white,
            ),
            onPressed: () {
              expenseRecords[index].remove();
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
                          onChanged: (String value) {
                            name = value;
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

              SizedBox(height: 30.0),
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
                        expenseRecords[index].setProperties(name: name);
                        Navigator.pop(context);
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
