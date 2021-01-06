import 'package:flutter/material.dart';
import 'package:budget_tracking_system/data/piechart_data.dart';

class PieChartIncomeLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ListView.separated(
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            color: Colors.grey,
            indent: 15.0,
            endIndent: 15.0,
          );
        },
        shrinkWrap: true,
        itemCount: PieIncomeData.data.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 50,
            child: Row(
              children: [
                Expanded(
                    flex: 2,
                    child: ListTile(
                      leading: Container(
                        width: 16.0,
                        height: 16.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: PieIncomeData.data[index].color,
                        ),
                      ),
                      title: Text(
                        PieIncomeData.data[index].name,
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
                Expanded(
                    flex: 1,
                    child: ListTile(
                      trailing: Text(
                        ' ${PieIncomeData.data[index].amount.toStringAsFixed(2)}',
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
              ],
            ),
          );
        },
      );
}

class PieChartExpensesLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ListView.separated(
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            color: Colors.grey,
            indent: 15.0,
            endIndent: 15.0,
          );
        },
        shrinkWrap: true,
        itemCount: PieExpensesData.data.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 50,
            child: Row(
              children: [
                Expanded(
                    flex: 2,
                    child: ListTile(
                      leading: Container(
                        width: 16.0,
                        height: 16.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: PieExpensesData.data[index].color,
                        ),
                      ),
                      title: Text(
                        PieExpensesData.data[index].name,
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
                Expanded(
                    flex: 1,
                    child: ListTile(
                      trailing: Text(
                        ' ${PieExpensesData.data[index].amount.toStringAsFixed(2)}',
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
              ],
            ),
          );
        },
      );
}
