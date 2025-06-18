import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:waterapp/util/color.dart';
import 'package:waterapp/util/functions.dart';

class WaterQualityChart extends StatelessWidget {
  const WaterQualityChart({
    super.key,
    required this.dates,
    required this.values,
    required this.parameterName,
    required this.subText,
    required this.linecolor,
    required this.isHistogram,
    required this.parameterSI,
    required this.currentReading,
  });

  final List<String> dates;
  final List<double> values;
  final String parameterName;
  final Color linecolor;
  final String subText;
  final bool isHistogram;
  final String parameterSI;
  final double currentReading;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.tdscolor),
        color: Theme.of(context).colorScheme.onPrimary,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //? Title and subtitle
                  Text(
                    parameterName,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subText,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              values.isEmpty
                  ? SizedBox()
                  : Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: linecolor.withOpacity(.5),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Text(
                      '$currentReading $parameterSI',
                      style: Theme.of(
                        context,
                      ).textTheme.titleLarge!.copyWith(fontSize: 16),
                    ),
                  ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child:
                values.isEmpty || dates.isEmpty
                    ? Center(
                      child: Text(
                        'No available data',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    )
                    : isHistogram
                    ? _buildHistogram()
                    : _buildLineChart(context: context),
          ),
        ],
      ),
    );
  }

  Widget _buildLineChart({required BuildContext context}) {
    final minValue =
        (values.reduce((a, b) => a < b ? a : b) - 0.5).floorToDouble();
    final maxValue =
        (values.reduce((a, b) => a > b ? a : b) + 0.5).ceilToDouble();
    final minY =
        generateSteps(
          minValue,
          maxValue,
          steps: 5,
        ).reduce((a, b) => a < b ? a : b).toDouble();
    final maxY =
        generateSteps(
          minValue,
          maxValue,
          steps: 5,
        ).reduce((a, b) => a > b ? a : b).toDouble();

    return LineChart(
      LineChartData(
        gridData: const FlGridData(show: true),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 50,
              getTitlesWidget: (value, meta) {
                return Text(
                  '${value.toStringAsFixed(1)} $parameterSI',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.white70,
                    fontSize: parameterSI.isEmpty ? 12 : 9,
                  ),
                );
              },
            ),
          ),
          // bottomTitles: AxisTitles(
          //   sideTitles: SideTitles(
          //     showTitles: true,

          //     getTitlesWidget: (value, meta) {
          //       if (value.toInt() >= dates.length) {
          //         return const SizedBox.shrink();
          //       }

          //       return Padding(
          //         padding: const EdgeInsets.only(top: 8.0, right: 8),
          //         child: Text(
          //           dates[value.toInt()],
          //           style: const TextStyle(color: Colors.white70, fontSize: 10),
          //         ),
          //       );
          //     },
          //   ),
          // ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        borderData: FlBorderData(show: false),
        minX: 0,
        maxX: (dates.length).toDouble() - 1,
        minY: minY,
        maxY: maxY,
        lineBarsData: [
          LineChartBarData(
            spots: List.generate(
              values.length,
              (index) => FlSpot(index.toDouble(), values[index]),
            ),
            isCurved: true,
            barWidth: 1.5,

            color: linecolor,
            dotData: const FlDotData(show: true),
            belowBarData: BarAreaData(show: false),
          ),
        ],
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((spot) {
                return LineTooltipItem(
                  '${spot.y.toStringAsFixed(1)} $parameterSI',
                  Theme.of(context).textTheme.bodySmall!,
                );
              }).toList();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHistogram() {
    final minValue = (values.reduce((a, b) => a < b ? a : b)).floorToDouble();
    final maxValue = (values.reduce((a, b) => a > b ? a : b)).ceilToDouble();
    // final minY =
    //     generateSteps(
    //       minValue,
    //       maxValue,
    //       steps: 5,
    //     ).reduce((a, b) => a < b ? a : b).toDouble();
    final maxY =
        generateSteps(
          minValue,
          maxValue,
          steps: 5,
        ).reduce((a, b) => a > b ? a : b).toDouble();
    // final stepValues = generateSteps(minValue, maxValue, steps: 5);
    return BarChart(
      BarChartData(
        gridData: const FlGridData(show: true, drawVerticalLine: false),
        titlesData: FlTitlesData(
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          // bottomTitles: AxisTitles(
          //   sideTitles: SideTitles(
          //     showTitles: true,
          //     getTitlesWidget: (value, meta) {
          //       if (value.toInt() >= dates.length) {
          //         return SizedBox.shrink();
          //       }
          //       return Padding(
          //         padding: const EdgeInsets.only(top: 8.0),
          //         child: Text(
          //           dates[value.toInt()],
          //           style: const TextStyle(color: Colors.white70, fontSize: 11),
          //         ),
          //       );
          //     },
          //   ),
          // ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),

          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                // if (value.toInt() >= dates.length) {
                //   return SizedBox.shrink();
                // }
                return Text(
                  '${value.toStringAsFixed(0)} $parameterSI',
                  style: const TextStyle(color: Colors.white70, fontSize: 10),
                );
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        minY: 0,
        maxY: maxY,

        barGroups: List.generate(values.length, (index) {
          return BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(
                toY: values[index].toDouble(),
                color: linecolor,
                width: 12,
                borderRadius: BorderRadius.zero,
              ),
            ],
          );
        }),
      ),
    );
  }
}
