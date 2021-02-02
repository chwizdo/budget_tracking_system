import 'package:budget_tracking_system/services/category.dart';
import 'package:budget_tracking_system/services/onetimebudget.dart';
import 'package:budget_tracking_system/services/periodicbudget.dart';
import 'package:budget_tracking_system/services/record.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DisableFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

class AddBudget extends StatefulWidget {
  @override
  _AddBudgetState createState() => _AddBudgetState();
}

class _AddBudgetState extends State<AddBudget> {
  // Initialized local variables for user input
  String title = "Untitled";
  Category category = Category.list[0];
  double amount = 0;
  DateTime startDate;
  DateTime endDate;
  String interval;
  String budgetstatus;

  //Creates a list of items for DropdownButton category and account.
  String currentSelectedCategory = "Food";
  List<String> categoryTypes = ["Food", "Transport", "Entertainment"];

  String currentSelectedType = "Periodic";
  List<String> budgetTypes = ["Periodic", "One-Time"];

  String currentSelectedInterval = "Weekly";
  List<String> intervalTypes = ["Weekly", "Monthly"];

  //Initialize start date, end date and date format
  DateTime _pickedStartDate;
  DateTime _pickedEndDate;
  DateFormat df = new DateFormat("dd-MM-yyyy");

  //Initialize controller
  TextEditingController _startDateEditingController = TextEditingController();
  TextEditingController _endDateEditingController = TextEditingController();

   pickStartDate() async{
    DateTime date = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year-5),
      lastDate: DateTime(DateTime.now().year+5),
      initialDate: DateTime.now(),
    );

    if (date != null) {
      setState(() {
        _pickedStartDate = date;
        _startDateEditingController.text = df.format(_pickedStartDate);
      });
    }
  }

     pickEndDate() async{
    DateTime date = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year-5),
      lastDate: DateTime(DateTime.now().year+5),
      initialDate: DateTime.now(),
    );

    if (date != null) {
      setState(() {
        _pickedEndDate = date;
        _endDateEditingController.text = df.format(_pickedEndDate);
      });
    }
  }

  displayWidget() {
    if (currentSelectedType == 'Periodic') {
      return Container(
        margin: EdgeInsets.only(left: 12.0, right: 10.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                'Interval:',
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                height: 50.0,
                child: FormField(
                  builder: (FormFieldState<String> state) {
                    return InputDecorator(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          filled: true,
                          fillColor: Color.fromRGBO(41, 41, 41, 1),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          isDense: true),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: currentSelectedInterval,
                          onChanged: (newValue) {
                            setState(() {
                              currentSelectedInterval = newValue;
                            });
                          },
                          items: intervalTypes.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          style: TextStyle(color: Colors.black),
                          selectedItemBuilder: (BuildContext context) {
                            return intervalTypes.map((String value) {
                              return Text(
                                currentSelectedInterval,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15.0),
                              );
                            }).toList();
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.only(left: 12.0, right: 10.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.only(bottom: 80.0),
                child: Text(
                  'Duration:',
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  Container(
                    height: 50.0,
                    child: TextFormField(
                      focusNode: DisableFocusNode(),
                      controller: _startDateEditingController,
                      onTap: () {
                        pickStartDate();
                      },
                      onChanged: (value) {
                        startDate = DateTime.parse(value);
                      },
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Color.fromRGBO(41, 41, 41, 1),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        prefixIcon: Icon(
                          Icons.calendar_today,
                          color: Color.fromRGBO(101, 101, 101, 1),
                        ),
                        contentPadding: EdgeInsets.all(12.0),
                        hintText: "Start Date",
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  Text(
                    '--',
                    style: TextStyle(color: Colors.white),
                  ),
                  Container(
                    height: 50.0,
                    child: TextFormField(
                      focusNode: DisableFocusNode(),
                      controller: _endDateEditingController,
                      onTap: () {
                        pickEndDate();
                      },
                      onChanged: (value) {
                        endDate = DateTime.parse(value);
                      },
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Color.fromRGBO(41, 41, 41, 1),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        prefixIcon: Icon(
                          Icons.calendar_today,
                          color: Color.fromRGBO(101, 101, 101, 1),
                        ),
                        contentPadding: EdgeInsets.all(12.0),
                        hintText: "End Date",
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }

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
        title: Text('Add Budget'),
      ),
      body: SafeArea(
        child: Container(
          child: Padding(
            //Padding for the whole body content wrapped in container.
            padding: const EdgeInsets.all(6.0),
            //ListView is used because it automatically resizes on keyboard input, whilst also supporting scrolling.
            child: ListView(children: [
              SizedBox(height: 20.0),
              //Display Title Text Field
              Container(
                margin: EdgeInsets.only(left: 12.0, right: 10.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Title:',
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        height: 50.0,
                        child: TextFormField(
                          onChanged: (val) {
                            title = val;
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

              SizedBox(height: 12.0),

              //Display Type Dropdown Field
              Container(
                margin: EdgeInsets.only(left: 12.0, right: 10.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Type:',
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        height: 50.0,
                        child: FormField(
                          builder: (FormFieldState<String> state) {
                            return InputDecorator(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  filled: true,
                                  fillColor: Color.fromRGBO(41, 41, 41, 1),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                  isDense: true),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: currentSelectedType,
                                  onChanged: (newValue) {
                                    setState(() {
                                      currentSelectedType = newValue;
                                    });
                                  },
                                  items: budgetTypes.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  style: TextStyle(color: Colors.black),
                                  selectedItemBuilder: (BuildContext context) {
                                    return budgetTypes.map((String value) {
                                      return Text(
                                        currentSelectedType,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15.0),
                                      );
                                    }).toList();
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 12.0),

              //Display Interval or Date Range Field based on Periodic/One-Time DropdownValue
              displayWidget(),

              SizedBox(height: 12.0),

              //Display Category DropdownButton Field
              Container(
                margin: EdgeInsets.only(left: 12.0, right: 10.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Text(
                        'Category:',
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                    ),
                    Expanded(
                      flex: 11,
                      child: Container(
                        height: 50.0,
                        child: FormField(
                          builder: (FormFieldState<String> state) {
                            return InputDecorator(
                              //Style the form field border.
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  filled: true,
                                  fillColor: Color.fromRGBO(41, 41, 41, 1),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                  //Use less vertical space.
                                  isDense: true),
                              child: DropdownButtonHideUnderline(
                                //Creates DropdownButton Widget.
                                child: DropdownButton<String>(
                                  //Value for the currently selected Dropdown item.
                                  value: currentSelectedCategory,
                                  //When user selects a new item, pass newValue into current item value.
                                  onChanged: (newValue) {
                                    setState(() {
                                      currentSelectedCategory = newValue;
                                    });
                                  },
                                  //Map the items from categoryTypes lists into item menu dropdown.
                                  items: categoryTypes.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  //Style the dropdown items text.
                                  style: TextStyle(color: Colors.black),
                                  selectedItemBuilder: (BuildContext context) {
                                    return categoryTypes.map((String value) {
                                      return Text(
                                        currentSelectedCategory,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15.0),
                                      );
                                    }).toList();
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.only(left: 6.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Icon(Icons.settings,
                                color: Color.fromRGBO(101, 101, 101, 1)),
                          ),
                        )),
                  ],
                ),
              ),

              SizedBox(height: 12.0),

              //Display Amount Text Field
              Container(
                margin: EdgeInsets.only(left: 12.0, right: 10.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Amount:',
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        height: 50.0,
                        child: TextFormField(
                          onChanged: (value) {
                            amount = double.parse(value);
                          },
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            filled: true,
                            fillColor: Color.fromRGBO(41, 41, 41, 1),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(left: 15.0, top: 15),
                              child: Text(
                                'RM',
                                style: TextStyle(
                                    color: Color.fromRGBO(101, 101, 101, 1)),
                              ),
                            ),
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
                    minWidth: 300.0,
                    child: RaisedButton(
                      color: Color.fromRGBO(255, 185, 49, 1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0)),
                      onPressed: () {
                        // if (currentSelectedType == "Periodic") {
                        PeriodicBudget.add(PeriodicBudget(
                            title: "pb1",
                            category: Category.list[0],
                            amount: 2000,
                            interval: "Monthly",
                            startDate: DateTime.utc(2020, 1, 1)));
                        PeriodicBudget.add(PeriodicBudget(
                            title: "pb2",
                            category: Category.list[1],
                            amount: 50,
                            interval: "Weekly",
                            startDate: DateTime.utc(2019, 1, 1)));
                        PeriodicBudget.add(PeriodicBudget(
                            title: "pb3",
                            category: Category.list[0],
                            amount: 10,
                            interval: "Monthly",
                            startDate: DateTime.utc(2021, 1, 1)));
                        // } else {
                        // OneTimeBudget.add(OneTimeBudget(
                        //     title: "buget1",
                        //     category: Category.list[0],
                        //     amount: 30,
                        //     startDate: DateTime.utc(2021, 1, 1),
                        //     endDate: DateTime.utc(2021, 1, 10)));
                        // OneTimeBudget.add(OneTimeBudget(
                        //     title: "buget2",
                        //     category: Category.list[0],
                        //     amount: 21330,
                        //     startDate: DateTime.utc(2019, 1, 2),
                        //     endDate: DateTime.utc(2021, 1, 4)));
                        // OneTimeBudget.add(OneTimeBudget(
                        //     title: "buget3",
                        //     category: Category.list[0],
                        //     amount: 340,
                        //     startDate: DateTime.utc(2021, 2, 1),
                        //     endDate: DateTime.utc(2021, 2, 10)));
                        //   OneTimeBudget.changeStatus();
                        //   print(OneTimeBudget.list[0].budgetStatus);
                        //   print(OneTimeBudget.list[1].budgetStatus);
                        //   print(OneTimeBudget.list[2].budgetStatus);
                        //   OneTimeBudget.returnList(DateTime.utc(2021, 1, 3));
                        //   print(OneTimeBudget.activeList);
                        //   print(DateTime.now().toUtc().month);
                        //   OneTimeBudget.delete(2);
                        // print(OneTimeBudget.list[2]);
                        // OneTimeBudget.budgetRecordList(
                        //     Category.list[0],
                        //     DateTime.utc(2020, 1, 02),
                        //     DateTime.utc(2020, 12, 21));
                        // OneTimeBudget.calculateAmountUsed(
                        //     Category.list[0],
                        //     DateTime.utc(2020, 1, 2),
                        //     DateTime.utc(2020, 12, 21));
                        // OneTimeBudget.calculateAmountUsed();
                        PeriodicBudget.calculateAmountUsed(
                            DateTime.utc(2020, 1));
                        print(PeriodicBudget.returnList(
                            DateTime.utc(2019, 12, 30)));

                        // }
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
            ]),
          ),
        ),
      ),
    );
  }
}
