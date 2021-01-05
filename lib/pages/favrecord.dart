import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

class Records {
  String category;
  String title;
  String account; 
  String type;
  double money;
  DateTime currentDate;

  Records({this.category, this.title, this.account, this.money, this.type, this.currentDate});
  
}

class RecordGroupSeparator extends StatelessWidget {

  final DateTime date;
  RecordGroupSeparator({this.date});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Color.fromRGBO(41, 41, 41, 1)),
      height: 50,
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Row(
          children: [
            Expanded(
            flex: 1,
            child: Text(
                "${this.date.year}/${this.date.month}/${this.date.day}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20
                ),
              ),
            ),
          ],  
        ),
      ),
    );
  }
}

class FavouriteRecord extends StatefulWidget {
  @override
  _FavouriteRecordState createState() => _FavouriteRecordState();
}

class _FavouriteRecordState extends State<FavouriteRecord> {
  List recordView = [
    Records(category: 'Food', title: 'McD Fried Chicken', account: 'Maybank', money: 13.50, type: 'Expenses', currentDate: DateTime.utc(2020, 12, 18, 14, 20, 55)),
    Records(category: 'Food', title: 'Blueberry Waffle', account: 'Cash', money: 4.50, type: 'Expenses', currentDate: DateTime.utc(2020, 12, 20, 17, 33, 20)),
    Records(category: 'Transport', title: 'Fuel', account: 'Maybank', money: 54.60, type: 'Expenses', currentDate: DateTime.utc(2020, 12, 20, 21, 34, 20)),
    Records(category: 'Entertainment', title: 'Avenger End Game', account: 'Maybank', money: 17.50, type: 'Expenses', currentDate: DateTime.utc(2020, 11, 19, 8, 20, 55)),
    Records(category: 'Food', title: 'Starbucks Coffee', account: 'Maybank', money: 17.50, type: 'Expenses', currentDate: DateTime.utc(2020, 12, 18, 16, 30, 27)),
    // Records(category: 'Food', title: 'Starbucks Coffee', account: 'Maybank', money: 17.50, type: 'Expenses', currentDate: DateTime.utc(2020, 12, 18)),
    // Records(category: 'Food', title: 'Starbucks Coffee', account: 'Maybank', money: 17.50, type: 'Expenses', currentDate: DateTime.utc(2020, 12, 30)),
    // Records(category: 'Food', title: 'Chicken Rice', account: 'Maybank', money: 17.50, type: 'Expenses', currentDate: DateTime.utc(2020, 12, 29)),
    // Records(category: 'Food', title: 'Fried Rice', account: 'Maybank', money: 17.50, type: 'Expenses', currentDate: DateTime.utc(2020, 12, 29)),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Color.fromRGBO(18, 18, 18, 1),
        title: Text('Favourite Records'),
      ),

      body: SafeArea(
          child: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(57, 57, 57, 1)),
          child: GroupedListView<dynamic, DateTime>(
            elements: recordView,
            groupBy: (record) {
              return DateTime(
                record.currentDate.year,
                record.currentDate.month,
                record.currentDate.day
              );
            }, 
            groupSeparatorBuilder: (DateTime currentDate) => RecordGroupSeparator(date: currentDate),
            order: GroupedListOrder.DESC,
             separator: Divider(
              color: Colors.grey,
              indent: 15.0,
              endIndent: 15.0,
            ),
            itemComparator: (item1,item2) => item1.currentDate.hour.compareTo(item2.currentDate.hour),
            padding: EdgeInsets.only(bottom: 100),
            itemBuilder: (context, dynamic record){         
                return Container(
                  height: 70,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: ListTile(
                          leading: Text(
                            record.category,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 9,
                        child: ListTile(
                          title: Text(
                            record.title,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            record.account,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                       Expanded(
                        flex: 5,
                        child: ListTile(
                          trailing: record.type == 'Expenses' ?
                            Text(
                              "- RM " + record.money.toStringAsFixed(2),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13.0
                                ),
                              )
                              :Text(
                              "+ RM " + record.money.toStringAsFixed(2),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13.0
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
      ),
    );
  }
}