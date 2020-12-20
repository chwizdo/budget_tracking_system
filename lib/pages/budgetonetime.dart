import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

class OneTimeRecords {
  String category, title, type, interval, budgetStatus;
  double money, moneyUsed;
  DateTime startDate, endDate;

  OneTimeRecords(
      {this.category,
      this.title,
      this.money,
      this.interval,
      this.moneyUsed,
      this.budgetStatus,
      this.startDate,
      this.endDate});
}

class RecordGroupSeparator extends StatelessWidget {
  //Initialize variable and creating a constructor
  final String status;
  RecordGroupSeparator({this.status});

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
            Expanded(
              flex: 1,
              child: Text(
                "${this.status}",
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OneTime extends StatefulWidget {
  @override
  _OneTimeState createState() => _OneTimeState();
}

class _OneTimeState extends State<OneTime> {
  //A list to store all the BudgetRecords by passing the values through using the constructor from BudgetRecords() Class.
  List recordView = [
    OneTimeRecords(
        category: 'Miscellaneuous',
        title: 'Christmas Presents',
        money: 600.0,
        interval: 'M',
        moneyUsed: 230.75,
        budgetStatus: 'Current',
        startDate: DateTime.utc(2020, 12, 20),
        endDate: DateTime.utc(2020, 12, 29),
        ),
    OneTimeRecords(
        category: 'Miscellaneuous',
        title: 'New Year Gift',
        money: 250.0,
        interval: 'M',
        moneyUsed: 0.00,
        budgetStatus: 'Up-coming',
        startDate: DateTime.utc(2020, 12, 25),
        endDate: DateTime.utc(2020, 12, 31),
        ),
    OneTimeRecords(
        category: 'Miscellaneuous',
        title: 'Double Eleven Gift',
        money: 60.0,
        interval: 'M',
        moneyUsed: 58.0,
        budgetStatus: 'Completed',
        startDate: DateTime.utc(2020, 11, 11),
        endDate: DateTime.utc(2020, 11, 12),
        ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(57, 57, 57, 1),
      body: SafeArea(
        //GroupedListView is a widget that can help group the list view by anything
        //Eg: Can group lists based on category or date.
        //DateTime object is explicitly stated so that it can group the records by date
        child: GroupedListView<dynamic, String>(
          //Elements takes in a list of data that needs to be grouped, in this case recordView's data needs to be taken in.
          elements: recordView,
          //groupBy is a function that chooses what to group given by an element.
          //In this case, we give an element named record to represent our recordView list, and we want to group by currentDate.
          groupBy: (record) => record.budgetStatus,
          //This function prepares to separate the lists by date.
          //This can be done by returning a constructor of RecordGroupSeparator() that passes currentDate to date.
          //Hence the RecordGroupSeparator() class can perform its own task which is to generate respective headers for each lists.
          groupSeparatorBuilder: (String budgetStatus) => RecordGroupSeparator(status: budgetStatus),
          //Arrange the grouped lists in descending order
          order: GroupedListOrder.DESC,
          separator: Divider(
            color: Colors.grey,
            indent: 15.0,
            endIndent: 15.0,
          ),
          padding: EdgeInsets.only(bottom: 100),
          //To build and display all the items of recordView list.
          itemBuilder: (context, dynamic record) {
            return Container(
              height: 80.0,
              //Each list is a row and is expanded to 3 parts.
              child: Row(
                children: [
                  //First part is to display the title, category and types of interval.
                  Expanded(
                    flex: 1,
                    child: ListTile(
                      title: Text(
                        record.title,
                        //Used to wrap long texts
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      subtitle: Text(
                        '${record.category} / \n'
                        'Start Date: '+ '${DateFormat('d/M/y').format(record.startDate)} \n'
                        'End Date: '+ '${DateFormat('d/M/y').format(record.endDate)} \n',
                        //Used to wrap long texts
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.grey, fontSize: 14.0),
                      ),
                    ),
                  ),
                  //Second part is to display the money budget and money used.
                  Expanded(
                    flex: 1,
                    child: ListTile(
                      //RichText is used to display texts with multiple styles.
                      trailing: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'RM ' + '${record.moneyUsed.toString()}',
                              style: TextStyle(
                                color: Colors.grey, fontSize: 14.0)),
                            TextSpan(
                              text: ' / ' + '${record.money.toString()}',
                              style: TextStyle(
                                color: Colors.white, fontSize: 14.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
