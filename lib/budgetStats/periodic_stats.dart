import 'package:flutter/material.dart';
import 'package:budget_tracking_system/services/periodicbudget.dart';

class PeriodicStats extends StatefulWidget {
  @override
  _PeriodicStatsState createState() => _PeriodicStatsState();
}

class _PeriodicStatsState extends State<PeriodicStats> {
  @override
  Widget build(BuildContext context) {
    PeriodicBudget.calculateAmountUsed();
    return Scaffold(
      backgroundColor: Color.fromRGBO(57, 57, 57, 1),
      body: ListView.separated(
        itemCount: PeriodicBudget.list.length,
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
                    onTap: () {
                      Navigator.pop(context, PeriodicBudget.list[index]);
                    },
                    title: Text(
                      PeriodicBudget.list[index].title,
                      //Used to wrap long texts
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    subtitle: Text(
                      '${PeriodicBudget.list[index].category.name} /' +
                          ' ${PeriodicBudget.list[index].interval}',
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
                              text: 'RM ' +
                                  '${PeriodicBudget.list[index].amountUsed.toString()}',
                              style: TextStyle(
                                  color: Colors.grey, fontSize: 14.0)),
                          TextSpan(
                            text: ' / ' +
                                '${PeriodicBudget.list[index].amount.toString()}',
                            style:
                                TextStyle(color: Colors.white, fontSize: 14.0),
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
