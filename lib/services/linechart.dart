import 'package:budget_tracking_system/services/onetimebudget.dart';
import 'package:budget_tracking_system/services/periodicbudget.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DisplayLineChart extends StatefulWidget {
  final dynamic budget;
  DateTime dateTime;
  bool type;
  DisplayLineChart({dynamic budget, DateTime dateTime, bool type})
      : budget = budget,
        dateTime = dateTime,
        type = type;

  static set datetime(DateTime dateTime) {
    dateTime = dateTime;
  }

  @override
  _DisplayLineChartState createState() =>
      _DisplayLineChartState(budget: budget, dateTime: dateTime, type: type);
}

class _DisplayLineChartState extends State<DisplayLineChart> {
  final dynamic budget;
  final DateTime dateTime;
  bool type;
  _DisplayLineChartState({this.budget, this.dateTime, this.type});

  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  List<FlSpot> returnSpotListPeriodicAllMonth() {
    List<FlSpot> list = [];
    double y;
    double x = 0;
    List<dynamic> budgetEachDayAmount =
        PeriodicBudget.findEachMonthAmount(widget.budget, widget.dateTime);
    budgetEachDayAmount.forEach((element) {
      y = element / (returnAmount() / 6);
      list.add(FlSpot(x, y));
      x++;
    });
    return list;
  }

  List<FlSpot> returnSpotListPeriodic() {
    List<FlSpot> list = [];
    double xcounter = 0;
    double y;
    // int counter = 0;
    double sum = 0;
    List<dynamic> budgetEachDayAmount =
        PeriodicBudget.findEachDayAmount(widget.budget, widget.dateTime);
    budgetEachDayAmount.forEach((element) {
      sum += element;
      y = sum / (returnAmount() / 6);
      // if (xcounter % 3 == 0) {
      list.add(FlSpot(xcounter / 3, y));

      // }
      xcounter++;

      // counter++;
    });
    return list;
  }

  List<FlSpot> returnSpotListOneTime() {
    List<FlSpot> list = [];
    double y;
    int x = widget.budget.startDate.day;
    double sum = 0;
    List<dynamic> budgetEachDayAmount =
        OneTimeBudget.findEachDayAmount(widget.budget, widget.dateTime);
    budgetEachDayAmount.forEach((element) {
      sum += element;
      y = sum / (returnAmount() / 6);
      if (element > 0) {
        list.add(FlSpot((x / 3).toDouble(), y));
      }
      x++;
    });
    print(list);
    return list;
  }

  double returnAmount() {
    double amount = widget.budget.amount;
    return amount;
  }

  // int _calHighestPeriodic() {
  //   double total = 0;
  //   int i;
  //   List<dynamic> budgetEachDayAmount =
  //       PeriodicBudget.findEachDayAmount(widget.budget, widget.dateTime);
  //   budgetEachDayAmount.forEach((element) {
  //     total += element;
  //   });
  //   i = total.round().ceil();
  //   return i;
  // }

  @override
  Widget build(BuildContext context) {
    if (widget.budget != null &&
        widget.budget.runtimeType == PeriodicBudget &&
        widget.type == false) {
      print("linechart " + widget.dateTime.toString());
      return Padding(
        padding:
            const EdgeInsets.only(right: 16.0, left: 12.0, top: 24, bottom: 12),
        child: LineChart(
          LineChartData(
            minX: 0,
            maxX: 10,
            minY: 0,
            maxY: 10,
            gridData: FlGridData(
              show: true,
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color: Colors.grey,
                  strokeWidth: 1,
                );
              },
              drawVerticalLine: true,
              getDrawingVerticalLine: (value) {
                return FlLine(
                  color: Colors.grey,
                  strokeWidth: 1,
                );
              },
            ),
            titlesData: FlTitlesData(
              show: true,
              bottomTitles: SideTitles(
                showTitles: true,
                reservedSize: 26,
                getTextStyles: (value) => const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
                getTitles: (value) {
                  switch (value.toInt()) {
                    case 2:
                      return '7';
                    case 5:
                      return '16';
                    case 8:
                      return '25';
                  }
                  return '';
                },
                margin: 8,
              ),
              leftTitles: SideTitles(
                showTitles: true,
                getTextStyles: (value) => const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                getTitles: (value) {
                  switch (value.toInt()) {
                    case 0:
                      return '0';
                    case 2:
                      return (returnAmount() * 1 / 3).round().toString();
                    case 4:
                      return (returnAmount() * 2 / 3).round().toString();
                    case 6:
                      return returnAmount().round().toString();
                    case 8:
                      return (returnAmount() * 4 / 3).round().toString();
                  }
                  return '';
                },
                reservedSize: 28,
                margin: 12,
              ),
            ),
            extraLinesData: ExtraLinesData(horizontalLines: [
              HorizontalLine(
                y: 6,
                color: Colors.orange.withOpacity(0.8),
                strokeWidth: 3,
                dashArray: [20, 2],
              ),
            ]),
            borderData: FlBorderData(
              show: true,
              border: Border.all(color: const Color(0xff37434d), width: 1),
            ),
            lineBarsData: [
              LineChartBarData(
                  spots: returnSpotListPeriodic(),
                  isCurved: false,
                  colors: gradientColors,
                  barWidth: 5.0,
                  belowBarData: BarAreaData(
                    show: true,
                    colors: gradientColors
                        .map((color) => color.withOpacity(0.3))
                        .toList(),
                  ))
            ],
          ),
        ),
      );
    } else if (widget.budget != null &&
        widget.budget.runtimeType == PeriodicBudget &&
        widget.type == true) {
      print("runhere " + widget.dateTime.toString());
      return Padding(
        padding:
            const EdgeInsets.only(right: 16.0, left: 12.0, top: 24, bottom: 12),
        child: LineChart(
          LineChartData(
            minX: 0,
            maxX: 11,
            minY: 0,
            maxY: 10,
            gridData: FlGridData(
              show: true,
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color: Colors.grey,
                  strokeWidth: 1,
                );
              },
              drawVerticalLine: true,
              getDrawingVerticalLine: (value) {
                return FlLine(
                  color: Colors.grey,
                  strokeWidth: 1,
                );
              },
            ),
            titlesData: FlTitlesData(
              show: true,
              bottomTitles: SideTitles(
                showTitles: true,
                reservedSize: 26,
                getTextStyles: (value) => const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
                getTitles: (value) {
                  switch (value.toInt()) {
                    case 2:
                      return 'MAR';
                    case 5:
                      return 'JUN';
                    case 8:
                      return 'SEP';
                  }
                  return '';
                },
                margin: 8,
              ),
              leftTitles: SideTitles(
                showTitles: true,
                getTextStyles: (value) => const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                getTitles: (value) {
                  switch (value.toInt()) {
                    case 0:
                      return '0';
                    case 2:
                      return (returnAmount() * 1 / 3).round().toString();
                    case 4:
                      return (returnAmount() * 2 / 3).round().toString();
                    case 6:
                      return returnAmount().round().toString();
                    case 8:
                      return (returnAmount() * 4 / 3).round().toString();
                  }
                  return '';
                },
                reservedSize: 28,
                margin: 12,
              ),
            ),
            extraLinesData: ExtraLinesData(horizontalLines: [
              HorizontalLine(
                y: 6,
                color: Colors.orange.withOpacity(0.8),
                strokeWidth: 3,
                dashArray: [20, 2],
              ),
            ]),
            borderData: FlBorderData(
              show: true,
              border: Border.all(color: const Color(0xff37434d), width: 1),
            ),
            lineBarsData: [
              LineChartBarData(
                  spots: returnSpotListPeriodicAllMonth(),
                  isCurved: false,
                  colors: gradientColors,
                  barWidth: 5.0,
                  belowBarData: BarAreaData(
                    show: true,
                    colors: gradientColors
                        .map((color) => color.withOpacity(0.3))
                        .toList(),
                  ))
            ],
          ),
        ),
      );
    } else if (widget.budget != null &&
        widget.budget.runtimeType == OneTimeBudget) {
      return Padding(
        padding:
            const EdgeInsets.only(right: 16.0, left: 12.0, top: 24, bottom: 12),
        child: LineChart(
          LineChartData(
            minX: 0,
            maxX: 10,
            minY: 0,
            maxY: 10,
            gridData: FlGridData(
              show: true,
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color: Colors.grey,
                  strokeWidth: 1,
                );
              },
              drawVerticalLine: true,
              getDrawingVerticalLine: (value) {
                return FlLine(
                  color: Colors.grey,
                  strokeWidth: 1,
                );
              },
            ),
            titlesData: FlTitlesData(
              show: true,
              bottomTitles: SideTitles(
                showTitles: true,
                reservedSize: 26,
                getTextStyles: (value) => const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
                getTitles: (value) {
                  switch (value.toInt()) {
                    case 2:
                      return '7';
                    case 5:
                      return '16';
                    case 8:
                      return '25';
                  }
                  return '';
                },
                margin: 8,
              ),
              leftTitles: SideTitles(
                showTitles: true,
                getTextStyles: (value) => const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                getTitles: (value) {
                  switch (value.toInt()) {
                    case 0:
                      return '0';
                    case 2:
                      return (returnAmount() * 1 / 3).round().toString();
                    case 4:
                      return (returnAmount() * 2 / 3).round().toString();
                    case 6:
                      return returnAmount().round().toString();
                    case 8:
                      return (returnAmount() * 4 / 3).round().toString();
                  }
                  return '';
                },
                reservedSize: 28,
                margin: 12,
              ),
            ),
            extraLinesData: ExtraLinesData(horizontalLines: [
              HorizontalLine(
                y: 6,
                color: Colors.orange.withOpacity(0.8),
                strokeWidth: 3,
                dashArray: [20, 2],
              ),
            ]),
            borderData: FlBorderData(
              show: true,
              border: Border.all(color: const Color(0xff37434d), width: 1),
            ),
            lineBarsData: [
              LineChartBarData(
                  spots: returnSpotListOneTime(),
                  isCurved: false,
                  colors: gradientColors,
                  barWidth: 5.0,
                  belowBarData: BarAreaData(
                    show: true,
                    colors: gradientColors
                        .map((color) => color.withOpacity(0.3))
                        .toList(),
                  ))
            ],
          ),
        ),
      );
    } else
      return Container();
  }
}
