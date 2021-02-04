import 'package:budget_tracking_system/services/category.dart';
import 'package:flutter/material.dart';
import 'package:budget_tracking_system/services/record.dart' as service;
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:budget_tracking_system/pages/editrecord.dart';
import 'package:budget_tracking_system/services/user.dart';
import 'package:provider/provider.dart';

//A separator class that is responsible for grouping the list based on day by creating a new container/header for each list.
class RecordGroupSeparator extends StatelessWidget {
  //Initialize variable and creating a constructor
  final DateTime date;
  RecordGroupSeparator({this.date});

  @override
  Widget build(BuildContext context) {
    //Creates a container box which has these properties
    return Container(
      decoration: BoxDecoration(color: Color.fromRGBO(41, 41, 41, 1)),
      height: 50,
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0),
        //The header is a row and has 2 parts
        child: Row(
          children: [
            //The first part is to display the day of the month from date.
            //Eg: If the record was added on 2020/12/19, it will display 19.
            Flexible(
              child: Text(
                "${this.date.day}.${this.date.month}.${this.date.year}",
                style: TextStyle(color: Colors.white, fontSize: 22.0),
              ),
            ),
            //This second part is to display the exact day of the month.
            //Eg: Tuesday
          ],
        ),
      ),
    );
  }
}

class SearchRecord extends StatefulWidget {
  final String uid;

  SearchRecord({Key key, @required this.uid}) : super(key: key);
  @override
  _SearchRecordState createState() => _SearchRecordState(uid);
}

class _SearchRecordState extends State<SearchRecord> {
  final String uid;
  _SearchRecordState(this.uid);

  bool checkedValue = false;

  String currentSelectedCategory = "Food";
  List<String> categoryTypes = ["Food", "Transport", "Entertainment"];

  String currentSelectedAccount = "Cash";
  List<String> accountTypes = ["Cash", "maybank", "credit card"];

  //Initialize controller
  TextEditingController _searchEditingController = TextEditingController();

  //Initialize lists
  List<service.Record> _recordList = [];

  String title = '';
  String category = Category.expenseList[0].name;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(57, 57, 57, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(18, 18, 18, 1),
        title: Text('Search Records'),
      ),
      body: SafeArea(
        child: Container(
          //ListView is used because it automatically resizes on keyboard input, whilst also supporting scrolling.
          child: Column(children: [
            SizedBox(height: 20.0),
            //Display Search Text Field
            Theme(
              data: Theme.of(context).copyWith(
                  accentColor: Color.fromRGBO(255, 185, 49, 1),
                  unselectedWidgetColor: Colors.grey),
              child: ExpansionTile(
                tilePadding: EdgeInsets.only(left: 0.0, right: 6.0),
                title: Container(
                  margin: EdgeInsets.only(left: 12.0, right: 10.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 8,
                        child: Container(
                          height: 50.0,
                          child: TextFormField(
                            controller: _searchEditingController,
                            onChanged: (text) {
                              setState(() {
                                title = text;
                                _recordList = service.Record.search(
                                    title: title, category: category);
                              });
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
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
                                //Border when it is focused by user input.
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    borderSide:
                                        BorderSide(color: Colors.transparent)),
                                contentPadding: EdgeInsets.all(12.0),
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Color.fromRGBO(101, 101, 101, 1),
                                ),
                                hintText: 'Search',
                                hintStyle: TextStyle(color: Colors.grey)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                children: [
                  SizedBox(height: 12.0),

                  //Display DateTime Picker Field
                  Container(
                    margin: EdgeInsets.only(left: 12.0, right: 10.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 80.0),
                            child: Text(
                              'Duration:',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18.0),
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
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    filled: true,
                                    fillColor: Color.fromRGBO(41, 41, 41, 1),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide:
                                          BorderSide(color: Colors.transparent),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide:
                                          BorderSide(color: Colors.transparent),
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
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    filled: true,
                                    fillColor: Color.fromRGBO(41, 41, 41, 1),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide:
                                          BorderSide(color: Colors.transparent),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide:
                                          BorderSide(color: Colors.transparent),
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
                  ),

                  SizedBox(height: 12.0),

                  //Display Interval or Date Range Field based on Periodic/One-Time DropdownValue
                  Container(
                    margin: EdgeInsets.only(left: 12.0, right: 10.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            'Category:',
                            style:
                                TextStyle(color: Colors.white, fontSize: 18.0),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            height: 50.0,
                            child: FormField(
                              validator: (newvalue) {
                                if (newvalue.isEmpty) {
                                  return null;
                                } else {
                                  return null;
                                }
                              },
                              builder: (FormFieldState<String> state) {
                                return InputDecorator(
                                  //Style the form field border.
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      filled: true,
                                      fillColor: Color.fromRGBO(41, 41, 41, 1),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        borderSide: BorderSide(
                                            color: Colors.transparent),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        borderSide: BorderSide(
                                            color: Colors.transparent),
                                      ),
                                      //Use less vertical space.
                                      isDense: true),
                                  child: DropdownButtonHideUnderline(
                                    //Creates DropdownButton Widget.
                                    child: DropdownButton<String>(
                                      //Value for the currently selected Dropdown item.
                                      value: currentSelectedCategory,
                                      //When user selects a new item, pass newValue into current item value.
                                      onChanged: (text) {
                                        setState(() {
                                          category = text;
                                          _recordList = service.Record.search(
                                              title: title, category: category);
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
                                      selectedItemBuilder:
                                          (BuildContext context) {
                                        return categoryTypes
                                            .map((String value) {
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
                      ],
                    ),
                  ),

                  SizedBox(height: 12.0),

                  //Display Category DropdownButton Field
                  Container(
                    margin: EdgeInsets.only(left: 12.0, right: 10.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            'Account:',
                            style:
                                TextStyle(color: Colors.white, fontSize: 18.0),
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        borderSide: BorderSide(
                                            color: Colors.transparent),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        borderSide: BorderSide(
                                            color: Colors.transparent),
                                      ),
                                      isDense: true),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: currentSelectedAccount,
                                      onChanged: (newValue) {
                                        setState(() {
                                          currentSelectedAccount = newValue;
                                          //account = newValue;
                                        });
                                      },
                                      items: accountTypes.map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      style: TextStyle(color: Colors.black),
                                      selectedItemBuilder:
                                          (BuildContext context) {
                                        return accountTypes.map((String value) {
                                          return Text(
                                            currentSelectedAccount,
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

                  //Display Amount Text Field
                  Container(
                    margin: EdgeInsets.only(left: 12.0, right: 10.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 80.0),
                            child: Text(
                              'Amount:',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18.0),
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
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    filled: true,
                                    fillColor: Color.fromRGBO(41, 41, 41, 1),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide:
                                          BorderSide(color: Colors.transparent),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide:
                                          BorderSide(color: Colors.transparent),
                                    ),
                                    prefixIcon: Padding(
                                      padding:
                                          EdgeInsets.only(left: 15.0, top: 15),
                                      child: Text(
                                        'RM',
                                        style: TextStyle(
                                            color: Color.fromRGBO(
                                                101, 101, 101, 1)),
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.all(12.0),
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
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    filled: true,
                                    fillColor: Color.fromRGBO(41, 41, 41, 1),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide:
                                          BorderSide(color: Colors.transparent),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide:
                                          BorderSide(color: Colors.transparent),
                                    ),
                                    prefixIcon: Padding(
                                      padding:
                                          EdgeInsets.only(left: 15.0, top: 15),
                                      child: Text(
                                        'RM',
                                        style: TextStyle(
                                            color: Color.fromRGBO(
                                                101, 101, 101, 1)),
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.all(12.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 10.0),

                  //Display Attachment Field

                  ListTileTheme(
                    contentPadding: EdgeInsets.all(0.0),
                    child: Container(
                      margin: EdgeInsets.only(left: 12.0, right: 5.0),
                      child: CheckboxListTile(
                        title: Text(
                          "Attachment Present:",
                          style: TextStyle(color: Colors.white, fontSize: 18.0),
                        ),
                        value: checkedValue,
                        onChanged: (bool newValue) {
                          setState(() {
                            checkedValue = newValue;
                          });
                        },
                        controlAffinity: ListTileControlAffinity
                            .trailing, //  <-- trailing Checkbox
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),
            Expanded(
              child: GroupedListView<dynamic, DateTime>(
                  //Elements takes in a list of data that needs to be grouped, in this case recordView's data needs to be taken in.
                  elements: _recordList,
                  //groupBy is a function that chooses what to group given by an element.
                  //In this case, we give an element named record to represent our recordView list, and we want to group by currentDate.
                  groupBy: (record) {
                    return DateTime(
                      record.dateTime.year,
                      record.dateTime.month,
                      record.dateTime.day,
                    );
                  },
                  //This function prepares to separate the lists by date.
                  //This can be done by returning a constructor of RecordGroupSeparator() that passes currentDate to date.
                  //Hence the RecordGroupSeparator() class can perform its own task which is to generate respective headers for each lists.
                  groupSeparatorBuilder: (DateTime dateTime) =>
                      RecordGroupSeparator(date: dateTime),
                  //Arrange the grouped lists in descending order
                  order: GroupedListOrder.DESC,
                  itemComparator: (item1, item2) =>
                      item1.dateTime.hour.compareTo(item2.dateTime.hour),
                  useStickyGroupSeparators: true,
                  separator: Divider(
                    color: Colors.grey,
                    indent: 15.0,
                    endIndent: 15.0,
                  ),
                  //padding: EdgeInsets.only(bottom: 100),
                  //To build and display all the items of recordView list.
                  indexedItemBuilder: (context, dynamic record, index) {
                    return Container(
                      height: 70.0,
                      //Each list is a row and is expanded to 3 parts.
                      child: Row(
                        children: [
                          //First part is to display the category.
                          Expanded(
                            flex: 4,
                            child: ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditRecord(
                                            uid: user.uid,
                                            index:
                                                _recordList.length - 1 - index,
                                            type: _recordList[
                                                    _recordList.length -
                                                        1 -
                                                        index]
                                                .type,
                                            title: _recordList[
                                                    _recordList.length -
                                                        1 -
                                                        index]
                                                .title,
                                            dateTime: _recordList[
                                                    _recordList.length -
                                                        1 -
                                                        index]
                                                .dateTime,
                                            category: _recordList[
                                                    _recordList.length -
                                                        1 -
                                                        index]
                                                .category,
                                            account: _recordList[
                                                    _recordList.length -
                                                        1 -
                                                        index]
                                                .account,
                                            amount: _recordList[
                                                    _recordList.length -
                                                        1 -
                                                        index]
                                                .amount,
                                            note: _recordList[
                                                    _recordList.length -
                                                        1 -
                                                        index]
                                                .note,
                                            isFav: _recordList[
                                                    _recordList.length -
                                                        1 -
                                                        index]
                                                .isFav,
                                          ),
                                      fullscreenDialog: true),
                                ).then((value) => setState(() {}));
                              },
                              leading: record.type != 'Transfer'
                                  ? Text(
                                      record.category.name,
                                      //Used to wrap long texts
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 14),
                                    )
                                  : Text(
                                      'Transfer',
                                      //Used to wrap long texts
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 14),
                                    ),
                            ),
                          ),
                          //Second part is to display the title.
                          Expanded(
                            flex: 9,
                            child: ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditRecord(
                                            uid: user.uid,
                                            index:
                                                _recordList.length - 1 - index,
                                            type: _recordList[
                                                    _recordList.length -
                                                        1 -
                                                        index]
                                                .type,
                                            title: _recordList[
                                                    _recordList.length -
                                                        1 -
                                                        index]
                                                .title,
                                            dateTime: _recordList[
                                                    _recordList.length -
                                                        1 -
                                                        index]
                                                .dateTime,
                                            category: _recordList[
                                                    _recordList.length -
                                                        1 -
                                                        index]
                                                .category,
                                            account: _recordList[
                                                    _recordList.length -
                                                        1 -
                                                        index]
                                                .account,
                                            amount: _recordList[
                                                    _recordList.length -
                                                        1 -
                                                        index]
                                                .amount,
                                            note: _recordList[
                                                    _recordList.length -
                                                        1 -
                                                        index]
                                                .note,
                                            isFav: _recordList[
                                                    _recordList.length -
                                                        1 -
                                                        index]
                                                .isFav,
                                          ),
                                      fullscreenDialog: true),
                                ).then((value) => setState(() {}));
                              },
                              title: Text(
                                record.title,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Colors.white),
                              ),
                              subtitle: record.type != 'Transfer'
                                  ? Text(
                                      record.account.name,
                                      style: TextStyle(color: Colors.grey),
                                    )
                                  : Text(
                                      '${record.account.name} - ${record.toAccount.name}',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                            ),
                          ),
                          //Third part is to display the money.
                          Expanded(
                            flex: 7,
                            child: ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditRecord(
                                            uid: user.uid,
                                            index:
                                                _recordList.length - 1 - index,
                                            type: _recordList[_recordList.length -
                                                    1 -
                                                    index]
                                                .type,
                                            title: _recordList[_recordList.length -
                                                    1 -
                                                    index]
                                                .title,
                                            dateTime: _recordList[_recordList.length -
                                                    1 -
                                                    index]
                                                .dateTime,
                                            category: _recordList[_recordList.length -
                                                    1 -
                                                    index]
                                                .category,
                                            account: _recordList[_recordList.length -
                                                    1 -
                                                    index]
                                                .account,
                                            amount: _recordList[_recordList.length -
                                                    1 -
                                                    index]
                                                .amount,
                                            note: _recordList[_recordList.length -
                                                    1 -
                                                    index]
                                                .note,
                                            isFav: _recordList[_recordList.length -
                                                    1 -
                                                    index]
                                                .isFav,
                                          ),
                                      fullscreenDialog: true),
                                ).then((value) => setState(() {}));
                              },
                              //An if else statement is used to check whether it is an expense or income
                              //If it is expenses, add '-' in front of money, else add '+'
                              trailing: record.type == 'Expenses'
                                  ? Text(
                                      "- ${record.account.currency} " +
                                          record.amount.toStringAsFixed(2),
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14.0),
                                    )
                                  : Text(
                                      "+ ${record.account.currency} " +
                                          record.amount.toStringAsFixed(2),
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14.0),
                                    ),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            ),
          ]),
        ),
      ),
    );
  }
}
