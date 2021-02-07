import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:budget_tracking_system/services/onetimebudget.dart';

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

class OneTimeStats extends StatefulWidget {
  @override
  _OneTimeStatsState createState() => _OneTimeStatsState();
}

class _OneTimeStatsState extends State<OneTimeStats> {
  @override
  Widget build(BuildContext context) {
    OneTimeBudget.calculateAmountUsed();
    OneTimeBudget.changeStatus();
    return Scaffold(
      backgroundColor: Color.fromRGBO(57, 57, 57, 1),
      body: SafeArea(
        //GroupedListView is a widget that can help group the list view by anything
        //Eg: Can group lists based on category or date.
        //DateTime object is explicitly stated so that it can group the records by date
        child: GroupedListView<dynamic, String>(
          //Elements takes in a list of data that needs to be grouped, in this case recordView's data needs to be taken in.
          elements: OneTimeBudget.list,
          //groupBy is a function that chooses what to group given by an element.
          //In this case, we give an element named record to represent our recordView list, and we want to group by currentDate.
          groupBy: (record) => record.budgetStatus,
          //This function prepares to separate the lists by date.
          //This can be done by returning a constructor of RecordGroupSeparator() that passes currentDate to date.
          //Hence the RecordGroupSeparator() class can perform its own task which is to generate respective headers for each lists.
          groupSeparatorBuilder: (String budgetStatus) =>
              RecordGroupSeparator(status: budgetStatus),
          //Arrange the grouped lists in descending order
          order: GroupedListOrder.DESC,
          separator: Divider(
            color: Colors.grey,
            indent: 15.0,
            endIndent: 15.0,
          ),
          padding: EdgeInsets.only(bottom: 100),
          //To build and display all the items of recordView list.
          indexedItemBuilder: (context, dynamic record, index) {
            return Container(
              height: 80.0,
              //Each list is a row and is expanded to 3 parts.
              child: Row(
                children: [
                  //First part is to display the title, category and types of interval.
                  Expanded(
                    flex: 1,
                    child: ListTile(
                        onTap: () {
                          Navigator.pop(context, OneTimeBudget.list[index]);
                        },
                        title: Text(
                          record.title,
                          //Used to wrap long texts
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        subtitle: record.budgetStatus == 'Up-coming'
                            ? Text(
                                '${record.category.name} / \n'
                                        'Start Date: ' +
                                    '${DateFormat('d/M/y').format(record.startDate)}',
                                //Used to wrap long texts
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 14.0),
                              )
                            : record.budgetStatus == 'Current'
                                ? Text(
                                    '${record.category.name} / \n'
                                            'End Date: ' +
                                        '${DateFormat('d/M/y').format(record.endDate)}',
                                    //Used to wrap long texts
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 14.0),
                                  )
                                : Text(
                                    '${record.category.name}',
                                    //Used to wrap long texts
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 14.0),
                                  )),
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
                                text: 'RM ' + '${record.amountUsed.toString()}',
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 14.0)),
                            TextSpan(
                              text: ' / ' + '${record.amount.toString()}',
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
