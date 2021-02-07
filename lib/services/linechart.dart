import 'package:budget_tracking_system/services/onetimebudget.dart';
import 'package:budget_tracking_system/services/periodicbudget.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DisplayLineChart extends StatefulWidget {
  final dynamic budget;
  DateTime dateTime;
  DisplayLineChart({dynamic budget, DateTime dateTime})
      : budget = budget,
        dateTime = dateTime;

  static set datetime(DateTime dateTime) {
    dateTime = dateTime;
  }

  @override
  _DisplayLineChartState createState() =>
      _DisplayLineChartState(budget: budget, dateTime: dateTime);
}

class _DisplayLineChartState extends State<DisplayLineChart> {
  final dynamic budget;
  final DateTime dateTime;
  _DisplayLineChartState({this.budget, this.dateTime});

  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  List<FlSpot> flSpotList = [
    FlSpot(0, 0.3),
    FlSpot(1, 0.5),
    FlSpot(2, 5),
    FlSpot(3, 3.1),
    FlSpot(4, 4),
    FlSpot(5, 3),
    FlSpot(6, 4),
  ];

  List<FlSpot> returnSpotListPeriodic() {
    List<FlSpot> list = [];
    double xcounter = 0;
    double y;
    List<dynamic> budgetEachMonthAmount =
        PeriodicBudget.findEachDayAmount(widget.budget, dateTime);
    budgetEachMonthAmount.forEach((element) {
      y = element / (_calHighestPeriodic() / 5);
      list.add(FlSpot(xcounter, y));
      xcounter++;
    });
    return list;
  }

  int _calHighestPeriodic() {
    double highest = 0;
    int i;
    List<dynamic> budgetEachMonthAmount =
        PeriodicBudget.findEachDayAmount(widget.budget, dateTime);
    budgetEachMonthAmount.forEach((element) {
      if (element > highest) {
        highest = element;
      }
    });
    i = highest.round().ceil();
    return i;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.budget != null && widget.budget.runtimeType == PeriodicBudget) {
      if (_calHighestPeriodic() > 0) {
        print("linechart " + widget.budget.title.toString());
        return Padding(
          padding: const EdgeInsets.only(
              right: 16.0, left: 12.0, top: 24, bottom: 12),
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
                      case 1:
                        return (_calHighestPeriodic() / 5).toString();
                      case 2:
                        return (_calHighestPeriodic() / 2.5).toString();
                      case 3:
                        return (_calHighestPeriodic() / 5 * 3).toString();
                      case 4:
                        return (_calHighestPeriodic() / 1.25).toString();
                      case 5:
                        return _calHighestPeriodic().toString();
                    }
                    return '';
                  },
                  reservedSize: 28,
                  margin: 12,
                ),
              ),
              extraLinesData: ExtraLinesData(horizontalLines: [
                HorizontalLine(
                  y: 5,
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
      } else {
        print("this is no record");
        return Container();
      }
    } else if (widget.budget != null &&
        widget.budget.runtimeType == OneTimeBudget) {
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
                      return '0';
                    case 4:
                      return '0';
                    case 6:
                      return '0';
                    case 8:
                      return '0';
                    case 10:
                      return '0';
                  }
                  return '';
                },
                reservedSize: 28,
                margin: 12,
              ),
            ),
            extraLinesData: ExtraLinesData(horizontalLines: [
              HorizontalLine(
                y: 5,
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
                  spots: flSpotList,
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
