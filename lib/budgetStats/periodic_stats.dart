import 'package:flutter/material.dart';

class BudgetRecords {
  String category, title, type, interval;
  double money, moneyUsed;


  BudgetRecords({this.category, this.title, this.money, this.type, this.interval, this.moneyUsed}); 
}

class PeriodicStats extends StatefulWidget {
  @override
  _PeriodicStatsState createState() => _PeriodicStatsState();
}

class _PeriodicStatsState extends State<PeriodicStats> {

  //A list to store all the BudgetRecords by passing the values through using the constructor from BudgetRecords() Class.
  List recordView = [
    BudgetRecords(category: 'Food', title: 'Food', money: 600.0, type: 'Expenses', interval: 'M', moneyUsed: 230.75),
    BudgetRecords(category: 'Entertainment', title: 'Fun Time', money: 50.0, type: 'Expenses', interval: 'W', moneyUsed: 35.75),
    BudgetRecords(category: 'Home', title: 'Home Appliances', money: 250.0, type: 'Expenses', interval: 'M', moneyUsed: 0.00),
    BudgetRecords(category: 'Food', title: 'Snacks', money: 60.0, type: 'Expenses', interval: 'M', moneyUsed: 44.50),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(57, 57, 57, 1),
      body: ListView.separated(
        itemCount: recordView.length,
        itemBuilder: (context, index) {
          return Container(
            height: 70.0,
            //Each list is a row and is expanded to 2 parts.
            child: Row(
              children: [
                //First part is to display the title, category and types of interval.
                Expanded(
                  flex: 1,
                  child: ListTile(
                    title: Text(
                      recordView[index].title,
                      //Used to wrap long texts
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16
                      ),
                    ),
                    subtitle: Text(
                      '${recordView[index].category} /' + ' ${recordView[index].interval}',
                      //Used to wrap long texts
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.0
                      ),
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
                            text: 'RM ' + '${recordView[index].moneyUsed.toString()}',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14.0
                            )
                          ),
                          TextSpan(
                            text: ' / ' + '${recordView[index].money.toString()}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0
                            ),
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
        //Adds a divider in between lists items, no divider will be included in the first and last item from the list.
        separatorBuilder: (context, index) {
        return Divider(
            color: Colors.grey,
            indent: 15.0,
            endIndent: 15.0,
          );
        },       
      ),
    );
  }
}