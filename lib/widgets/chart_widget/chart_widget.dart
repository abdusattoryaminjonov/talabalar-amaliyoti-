import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../constands/appcolors.dart';

class ChartWidgetCard extends StatelessWidget {
  final List<double> chartData;

  const ChartWidgetCard({
    super.key,
    required this.chartData,
  });

  Color getRevenueColor(int revenue) {
    if (revenue >= 0 && revenue <= 35) {
      return Colors.green;
    } else if (revenue > 35 && revenue <= 65) {
      return Colors.orange;
    } else if (revenue > 72) {
      return Colors.red;
    }
    return Colors.blueGrey;
  }

  @override
  Widget build(BuildContext context) {
    final double total = chartData.fold(0, (a, b) => a + b);

    int totalMinutes = total.toInt();

    int hour = totalMinutes ~/ 60;
    int minute = totalMinutes % 60;

    return Card(
      color: AppColors.white,
      shadowColor: AppColors.black05,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  hour.toString(),
                  style: TextStyle(
                    fontSize: 25,
                    color: getRevenueColor(hour),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "s",
                  style: TextStyle(
                    fontSize: 25,
                    color: AppColors.appActiveBlue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 10),
                minute <= 0 ? SizedBox.shrink() : Text(
                  minute.toString(),
                  style: TextStyle(
                    fontSize: 25,
                    color: getRevenueColor(hour),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                minute <= 0 ? SizedBox.shrink() : Text(
                  "m",
                  style: TextStyle(
                    fontSize: 25,
                    color: AppColors.appActiveBlue,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            SizedBox(width: 15),

            Expanded(
              child: SizedBox(
                height: 50,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: chartData.length * 8,
                    child: BarChart(
                      BarChartData(
                        gridData: FlGridData(show: false),
                        titlesData: FlTitlesData(show: false),
                        borderData: FlBorderData(show: false),
                        barGroups: _buildBarGroups(),
                        alignment: BarChartAlignment.start,
                        barTouchData: BarTouchData(enabled: false),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }

  List<BarChartGroupData> _buildBarGroups() {
    return List.generate(chartData.length, (i) {
      final double value = chartData[i];

      Color color;
      if (value >= 0 && value <= 50) {
        color = Colors.green;
      } else if (value > 50 && value <= 120) {
        color = Colors.orange;
      } else if (value > 120) {
        color = Colors.red;
      }else {
        color = Colors.blueGrey;
      }

      return BarChartGroupData(
        x: i,
        barsSpace: 2, // barlar orasidagi masofa kichik
        barRods: [
          BarChartRodData(
            toY: value == 0 ? 0.2 : value,
            width: 6, // bar eni kichikroq
            color: color,
            borderRadius: BorderRadius.zero,
          ),
        ],
      );
    });
  }

}
