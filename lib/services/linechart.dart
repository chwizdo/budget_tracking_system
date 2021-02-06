import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DisplayLineChart extends StatefulWidget {
  @override
  _DisplayLineChartState createState() => _DisplayLineChartState();
}

class _DisplayLineChartState extends State<DisplayLineChart> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  @override
  Widget build(BuildContext context) {
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
                  case 1:
                    return '100';
                  case 3:
                    return '300';
                  case 5:
                    return '500';
                }
                return '';
              },
              reservedSize: 28,
              margin: 12,
            ),
          ),
          extraLinesData: ExtraLinesData(horizontalLines: [
            HorizontalLine(
              y: 4,
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
                spots: [
                  FlSpot(0, 0.3),
                  FlSpot(1, 0.5),
                  FlSpot(2, 5),
                  FlSpot(3, 3.1),
                  FlSpot(4, 4),
                  FlSpot(5, 3),
                  FlSpot(6, 4),
                ],
                isCurved: true,
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
  }
}
